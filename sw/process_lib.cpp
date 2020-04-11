// process_lib.cpp

#include <iostream>
#include <fstream>
#include <string.h>
#include <vector>
#include <algorithm>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>

using namespace std;
using namespace cv;


int read_img(Mat img, void *dst, int size) {
    Mat input = img;
    
    resize(input, input, Size(227, 227));
    cout << input.size << endl;
	imshow("test image",input);
	waitKey(-1);
    input.convertTo(input, CV_16S); // convert to 16bit signed
    
    Mat img_mean(227, 227, CV_16SC3, Scalar(104, 117, 123));
    
    input -= img_mean;

    memcpy(dst, input.data, size);
    
    return 0;
}

int read_mat(const char* path, void* dst) {
	Mat img = imread(path);//need absolute path
    if(img.data == NULL){
        cout << "ERROR: Cannot find the image. Please check the path.\n";
        return 1;
    }
    // cout << img.size << endl;
	// imshow("test image",img);
	// waitKey(-1);
    

	read_img(img, dst , 2*3*227*227);
	return 0;
}

vector<string> init_classes(string labelFile) {
    ifstream ifs(labelFile.c_str());
    vector<string> classes;
    string line;
    
    while (getline(ifs, line)) {
        classes.push_back(line);
    }
    return classes;
}

// pool10(conv10_base, 14, 1000);
long pool10(void *src, int sizeIn, int chin) {
    const int size[] = {sizeIn, sizeIn};
    // dim = 2, size = 14x14, channel = 1000, 16bit signed
    Mat poolSrc(2, size, CV_16SC(chin), src);
    
    Scalar m = mean(poolSrc);
    long index = max_element(&m[0], &m[0]+chin) - &m[0];
    
    return index;
}

