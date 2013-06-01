//
//  FirstViewController.h
//  MajasDudes
//
//  Created by Jonathan Jonsson on 2013-04-27.
//  Copyright (c) 2013 Jonathan Jonsson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Criteria.h"
#import "DetailViewController.h"

@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

//@property (strong, nonatomic) NSMutableArray *persons;
//@property (weak, nonatomic) IBOutlet UIToolbar *dudeAdd;
//@property (weak, nonatomic) IBOutlet UIToolbar *viewBar;
//@property (weak, nonatomic) IBOutlet UINavigationBar *firstViewNavBar;

@property (weak, nonatomic) IBOutlet UITableView *myDudeView;
@property (strong, nonatomic) NSString *nickNameFromAddPerson;
@property (nonatomic, retain) NSString *selectedPerson;

//- (IBAction)addDude:(id)sender;
//-(void)addToTableView;
-(void)getDataFromDataBase;

@end
