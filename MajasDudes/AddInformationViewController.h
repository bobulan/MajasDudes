//
//  AddInformationViewController.h
//  MajasDudes
//
//  Created by Jonathan Jonsson on 2013-04-27.
//  Copyright (c) 2013 Jonathan Jonsson. All rights reserved.
//


#import <UIKit/UIKit.h>
//#import "AddPersonViewController.h"
#import "AddInformationViewController.h"
#import "Criteria.h"
#import "FirstViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface AddInformationViewController : UITableViewController <UITextFieldDelegate>

//@interface AddPersonViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *information;
//@property (strong, nonatomic) NSMutableArray * _criteria;
@property (strong, nonatomic) Criteria * criteria;
@property (strong, nonatomic) NSMutableArray * addedInformationArray;
@property (strong, nonatomic) NSMutableArray * persons;
@property (strong, nonatomic) IBOutlet UITextField *nickName;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;

@property (strong, nonatomic) IBOutlet UISlider *bodyRating;
@property (strong, nonatomic) IBOutlet UISlider *intelligenceRating;
@property (strong, nonatomic) IBOutlet UISlider *humorRating;
@property (strong, nonatomic) IBOutlet UISlider *sexRating;


- (IBAction)addPerson:(id*)sender;
- (IBAction)cancelButton:(id)sender;
//- (IBAction)cancel:(id*)sender;
//- (IBAction)searchPerson:(id)sender;
-(int)checkDuplicates:(NSString *)personToAdd;
-(void)addAllObjectsOnce;


@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong, nonatomic) NSString *totalPoints;
@property (strong, nonatomic) NSString *nick;
@property (strong, nonatomic) NSString *fName;
@property (strong, nonatomic) NSString *lName;



//- (IBAction)addWithSubmittedInfo:(id)sender;



@end