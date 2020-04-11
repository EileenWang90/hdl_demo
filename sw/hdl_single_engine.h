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

#ifndef __HDL_COMPUTING__
#define __HDL_COMPUTING__

/*
 * This makes it obvious that we are influenced by HLS details ...
 * The ACTION control bits are defined in the following file.
 */
#define ACTION_TYPE_HDL_COMPUTING     0x10142006	/* Action Type  (need to change,and .cfile) */

#define REG_SNAP_CONTROL        0x00
#define REG_SNAP_INT_ENABLE     0x04
#define REG_SNAP_ACTION_TYPE    0x10
#define REG_SNAP_ACTION_VERSION 0x14
#define REG_SNAP_CONTEXT        0x20
// User defined below
#define REG_USER_STATUS         0x30
#define REG_USER_CONTROL        0x34

// #define REG_SOURCE_ADDRESS_L    0x38
// #define REG_SOURCE_ADDRESS_H    0x3C
// #define REG_TARGET_ADDRESS_L    0x40
// #define REG_TARGET_ADDRESS_H    0x44
// #define REG_MB_WIDTH_HEIGHT     0x48
// #define REG_SOFT_RESET          0x50

// #define REG_CONV1_READ_H        0x40 
// #define REG_CONV1_READ_L        0x41
// #define REG_CONV1_WRITE_H       0x42
// #define REG_CONV1_WRITE_L       0x43

// #define REG_POOL1_READ_H        0x44
// #define REG_POOL1_READ_L        0x45
// #define REG_POOL1_WRITE_H       0x46
// #define REG_POOL1_WRITE_L       0x47

// #define REG_F2_S_READ_H         0x48
// #define REG_F2_S_READ_L         0x49
// #define REG_F2_S_WRITE_H        0x4A
// #define REG_F2_S_WRITE_L        0x4B

// #define REG_F2_E_READ_H         0x4C
// #define REG_F2_E_READ_L         0x4D
// #define REG_F2_E_WRITE_H        0x4E 
// #define REG_F2_E_WRITE_L        0x4F 

// #define REG_F3_S_READ_H         0x50 
// #define REG_F3_S_READ_L         0x51 
// #define REG_F3_S_WRITE_H        0x52 
// #define REG_F3_S_WRITE_L        0x53 

// #define REG_F3_E_READ_H         0x54 
// #define REG_F3_E_READ_L         0x55 
// #define REG_F3_E_WRITE_H        0x56 
// #define REG_F3_E_WRITE_L        0x57 

// #define REG_POOL3_READ_H        0x58 
// #define REG_POOL3_READ_L        0x59 
// #define REG_POOL3_WRITE_H       0x5A
// #define REG_POOL3_WRITE_L       0x5B 

// #define REG_F4_S_READ_H         0x5C
// #define REG_F4_S_READ_L         0x5D 
// #define REG_F4_S_WRITE_H        0x5E 
// #define REG_F4_S_WRITE_L        0x5F 

// #define REG_F4_E_READ_H         0x60 
// #define REG_F4_E_READ_L         0x61 
// #define REG_F4_E_WRITE_H        0x62 
// #define REG_F4_E_WRITE_L        0x63 

// #define REG_F5_S_READ_H         0x64 
// #define REG_F5_S_READ_L         0x65
// #define REG_F5_S_WRITE_H        0x66
// #define REG_F5_S_WRITE_L        0x67

// #define REG_F5_E_READ_H         0x68 
// #define REG_F5_E_READ_L         0x69
// #define REG_F5_E_WRITE_H        0x6A
// #define REG_F5_E_WRITE_L        0x6B

// #define REG_POOL5_READ_H        0x6C 
// #define REG_POOL5_READ_L        0x6D
// #define REG_POOL5_WRITE_H       0x6E
// #define REG_POOL5_WRITE_L       0x6F

// #define REG_F6_S_READ_H         0x70 
// #define REG_F6_S_READ_L         0x71
// #define REG_F6_S_WRITE_H        0x72
// #define REG_F6_S_WRITE_L        0x73

// #define REG_F6_E_READ_H         0x74 
// #define REG_F6_E_READ_L         0x75
// #define REG_F6_E_WRITE_H        0x76
// #define REG_F6_E_WRITE_L        0x77

// #define REG_F7_S_READ_H         0x78
// #define REG_F7_S_READ_L         0x79
// #define REG_F7_S_WRITE_H        0x7A
// #define REG_F7_S_WRITE_L        0x7B

// #define REG_F7_E_READ_H         0x7C 
// #define REG_F7_E_READ_L         0x7D
// #define REG_F7_E_WRITE_H        0x7E
// #define REG_F7_E_WRITE_L        0x7F

// #define REG_F8_S_READ_H         0x80 
// #define REG_F8_S_READ_L         0x81
// #define REG_F8_S_WRITE_H        0x82
// #define REG_F8_S_WRITE_L        0x83

// #define REG_F8_E_READ_H         0x84 
// #define REG_F8_E_READ_L         0x85
// #define REG_F8_E_WRITE_H        0x86
// #define REG_F8_E_WRITE_L        0x87

