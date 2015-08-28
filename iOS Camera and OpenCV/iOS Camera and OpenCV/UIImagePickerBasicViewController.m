//
//  UIImagePickerBasicViewController.m
//  iOS Camera and OpenCV
//
//  Created by Amolak Nagi on 8/28/15.
//  Copyright (c) 2015 Amolak Nagi. All rights reserved.
//

#import "UIImagePickerBasicViewController.h"

@interface UIImagePickerBasicViewController ()

//View Elements
@property (weak, nonatomic) IBOutlet UIImageView *cameraImage;
@property (weak, nonatomic) IBOutlet UISwitch *editSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *selfieSwitch;

//User camera preferences
@property (nonatomic) BOOL allowsEditing;
@property (nonatomic) UIImagePickerControllerCameraDevice cameraDevice;

@end

@implementation UIImagePickerBasicViewController

#pragma mark - View Initialization

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set defaults for camera preferences
    self.allowsEditing = YES;
    self.cameraDevice = UIImagePickerControllerCameraDeviceFront;
}





#pragma mark - UIImagePickerController Delegate Methods


//Take action when photo is selected
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Use edited image if the user used the camera and wants editing
    if (self.allowsEditing && picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        self.cameraImage.image = info[UIImagePickerControllerEditedImage];
    }
    //Otherwise use the original image
    else
    {
        self.cameraImage.image = info[UIImagePickerControllerOriginalImage];
    }
    
    //Hide the camera view controller
    [picker dismissViewControllerAnimated:YES completion:nil];
}






#pragma mark - User Interaction

//Raise the modal view to take a picture
- (IBAction)takePicture:(id)sender
{
    //Create the UIImagePickerController
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];

    
    
    //Assign relevant properties to controller
    //Assign the object's delegate to our viewController
    imagePickerController.delegate = self;
    
    //Make it so that the editing after the photo is taken is based on the editSwitch state
    imagePickerController.allowsEditing = self.allowsEditing;
    
    //Adjust source type so that user takes image with camera
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    imagePickerController.cameraDevice = self.cameraDevice;
    
    
    
    //Present the imagePickerController
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
}







//Raise the modal view to pick a photo from your photo library
- (IBAction)selectPicture:(id)sender
{
    //Create the UIImagePickerController
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    
    
    //Assign relevant properties to controller
    //Assign the object's delegate to our viewController
    imagePickerController.delegate = self;
    
    //Make it so that the editing after the photo is taken is based on the editSwitch state
    imagePickerController.allowsEditing = self.allowsEditing;
    
    //Adjust source type so that user selects image from library
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    
    //Present the imagePickerController
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
}





//Update editing preference when switch is pressed
- (IBAction)editSwitchPressed:(id)sender
{
    self.allowsEditing = self.editSwitch.isOn;
}


//Update selfie choice when switch is pressed
- (IBAction)selfieSwitchPressed:(id)sender
{
    if (self.selfieSwitch.isOn)
    {
        self.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    else
    {
        self.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
}

@end
