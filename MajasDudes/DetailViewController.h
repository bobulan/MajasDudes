//
//  DetailViewController.h
//  MajasDudes
//
//  Created by Jonathan Jonsson on 2013-05-01.
//  Copyright (c) 2013 Jonathan Jonsson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddInformationViewController.h"
#import "FirstViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

//added
//@class FirstViewController;

@interface DetailViewController : UITableViewController <UINavigationControllerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate,UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate>



@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (weak, nonatomic) IBOutlet UILabel *intelligenceRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *humorRatingLabel;
@property (weak, nonatomic) NSString *fetchedStringFromSelectedItem;

@property (strong, nonatomic) IBOutlet UIImagePickerController * imagePicker;

//@property (weak, nonatomic) NSMutableArray *informationArray;

-(void)getDataForSelectedRow;
- (IBAction)addPhoto:(id)sender;
//-(void)addImageURLToCoreData:(NSURL *)url;


@end
