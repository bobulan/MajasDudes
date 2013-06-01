//
//  AddPersonViewController.m
//  MajasDudes
//
//  Created by Jonathan Jonsson on 2013-04-27.
//  Copyright (c) 2013 Jonathan Jonsson. All rights reserved.
//

#import "AddPersonViewControllerBackup.h"
#import "FirstViewController.h"

@interface AddPersonViewController ()

@end

@implementation AddPersonViewController
@synthesize Criteria = _criteria;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.nickname.delegate = self;
    _criteria = [[NSMutableArray alloc]init];
  
    
    
    
    
    //persons = [[NSMutableArray alloc] init];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn: (UITextField *)textField{
    return [textField resignFirstResponder];
}

- (IBAction)addWithSubmittedInfo:(id)sender {
    //[_criteria]
    NSLog(@"Vafalls");
    
    
    FirstViewController * passToFVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    passToFVC.nickNameFromAddPerson = self.nickname.text;
    NSLog(@"%@", self.nickname.text);
    
    [self presentViewController:passToFVC animated:YES completion:nil];
    
    
}


@end
