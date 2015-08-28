//
//  OptionsTableViewController.m
//  iOS Camera and OpenCV
//
//  Created by Amolak Nagi on 8/24/15.
//  Copyright (c) 2015 Amolak Nagi. All rights reserved.
//

#import "OptionsTableViewController.h"

@interface OptionsTableViewController ()

//Array of pages
@property (nonatomic, strong) NSArray *pages;

@end

@implementation OptionsTableViewController


#pragma mark - Table View Initialization

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Determine the pages in the application here
    //Make sure the page names match the segue names!!!
    self.pages = @[@"UIImagePickerController Basics"];
}






#pragma mark - Table View Section Setup

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //Table View has 1 section, can easily change later
    return 1;
}






#pragma mark - Table View Row Setup

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Since there's only one section, number of rows is number of pages
    return self.pages.count;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Allocate a normal cell
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"Pages Cell"];
    
    //Give the cell the appropriate title
    cell.textLabel.text = self.pages[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}







#pragma mark - User Interaction

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *segue = self.pages[indexPath.row];
    
    [self performSegueWithIdentifier:segue sender:nil];
}



@end
