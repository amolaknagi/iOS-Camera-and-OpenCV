//
//  OpenCVHelpers.h
//  iOS Camera and OpenCV
//
//  Created by Amolak Nagi on 8/28/15.
//  Copyright (c) 2015 Amolak Nagi. All rights reserved.
//

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#endif

#import <UIKit/UIKit.h>

@interface OpenCVHelpers : UIView

- (cv::Mat)cvMatFromUIImage:(UIImage *)image;
-(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat;

@end
