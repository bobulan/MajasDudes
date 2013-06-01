//
//  SecondViewController.h
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

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) Criteria * criteria;
@property (strong, nonatomic) IBOutlet UITextView *topScoreList;
@property (strong, nonatomic) IBOutlet UITableView *topListView;
//@property (strong, nonatomic) IBOutlet UITextView *topScoreListPoints;
@property (strong, nonatomic) UIImageView *backgroundTopList;


-(void)viewTopScores;

@end