// #define REG_F9_S_READ_H         0x88 
// #define REG_F9_S_READ_L         0x89
// #define REG_F9_S_WRITE_H        0x8A
// #define REG_F9_S_WRITE_L        0x8B

// #define REG_F9_E_READ_H         0x8C 
// #define REG_F9_E_READ_L         0x8D
// #define REG_F9_E_WRITE_H        0x8E
// #define REG_F9_E_WRITE_L        0x8F

// #define REG_CONV10_READ_H       0x90 
// #define REG_CONV10_READ_L       0x91
// #define REG_CONV10_WRITE_H      0x92
// #define REG_CONV10_WRITE_L      0x93

// #define REG_CONV10_WEIGHT_H     0x94
// #define REG_CONV10_WEIGHT_L     0x95
#define REG_CONV1_READ_H      0x40
#define REG_CONV1_READ_L      0x44
#define REG_CONV1_WRITE_H     0x48
#define REG_CONV1_WRITE_L     0x4C

#define REG_POOL1_READ_H      0x50
#define REG_POOL1_READ_L      0x54
#define REG_POOL1_WRITE_H     0x58
#define REG_POOL1_WRITE_L     0x5C

#define REG_F2_S_READ_H      0x60
#define REG_F2_S_READ_L      0x64
#define REG_F2_S_WRITE_H     0x68
#define REG_F2_S_WRITE_L     0x6C

#define REG_F2_E_READ_H      0x70
#define REG_F2_E_READ_L      0x74
#define REG_F2_E_WRITE_H     0x78
#define REG_F2_E_WRITE_L     0x7C

#define REG_F3_S_READ_H      0x80
#define REG_F3_S_READ_L      0x84
#define REG_F3_S_WRITE_H     0x88
#define REG_F3_S_WRITE_L     0x8C

#define REG_F3_E_READ_H      0x90
#define REG_F3_E_READ_L      0x94
#define REG_F3_E_WRITE_H     0x98
#define REG_F3_E_WRITE_L     0x9C

#define REG_POOL3_READ_H      0xa0
#define REG_POOL3_READ_L      0xa4
#define REG_POOL3_WRITE_H     0xa8
#define REG_POOL3_WRITE_L     0xaC

#define REG_F4_S_READ_H      0xb0
#define REG_F4_S_READ_L      0xb4
#define REG_F4_S_WRITE_H     0xb8
#define REG_F4_S_WRITE_L     0xbC

#define REG_F4_E_READ_H      0xc0
#define REG_F4_E_READ_L      0xc4
#define REG_F4_E_WRITE_H     0xc8
#define REG_F4_E_WRITE_L     0xcC

#define REG_F5_S_READ_H      0xd0
#define REG_F5_S_READ_L      0xd4
#define REG_F5_S_WRITE_H     0xd8
#define REG_F5_S_WRITE_L     0xdC

#define REG_F5_E_READ_H      0xe0
#define REG_F5_E_READ_L      0xe4
#define REG_F5_E_WRITE_H     0xe8
#define REG_F5_E_WRITE_L     0xeC

#define REG_POOL5_READ_H      0xf0
#define REG_POOL5_READ_L      0xf4
#define REG_POOL5_WRITE_H     0xf8
#define REG_POOL5_WRITE_L     0xfC

#define REG_F6_S_READ_H      0x100
#define REG_F6_S_READ_L      0x104
#define REG_F6_S_WRITE_H     0x108
#define REG_F6_S_WRITE_L     0x10C

#define REG_F6_E_READ_H      0x110
#define REG_F6_E_READ_L      0x114
#define REG_F6_E_WRITE_H     0x118
#define REG_F6_E_WRITE_L     0x11C

#define REG_F7_S_READ_H      0x120
#define REG_F7_S_READ_L      0x124
#define REG_F7_S_WRITE_H     0x128
#define REG_F7_S_WRITE_L     0x12C

#define REG_F7_E_READ_H      0x130
#define REG_F7_E_READ_L      0x134
#define REG_F7_E_WRITE_H     0x138
#define REG_F7_E_WRITE_L     0x13C

#define REG_F8_S_READ_H      0x140
#define REG_F8_S_READ_L      0x144
#define REG_F8_S_WRITE_H     0x148
#define REG_F8_S_WRITE_L     0x14C

#define REG_F8_E_READ_H      0x150
#define REG_F8_E_READ_L      0x154
#define REG_F8_E_WRITE_H     0x158
#define REG_F8_E_WRITE_L     0x15C

#define REG_F9_S_READ_H      0x160
#define REG_F9_S_READ_L      0x164
#define REG_F9_S_WRITE_H     0x168
#define REG_F9_S_WRITE_L     0x16C

#define REG_F9_E_READ_H      0x170
#define REG_F9_E_READ_L      0x174
#define REG_F9_E_WRITE_H     0x178
#define REG_F9_E_WRITE_L     0x17C

#define REG_CONV10_READ_H      0x180
#define REG_CONV10_READ_L      0x184
#define REG_CONV10_WRITE_H     0x188
#define REG_CONV10_WRITE_L     0x18C

#define REG_CONV10_WEIGHT_H     0x190
#define REG_CONV10_WEIGHT_L     0x194

#define REG_SOFT_RESET          0x1A0

#endif	/* __HDL_COMPUTING__ */
