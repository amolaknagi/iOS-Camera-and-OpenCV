//
//  OpenCVBasicVideoManipulationViewController.h
//  iOS Camera and OpenCV
//
//  Created by Amolak Nagi on 8/28/15.
//  Copyright (c) 2015 Amolak Nagi. All rights reserved.
//

#ifndef __IPHONE_4_0
#warning "This project uses features only available in iOS SDK 4.0 and later."
#endif

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/opencv.hpp>
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif
@interface OpenCVBasicVideoManipulationViewController : UIViewController <CvVideoCameraDelegate>

@end
