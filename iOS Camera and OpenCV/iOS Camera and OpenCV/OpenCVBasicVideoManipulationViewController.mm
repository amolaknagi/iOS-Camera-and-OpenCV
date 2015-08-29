//
//  OpenCVBasicVideoManipulationViewController.m
//  iOS Camera and OpenCV
//
//  Created by Amolak Nagi on 8/28/15.
//  Copyright (c) 2015 Amolak Nagi. All rights reserved.
//

#import "OpenCVBasicVideoManipulationViewController.hh"


@interface OpenCVBasicVideoManipulationViewController ()

@property (nonatomic, strong) CvVideoCamera *videoCamera;
@property (weak, nonatomic) IBOutlet UIImageView *cameraFeedView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *videoTypeControl;

@end

@implementation OpenCVBasicVideoManipulationViewController

#pragma mark - View Initialization



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:self.cameraFeedView];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.videoCamera start];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.videoCamera stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)processImage:(cv::Mat &)image
{
    switch (self.videoTypeControl.selectedSegmentIndex)
    {
            //@"BGR" which is original
        case 0:
        {
            return;
        }
            //@"Gray"
        case 1:
        {
            cv::cvtColor(image, image, CV_BGR2GRAY);
            break;
        }
            
            //@"HSV"
        case 2:
        {
            cv::cvtColor(image, image, CV_BGR2HSV);
            break;
        }
            
            //@"Luv"
        case 3:
        {
            cv::cvtColor(image, image, CV_BGR2Luv);
            break;
        }
            
            //@"XYZ"
        case 4:
        {
            cv::cvtColor(image, image, CV_BGR2XYZ);
            break;
        }
            
            //@"YCC"
        case 5:
        {
            cv::cvtColor(image, image, CV_BGR2YCrCb);
            break;
        }
            
            //@"L*a*b*"
        case 6:
        {
            cv::cvtColor(image, image, CV_BGR2Lab);
            break;
        }
    }

}

@end
