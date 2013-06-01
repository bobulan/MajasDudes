//
//  AddPersonViewController.h
//  MajasDudes
//
//  Created by Jonathan Jonsson on 2013-04-27.
//  Copyright (c) 2013 Jonathan Jonsson. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AddPersonViewController.h"
//#import "Criteria.h"
//#import "FirstViewController.h"

@interface AddPersonViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

//@interface AddPersonViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *information;
@property (strong, nonatomic) NSObject *Criteria;
@property (weak, nonatomic) IBOutlet UITextField *nickname;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;





@property (strong, nonatomic) NSString *nick;
@property (strong, nonatomic) NSString *fName;
@property (strong, nonatomic) NSString *lName;



//- (IBAction)addWithSubmittedInfo:(id)sender;



@end