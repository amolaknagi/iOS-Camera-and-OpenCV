//
//  OpenCVBasicImageManipulationViewController.m
//  iOS Camera and OpenCV
//
//  Created by Amolak Nagi on 8/28/15.
//  Copyright (c) 2015 Amolak Nagi. All rights reserved.
//



#import "OpenCVBasicImageManipulationViewController.h"

@interface OpenCVBasicImageManipulationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *manipulatedImage;
@property (nonatomic, strong) UIImage *originalImage;

@end

@implementation OpenCVBasicImageManipulationViewController


#pragma mark - View Initialization

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.originalImage = self.manipulatedImage.image;
}



- (IBAction)imageTypeControlPressed:(id)sender
{
    UISegmentedControl *imageTypeControl = (UISegmentedControl *)sender;
    
    //@"BGR" which is original
    if (imageTypeControl.selectedSegmentIndex == 0)
    {
        self.manipulatedImage.image = self.originalImage;
        return;
    }
    
    //Convert original image into mat structure
    cv::Mat matImage = [self cvMatFromUIImage:self.originalImage];
    
    
    switch (imageTypeControl.selectedSegmentIndex)
    {
        //@"Gray"
        case 1:
        {
            cv::cvtColor(matImage, matImage, CV_BGR2GRAY);
            break;
        }
            
        //@"HSV"
        case 2:
        {
            cv::cvtColor(matImage, matImage, CV_BGR2HSV);
            break;
        }
            
        //@"Luv"
        case 3:
        {
            cv::cvtColor(matImage, matImage, CV_BGR2Luv);
            break;
        }
            
        //@"XYZ"
        case 4:
        {
            cv::cvtColor(matImage, matImage, CV_BGR2XYZ);
            break;
        }
            
        //@"YCC"
        case 5:
        {
            cv::cvtColor(matImage, matImage, CV_BGR2YCrCb);
            break;
        }
            
        //@"L*a*b*"
        case 6:
        {
            cv::cvtColor(matImage, matImage, CV_BGR2Lab);
            break;
        }
    }
    
    UIImage *finalImage = [self UIImageFromCVMat:matImage];
    self.manipulatedImage.image = finalImage;
    
    /*
    //Perform correct conversion based on user choice
    //@"Gray"
    if (imageTypeControl.selectedSegmentIndex == 1)
    {
        cv::cvtColor(matImage, matImage, CV_BGR2GRAY);
    }
    //@"HSV"
    else if (imageTypeControl.selectedSegmentIndex == 2)
    {
        cv::cvtColor(matImage, matImage, CV_BGR2HSV);
    }
    //@"Luv"
    else if (imageTypeControl.selectedSegmentIndex == 3)
    {
        cv::cvtColor(matImage, matImage, CV_BGR2Luv);
    }
    //@"XYZ"
    else if (imageTypeControl.selectedSegmentIndex == 4)
    {
        cv::cvtColor(matImage, matImage, CV_BGR2XYZ);
    }
    //@"YCrCb"
    else if (imageTypeControl.selectedSegmentIndex == 5)
    {
        cv::cvtColor(matImage, matImage, CV_BGR2YCrCb);
    }
    //@"L*a*b*"
    else if (imageTypeControl.selectedSegmentIndex == 6)
    {
        cv::cvt
    }
     */
    
}




//Both functions taken from OpenCV Documentation
//http://docs.opencv.org/doc/tutorials/ios/image_manipulation/image_manipulation.html#opencviosimagemanipulation
- (cv::Mat)cvMatFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    return cvMat;
}

-(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                            //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}



@end
