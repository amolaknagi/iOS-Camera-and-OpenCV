//
//  UIImagePickerVideosViewController.m
//  iOS Camera and OpenCV
//
//  Created by Amolak Nagi on 8/28/15.
//  Copyright (c) 2015 Amolak Nagi. All rights reserved.
//


#import "UIImagePickerVideosViewController.h"

@interface UIImagePickerVideosViewController ()

//Main UIImagePickerController
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (weak, nonatomic) IBOutlet UIView *cameraOverlayView;
@property (weak, nonatomic) IBOutlet UISwitch *flashSwitch;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *qualitySetting;

@end

@implementation UIImagePickerVideosViewController


#pragma mark - View Initialization


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self createImagePickerController];
    
}






- (void)viewDidAppear:(BOOL)animated
{
    self.imagePickerController.view.frame = self.cameraOverlayView.frame;
    [self.view addSubview:self.imagePickerController.view];
    [self.imagePickerController viewWillAppear:YES];
    [self.imagePickerController viewDidAppear:YES];
}







- (BOOL)createImagePickerController
{
    if (![UIImagePickerController availableCaptureModesForCameraDevice:UIImagePickerControllerCameraDeviceRear])
    {
        NSLog(@"No camera available");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                        message:@"There's no camera device available"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    //Allocate our UIImagePickerController with the correct sourceType
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //Set media type to get video
    //Note: If you set the capture mode to be video before setting the mediaType, it will crash
    self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
    self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    
    //For our case, hide camera controls
    self.imagePickerController.showsCameraControls = NO;
    
    //Default video quality to low and flash off
    self.imagePickerController.videoQuality = UIImagePickerControllerQualityType640x480;
    self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    
    //Assign delegate for imagePickerController
    self.imagePickerController.delegate = self;
    
    return YES;
}









#pragma mark - UIImagePickerControllerDelegate Methods


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"imagePickerController:didFinishPickingMediaWithInfo");
    
    //Get URL of video in filesystem
    NSURL *URL = info[UIImagePickerControllerMediaURL];
    
    //Get the path of the video in the filesystem from the url
    NSString *videoPath = [URL path];
    
    //Save the video
    UISaveVideoAtPathToSavedPhotosAlbum(videoPath, self, nil, nil);
}










#pragma mark - User Interaction


- (IBAction)flashSwitchPressed:(id)sender
{
    NSLog(@"flashSwitchPressed");
    
    if (self.flashSwitch.isOn)
    {
        self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
    }
    else
    {
        self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    }
}








- (IBAction)qualitySettingPressed:(id)sender
{
    NSLog(@"qualitySettingPressed");
    
    NSInteger selectedIndex = self.qualitySetting.selectedSegmentIndex;
    
    if (selectedIndex == 0)
    {
        self.imagePickerController.videoQuality = UIImagePickerControllerQualityType640x480;
    }
    else if (selectedIndex == 1)
    {
        self.imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }
}






- (IBAction)recordButtonPressed:(id)sender
{
    NSLog(@"recordButtonPressed");
    
    //Start recording if recording isn't currently happening
    if ([self.recordButton.titleLabel.text isEqualToString:@"Record"])
    {
        [self.recordButton setTitle:@"Done" forState:UIControlStateNormal];
        [self.imagePickerController startVideoCapture];
        NSLog(@"Recording started");
        return;
    }
    else if ([self.recordButton.titleLabel.text isEqualToString:@"Done"])
    {
        [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
        [self.imagePickerController stopVideoCapture];
        NSLog(@"Recording stopped");
        return;
    }
}



@end
