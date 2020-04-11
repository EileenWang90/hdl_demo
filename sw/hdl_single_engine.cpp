/*
 * Copyright 2019 International Business Machines
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <errno.h>
#include <malloc.h>
#include <unistd.h>
#include <sys/time.h>
#include <time.h>
#include <math.h>
#include <getopt.h>
#include <ctype.h>

#include <libosnap.h>
//#include <libocxl.h>
#include <osnap_tools.h>
#include <osnap_global_regs.h>

#include <dirent.h>
#include "hdl_single_engine.h"
#include "conv10_w_arrays.h"
#include "process_lib.h"
#include <iostream>
#include <vector>

/*  defaults */
#define ACTION_WAIT_TIME    50   /* Default in sec */

#define MEGAB       (1024*1024ull)
#define GIGAB       (1024 * MEGAB)

#define VERBOSE0(fmt, ...) do {         \
    printf(fmt, ## __VA_ARGS__);    \
} while (0)

#define VERBOSE1(fmt, ...) do {         \
    if (verbose_level > 0)          \
    printf(fmt, ## __VA_ARGS__);    \
} while (0)

#define VERBOSE2(fmt, ...) do {         \
    if (verbose_level > 1)          \
    printf(fmt, ## __VA_ARGS__);    \
} while (0)


#define VERBOSE3(fmt, ...) do {         \
    if (verbose_level > 2)          \
    printf(fmt, ## __VA_ARGS__);    \
} while (0)

#define VERBOSE4(fmt, ...) do {         \
    if (verbose_level > 3)          \
    printf(fmt, ## __VA_ARGS__);    \
} while (0)

static const char* version = GIT_VERSION;
static  int verbose_level = 2;

static uint64_t get_usec (void)
{
    struct timeval t;

    gettimeofday (&t, NULL);
    return t.tv_sec * 1000000 + t.tv_usec;
}

static void* alloc_mem (uint32_t align, uint64_t bytes)
{
    void* a;
    uint64_t bytes2 = bytes + align;

    VERBOSE2 ("%s Enter Align: %d Size: %ld\n", __func__, align, bytes);

    if (posix_memalign ((void**)&a, align, bytes2) != 0) {
        perror ("FAILED: posix_memalign()");
        return NULL;
    }

    VERBOSE2 ("%s Exit %p\n", __func__, a);
    return a;
}

static void free_mem (void* a)
{
    VERBOSE2 ("Free Mem %p\n", a);

    if (a) {
        free (a);
    }
}

/* Action or Kernel Write and Read are 32 bit MMIO */
static void action_write (struct snap_card* h, uint32_t addr, uint32_t data)
{
    int rc;

    rc = snap_action_write32 (h, (uint64_t)addr, data);

    if (0 != rc) {
        VERBOSE0 ("Write MMIO 32 Err\n");
    }

    return;
}

static uint32_t action_read(struct snap_card* h, uint32_t addr)
{
    int rc;
    uint32_t data;

    rc = snap_action_read32(h, (uint64_t)addr, &data);
    if (0 != rc)
        VERBOSE0("Read MMIO 32 Err\n");
    return data;
}

static struct snap_action* get_action (struct snap_card* handle,
        snap_action_flag_t flags, uint32_t timeout)
{
    struct snap_action* act;

    act = snap_attach_action (handle, ACTION_TYPE_HDL_COMPUTING,
            flags, timeout);

    if (NULL == act) {
        VERBOSE0 ("Error: Can not attach Action: %x\n", ACTION_TYPE_HDL_COMPUTING);
        VERBOSE0 ("       Try to run snap_main tool\n");
    }

    return act;
}

static void usage (const char* prog)
{
    VERBOSE0 ("SNAP String Match (Regular Expression Match) Tool.\n");
    VERBOSE0 ("Usage: %s\n"
            "    -h, --help              | Prints usage information\n"
            "    -v, --verbose           | Verbose mode\n"
            "    -C, --card <cardno>     | Card to be used for operation\n"
            "    -V, --version           | Print Version\n"
            "    -t, --timeout           | Timeout after N sec (default 1 sec)\n"
            "    -I, --image             | input image\n"
            "    -c, --test_count <arg>  | Total number of runtime for each run. Can be set to a large number\n" 
            "                            | for performance test so that we can get the average performance of \n"
            "                            | all the runs.\n"
            "    -D, --dir               | in_dir(include input images).\n"
            , prog);
}

int main (int argc, char* argv[])
{
    char device[64];
    char img_path[64];
    char image_dir[50]={"/home/wyt/CNN/image_dir"};
    const char* image = NULL;
    const char* indir = NULL;
    DIR *dir = NULL;
    struct dirent *entry;
    struct snap_card* dn;   /* lib snap handle */
    int card_no = 0;
    int cmd;
    int rc = 1;
    uint32_t i;
    //uint32_t timeout = ACTION_WAIT_TIME;
    uint32_t timeout = 3600;
    struct snap_action* act = NULL;
    uint32_t size_4KB = 4096;
    FILE * file_target;
    FILE * file_expect;
    uint64_t time_used = 100;
    uint64_t time_used_array[65536];
    //uint32_t test_count; // repetition count of a test: for performance test, a test should be repeated for several times and the average performance should be calculated. test_count should be less than 65536
    long index = -1; //current classification result
    long num = 0; //the number of the file(image) in indir
    long process_suc = 0; //when AFU finish one operate(done=1),process_suc++
    std::vector<long> result_index;

    void* image_addr=NULL;
    void* conv1_base=NULL;
    void* pool1_base=NULL;
    void* f2s_base=NULL;
    void* f2e_base=NULL;
    void* f3s_base=NULL;
    void* f3e_base=NULL;
    void* pool3_base=NULL;
    void* f4s_base=NULL;
    void* f4e_base=NULL;
    void* f5s_base=NULL;
    void* f5e_base=NULL;
    void* pool5_base=NULL;
    void* f6s_base=NULL;
    void* f6e_base=NULL;
    void* f7s_base=NULL;
    void* f7e_base=NULL;
    void* f8s_base=NULL;
    void* f8e_base=NULL;
    void* f9s_base=NULL;
    void* f9e_base=NULL;
    void* conv10_base=NULL;
    void* conv10_weight_base=NULL;
    
    //Default value
    //test_count = 5;

    // while (1) {
    //     int option_index = 0;
    //     static struct option long_options[] = {
    //         { "help"       , no_argument       , NULL , 'h' } ,
    //         { "card"       , required_argument , NULL , 'C' } ,
    //         { "verbose"    , no_argument       , NULL , 'v' } ,
    //         { "version"    , no_argument       , NULL , 'V' } ,
    //         { "timeout"    , required_argument , NULL , 't' } ,
    //         { "image"      , required_argument , NULL , 'I' } ,
    //         { "indir"     , required_argument , NULL , 'D' } ,
    //         { "test_count" , required_argument , NULL , 'c' } ,
    //         { 0            , no_argument       , NULL , 0   } 
    //     };
    //     cmd = getopt_long (argc, argv, "hC:vVt:I:c:D:",
    //             long_options, &option_index);

    //     if (cmd == -1) { /* all params processed ? */
    //         break;
    //     }

    //     switch (cmd) {
    //         case 'v':   /* verbose */
    //             verbose_level++;
    //             break;

    //         case 'V':   /* version */
    //             VERBOSE0 ("%s\n", version);
    //             exit (EXIT_SUCCESS);;

    //         case 'h':   /* help */
    //             usage (argv[0]);
    //             exit (EXIT_SUCCESS);;

    //         case 'C':   /* card */
    //             card_no = strtol (optarg, (char**)NULL, 0);
    //             break;

    //         case 't':
    //             timeout = strtol (optarg, (char**)NULL, 0); /* in sec */
    //             break;

    //         case 'I':      /* image */
    //             image = optarg;/* input image */
    //             VERBOSE0 ("%s\n", image);
    //             break;

    //         case 'c':
    //             test_count = strtol (optarg, (char**)NULL, 0);
    //             break;

    //         case 'D':
    //             indir = optarg;/* input dir */
    //             VERBOSE0 ("%s\n", indir);
    //             break;

    //         default:
    //             usage (argv[0]);
    //             exit (EXIT_FAILURE);
    //     }
    // }// while(1)

    // if((indir == NULL)&&(image == NULL)){
    //     VERBOSE0("No input dir or image specified!\n");
    //     usage (argv[0]);
    //     exit (EXIT_FAILURE);
    // }
    
    // if(indir){
        indir = image_dir;//to fix the indir
        VERBOSE0("The dir is %s.\n",indir);
        dir = opendir(indir);

        if(dir == NULL){
        VERBOSE0("opendir failed!\n");
        usage (argv[0]);
        exit (EXIT_FAILURE);
        }
    // }

    //************************************initialize**********************************************
    //-------------------------------------------------
    // Open Card
    //-------------------------------------------------
    VERBOSE2 ("Open Card: %d\n", card_no);
    if(card_no == 0)
        snprintf(device, sizeof(device)-1, "IBM,oc-snap");
    else
        snprintf(device, sizeof(device)-1, "/dev/ocxl/IBM,oc-snap.000%d:00:00.1.0", card_no);

    dn = snap_card_alloc_dev (device, SNAP_VENDOR_ID_IBM, SNAP_DEVICE_ID_SNAP);
    if (NULL == dn) {
        errno = ENODEV;
        VERBOSE0 ("ERROR: snap_card_alloc_dev(%s)\n", device);
        return -1;
    }

    //-------------------------------------------------
    // Attach Action
    //-------------------------------------------------
    VERBOSE0 ("Start to get action.\n");
    snap_action_flag_t attach_flags = 0;
    act = get_action (dn, attach_flags, timeout);

    if (NULL == act) {
        goto __exit1;
    }

    //-------------------------------------------------
    // Prepare buffers
    //-------------------------------------------------
    VERBOSE0 ("Prepare source and tgt buffers.\n");

    image_addr = alloc_mem (size_4KB, 2*3*227*227);
    conv1_base = alloc_mem (size_4KB, 2*64*113*113);
    pool1_base = alloc_mem (size_4KB, 2*64*56*56);
    f2s_base = alloc_mem (size_4KB, 2*16*56*56);
    f2e_base = alloc_mem (size_4KB, 2*128*56*56);
    f3s_base = alloc_mem (size_4KB, 2*16*56*56);
    f3e_base = alloc_mem (size_4KB, 2*128*56*56);
    pool3_base = alloc_mem (size_4KB, 2*128*28*28);
    f4s_base = alloc_mem (size_4KB, 2*32*28*28);
    f4e_base = alloc_mem (size_4KB, 2*256*28*28);
    f5s_base = alloc_mem (size_4KB, 2*32*28*28);
    f5e_base = alloc_mem (size_4KB, 2*256*28*28);
    pool5_base = alloc_mem (size_4KB, 2*256*14*14);
    f6s_base = alloc_mem (size_4KB, 2*48*14*14);
    f6e_base = alloc_mem (size_4KB, 2*384*14*14);
    f7s_base = alloc_mem (size_4KB, 2*48*14*14);
    f7e_base = alloc_mem (size_4KB, 2*384*14*14);
    f8s_base = alloc_mem (size_4KB, 2*64*14*14);
    f8e_base = alloc_mem (size_4KB, 2*512*14*14);
    f9s_base = alloc_mem (size_4KB, 2*64*14*14);
    f9e_base = alloc_mem (size_4KB, 2*512*14*14);
    conv10_base = alloc_mem (size_4KB, 2*1000*14*14);
    conv10_weight_base = alloc_mem (size_4KB, 1*512*1000);

    memset (image_addr, 0, 2*3*227*227);
    memset (conv1_base, 0, 2*64*113*113);
    memset (pool1_base, 0, 2*64*56*56);
    memset (f2s_base, 0, 2*16*56*56);
    memset (f2e_base, 0, 2*128*56*56);
    memset (f3s_base, 0, 2*16*56*56);
    memset (f3e_base, 0, 2*128*56*56);
    memset (pool3_base, 0, 2*128*28*28);
    memset (f4s_base, 0, 2*32*28*28);
    memset (f4e_base, 0, 2*256*28*28);
    memset (f5s_base, 0, 2*32*28*28);
    memset (f5e_base, 0, 2*256*28*28);
    memset (pool5_base, 0, 2*256*14*14);
    memset (f6s_base, 0, 2*48*14*14);
    memset (f6e_base, 0, 2*384*14*14);
    memset (f7s_base, 0, 2*48*14*14);
    memset (f7e_base, 0, 2*384*14*14);
    memset (f8s_base, 0, 2*64*14*14);
    memset (f8e_base, 0, 2*512*14*14);
    memset (f9s_base, 0, 2*64*14*14);
    memset (f9e_base, 0, 2*512*14*14);
    memset (conv10_base, 0, 2*1000*14*14);
    memcpy (conv10_weight_base, &conv10_w[0], 1*512*1000);

    VERBOSE0 ("image_addr is: %p\n", image_addr);
    VERBOSE0 ("conv1_base is: %p\n", conv1_base);
    VERBOSE0 ("pool1_base is: %p\n", pool1_base);
    VERBOSE0 ("f2s_base is: %p\n", f2s_base);
    VERBOSE0 ("f2e_base is: %p\n", f2e_base);
    VERBOSE0 ("f3s_base is: %p\n", f3s_base);
    VERBOSE0 ("f3e_base is: %p\n", f3e_base);
    VERBOSE0 ("pool3_base is: %p\n", pool3_base);
    VERBOSE0 ("f4s_base is: %p\n", f4s_base);
    VERBOSE0 ("f4e_base is: %p\n", f4e_base);
    VERBOSE0 ("f5s_base is: %p\n", f5s_base);
    VERBOSE0 ("f5e_base is: %p\n", f5e_base);
    VERBOSE0 ("pool5_base is: %p\n", pool5_base);
    VERBOSE0 ("f6s_base is: %p\n", f6s_base);
    VERBOSE0 ("f6e_base is: %p\n", f6e_base);
    VERBOSE0 ("f7s_base is: %p\n", f7s_base);
    VERBOSE0 ("f7e_base is: %p\n", f7e_base);
    VERBOSE0 ("f8s_base is: %p\n", f8s_base);
    VERBOSE0 ("f8e_base is: %p\n", f8e_base);
    VERBOSE0 ("f9s_base is: %p\n", f9s_base);
    VERBOSE0 ("f9e_base is: %p\n", f9e_base);
    VERBOSE0 ("conv10_base is: %p\n", conv10_base);
    VERBOSE0 ("conv10_weight_base is %p\n", conv10_weight_base);

    //-------------------------------------------------
    // Start action and configure registers
    //-------------------------------------------------
    VERBOSE0 ("Start AFU.\n");
    VERBOSE0 (" ----- START SNAP_CONTROL ----- \n");
    snap_action_start ((void*)dn);//Then FPGA REG_snap_control[0]=1 (flow SNAP_CONTROL[snap_start]=1)

    VERBOSE0 (" ----- CONFIG PARAMETERS ----- \n");

    action_write(dn, REG_CONV1_READ_H, (uint32_t) ((((uint64_t) image_addr) >> 32) & 0xffffffff));
    action_write(dn, REG_CONV1_READ_L, (uint32_t) (((uint64_t) image_addr) & 0xffffffff));
    action_write(dn, REG_CONV1_WRITE_H, (uint32_t) ((((uint64_t) conv1_base) >> 32) & 0xffffffff));
    action_write(dn, REG_CONV1_WRITE_L, (uint32_t) (((uint64_t) conv1_base) & 0xffffffff));

    action_write(dn, REG_POOL1_READ_H, (uint32_t) ((((uint64_t) conv1_base) >> 32) & 0xffffffff));
    action_write(dn, REG_POOL1_READ_L, (uint32_t) (((uint64_t) conv1_base) & 0xffffffff));
    action_write(dn, REG_POOL1_WRITE_H, (uint32_t) ((((uint64_t) pool1_base) >> 32) & 0xffffffff));
    action_write(dn, REG_POOL1_WRITE_L, (uint32_t) (((uint64_t) pool1_base) & 0xffffffff));

    action_write(dn, REG_F2_S_READ_H, (uint32_t) ((((uint64_t) pool1_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F2_S_READ_L, (uint32_t) (((uint64_t) pool1_base) & 0xffffffff));
    action_write(dn, REG_F2_S_WRITE_H, (uint32_t) ((((uint64_t) f2s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F2_S_WRITE_L, (uint32_t) (((uint64_t) f2s_base) & 0xffffffff));

    action_write(dn, REG_F2_E_READ_H, (uint32_t) ((((uint64_t) f2s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F2_E_READ_L, (uint32_t) (((uint64_t) f2s_base) & 0xffffffff));
    action_write(dn, REG_F2_E_WRITE_H, (uint32_t) ((((uint64_t) f2e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F2_E_WRITE_L, (uint32_t) (((uint64_t) f2e_base) & 0xffffffff));

    action_write(dn, REG_F3_S_READ_H, (uint32_t) ((((uint64_t) f2e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F3_S_READ_L, (uint32_t) (((uint64_t) f2e_base) & 0xffffffff));
    action_write(dn, REG_F3_S_WRITE_H, (uint32_t) ((((uint64_t) f3s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F3_S_WRITE_L, (uint32_t) (((uint64_t) f3s_base) & 0xffffffff));

    action_write(dn, REG_F3_E_READ_H, (uint32_t) ((((uint64_t) f3s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F3_E_READ_L, (uint32_t) (((uint64_t) f3s_base) & 0xffffffff));
    action_write(dn, REG_F3_E_WRITE_H, (uint32_t) ((((uint64_t) f3e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F3_E_WRITE_L, (uint32_t) (((uint64_t) f3e_base) & 0xffffffff));

    action_write(dn, REG_POOL3_READ_H, (uint32_t) ((((uint64_t) f3e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_POOL3_READ_L, (uint32_t) (((uint64_t) f3e_base) & 0xffffffff));
    action_write(dn, REG_POOL3_WRITE_H, (uint32_t) ((((uint64_t) pool3_base) >> 32) & 0xffffffff));
    action_write(dn, REG_POOL3_WRITE_L, (uint32_t) (((uint64_t) pool3_base) & 0xffffffff));

    action_write(dn, REG_F4_S_READ_H, (uint32_t) ((((uint64_t) pool3_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F4_S_READ_L, (uint32_t) (((uint64_t) pool3_base) & 0xffffffff));
    action_write(dn, REG_F4_S_WRITE_H, (uint32_t) ((((uint64_t) f4s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F4_S_WRITE_L, (uint32_t) (((uint64_t) f4s_base) & 0xffffffff));

    action_write(dn, REG_F4_E_READ_H, (uint32_t) ((((uint64_t) f4s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F4_E_READ_L, (uint32_t) (((uint64_t) f4s_base) & 0xffffffff));
    action_write(dn, REG_F4_E_WRITE_H, (uint32_t) ((((uint64_t) f4e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F4_E_WRITE_L, (uint32_t) (((uint64_t) f4e_base) & 0xffffffff));

    action_write(dn, REG_F5_S_READ_H, (uint32_t) ((((uint64_t) f4e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F5_S_READ_L, (uint32_t) (((uint64_t) f4e_base) & 0xffffffff));
    action_write(dn, REG_F5_S_WRITE_H, (uint32_t) ((((uint64_t) f5s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F5_S_WRITE_L, (uint32_t) (((uint64_t) f5s_base) & 0xffffffff));

    action_write(dn, REG_F5_E_READ_H, (uint32_t) ((((uint64_t) f5s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F5_E_READ_L, (uint32_t) (((uint64_t) f5s_base) & 0xffffffff));
    action_write(dn, REG_F5_E_WRITE_H, (uint32_t) ((((uint64_t) f5e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F5_E_WRITE_L, (uint32_t) (((uint64_t) f5e_base) & 0xffffffff));

    action_write(dn, REG_POOL5_READ_H, (uint32_t) ((((uint64_t) f5e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_POOL5_READ_L, (uint32_t) (((uint64_t) f5e_base) & 0xffffffff));
    action_write(dn, REG_POOL5_WRITE_H, (uint32_t) ((((uint64_t) pool5_base) >> 32) & 0xffffffff));
    action_write(dn, REG_POOL5_WRITE_L, (uint32_t) (((uint64_t) pool5_base) & 0xffffffff));

    action_write(dn, REG_F6_S_READ_H, (uint32_t) ((((uint64_t) pool5_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F6_S_READ_L, (uint32_t) (((uint64_t) pool5_base) & 0xffffffff));
    action_write(dn, REG_F6_S_WRITE_H, (uint32_t) ((((uint64_t) f6s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F6_S_WRITE_L, (uint32_t) (((uint64_t) f6s_base) & 0xffffffff));

    action_write(dn, REG_F6_E_READ_H, (uint32_t) ((((uint64_t) f6s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F6_E_READ_L, (uint32_t) (((uint64_t) f6s_base) & 0xffffffff));
    action_write(dn, REG_F6_E_WRITE_H, (uint32_t) ((((uint64_t) f6e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F6_E_WRITE_L, (uint32_t) (((uint64_t) f6e_base) & 0xffffffff));

    action_write(dn, REG_F7_S_READ_H, (uint32_t) ((((uint64_t) f6e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F7_S_READ_L, (uint32_t) (((uint64_t) f6e_base) & 0xffffffff));
    action_write(dn, REG_F7_S_WRITE_H, (uint32_t) ((((uint64_t) f7s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F7_S_WRITE_L, (uint32_t) (((uint64_t) f7s_base) & 0xffffffff));

    action_write(dn, REG_F7_E_READ_H, (uint32_t) ((((uint64_t) f7s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F7_E_READ_L, (uint32_t) (((uint64_t) f7s_base) & 0xffffffff));
    action_write(dn, REG_F7_E_WRITE_H, (uint32_t) ((((uint64_t) f7e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F7_E_WRITE_L, (uint32_t) (((uint64_t) f7e_base) & 0xffffffff));

    action_write(dn, REG_F8_S_READ_H, (uint32_t) ((((uint64_t) f7e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F8_S_READ_L, (uint32_t) (((uint64_t) f7e_base) & 0xffffffff));
    action_write(dn, REG_F8_S_WRITE_H, (uint32_t) ((((uint64_t) f8s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F8_S_WRITE_L, (uint32_t) (((uint64_t) f8s_base) & 0xffffffff));

    action_write(dn, REG_F8_E_READ_H, (uint32_t) ((((uint64_t) f8s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F8_E_READ_L, (uint32_t) (((uint64_t) f8s_base) & 0xffffffff));
    action_write(dn, REG_F8_E_WRITE_H, (uint32_t) ((((uint64_t) f8e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F8_E_WRITE_L, (uint32_t) (((uint64_t) f8e_base) & 0xffffffff));

    action_write(dn, REG_F9_S_READ_H, (uint32_t) ((((uint64_t) f8e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F9_S_READ_L, (uint32_t) (((uint64_t) f8e_base) & 0xffffffff));
    action_write(dn, REG_F9_S_WRITE_H, (uint32_t) ((((uint64_t) f9s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F9_S_WRITE_L, (uint32_t) (((uint64_t) f9s_base) & 0xffffffff));

    action_write(dn, REG_F9_E_READ_H, (uint32_t) ((((uint64_t) f9s_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F9_E_READ_L, (uint32_t) (((uint64_t) f9s_base) & 0xffffffff));
    action_write(dn, REG_F9_E_WRITE_H, (uint32_t) ((((uint64_t) f9e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_F9_E_WRITE_L, (uint32_t) (((uint64_t) f9e_base) & 0xffffffff));

    action_write(dn, REG_CONV10_READ_H, (uint32_t) ((((uint64_t) f9e_base) >> 32) & 0xffffffff));
    action_write(dn, REG_CONV10_READ_L, (uint32_t) (((uint64_t) f9e_base) & 0xffffffff));
    action_write(dn, REG_CONV10_WRITE_H, (uint32_t) ((((uint64_t) conv10_base) >> 32) & 0xffffffff));
    action_write(dn, REG_CONV10_WRITE_L, (uint32_t) (((uint64_t) conv10_base) & 0xffffffff));

    action_write(dn, REG_CONV10_WEIGHT_H, (uint32_t) ((((uint64_t) conv10_weight_base) >> 32) & 0xffffffff));
    action_write(dn, REG_CONV10_WEIGHT_L, (uint32_t) (((uint64_t) conv10_weight_base) & 0xffffffff)); 

    //************************************loop for image processing**********************************************
    //-------------------------------------------------
    // Start Engine and wait done
    //-------------------------------------------------
    VERBOSE0 ("Start AFU.\n");

    int is_finish = 0;
    while( (entry = readdir(dir)) != NULL || ((entry = readdir(dir)) == NULL && is_finish < 21)){
    //for(i=0; i<test_count;i++) {
        int rc         = 0;
        int read_error = 0;
        int write_error= 0;
        int done  = 0;
        uint64_t t_start;
        uint32_t cnt;
        uint32_t reg_data;


        if(entry != NULL){
            if(entry->d_type != 8){ //d_type==8: file; d_type==4: dir;
                continue;
            }
            num++;
            image = entry->d_name;      		  
            VERBOSE0("filename%ld = %s\n",num,image); 

            if(image){
                // printf("Please input next image:");
                // scanf("%s",image);
                snprintf(img_path, sizeof(img_path)-1, "%s/%s",indir,image);//joint the img_dir and image_name 
                VERBOSE0("img_path is %s.\n",img_path);
                rc = read_mat(img_path, image_addr);
                if(rc) continue; //if rc!=0, then read_mat is not successful.
            }
        }
        
        if(entry == NULL){ //to deal with the final process(when the image is all enter FPGA but not finish processing them)
            is_finish++;
            num++;
            VERBOSE0("is_finish=%d.\nfilename%ld = %s\n",is_finish,num,image); 
        }

        VERBOSE0 (" ----- Tell AFU to kick off AXI transactions ----- \n");
        action_write(dn, REG_USER_CONTROL, 0x00000001);//then FPGA REG_user_control[0]=1 (flow CONTROL[start]=1)
        
        t_start = get_usec();

        cnt = 0;
        do { 
            reg_data = action_read(dn, REG_USER_STATUS);
            if ((reg_data & 0x1) == 0x1 ){
                done = 1;
                VERBOSE0 ("AFU has finished %ld transactions.\n",num);
                process_suc++;
                // if(entry == NULL){ //to deal with the final process(when the image is all enter FPGA but not finish processing them)
                //     is_finish++;
                // }
                break;
            }
            if ((reg_data & 0x04) > 0 ){
                read_error = 1;
                VERBOSE0 ("ERROR: AFU meets a read checking error.\n");
                break;
            }
            if ((reg_data & 0x02) > 0 ){
                write_error = 1;
                VERBOSE0 ("ERROR: AFU meets a write checking error.\n");
                break;
            }
            cnt ++;
        } while (cnt < timeout * 1000); //Use timeout to emulate max allowed MMIO read times

        if(process_suc >= 21){ // when process_suc=21 ,it is the first image which is fully processed.
            // index = pool10(conv10_base, 14, 1000);//do pool10 in host
            // result_index.push_back(index);

            //time_used_array[i] = get_usec() - t_start;
            //VERBOSE0 ("Runtime is: %ld\n", time_used_array[i]);
        }

        // int exp_data;
        // int act_data;
        if(read_error) {
            //exp_data=action_read(dn,REG_ERROR_INFO_L);	
            //act_data=action_read(dn,REG_ERROR_INFO_H);	
            action_write(dn, REG_SOFT_RESET, 0x00000001);
            action_write(dn, REG_SOFT_RESET, 0x00000000);
            // VERBOSE0 ("Expected data is:%8x\n",exp_data);
            // VERBOSE0 ("Actual data is:%8x\n",act_data);
            rc += 0x4;
        }
        if( !done) {
            VERBOSE0 ("Timeout! Transactions haven't been finished.\n");

            action_write(dn, REG_SOFT_RESET, 0x00000001);
            action_write(dn, REG_SOFT_RESET, 0x00000000);
            rc += 0x8;
        }

        printf("single run exit, rc=%d\n", rc);
        //---------------------------------above is run_single_engine 
        //time_used_array[i] = time_used;
    }
    closedir(dir);

    VERBOSE0 (" ----- Finish action, release AFU ----- \n");

    //VERBOSE0 ("SNAP Wait for idle\n");//This is official omission.
    //rc += snap_action_completed ((void*)h, NULL, timeout);
    //VERBOSE0 ("Card in idle\n");

    action_write(dn, REG_SOFT_RESET, 0x00000001);
    action_write(dn, REG_SOFT_RESET, 0x00000000);

    //-------------------------------------------------
    // Detach, Cleanup and Exit
    //-------------------------------------------------
    VERBOSE2 ("Detach action: %p\n", act);
    snap_detach_action (act);

__exit1:
    VERBOSE2 ("Free Card Handle: %p\n", dn);
    snap_card_free (dn);

    free_mem(conv1_base);
    free_mem(pool1_base);
    free_mem(f2s_base);
    free_mem(f2e_base);
    free_mem(f3s_base);
    free_mem(f3e_base);
    free_mem(pool3_base);
    free_mem(f4s_base);
    free_mem(f4e_base);
    free_mem(f5s_base);
    free_mem(f5e_base);
    free_mem(pool5_base);
    free_mem(f6s_base);
    free_mem(f6e_base);
    free_mem(f7s_base);
    free_mem(f7e_base);
    free_mem(f8s_base);
    free_mem(f8e_base);
    free_mem(f9s_base);
    free_mem(f9e_base);
    free_mem(conv10_base);
    free_mem(conv10_weight_base);

    VERBOSE0 ("End of Test rc = 0x%x. \n", rc);
    return rc;
} // main end