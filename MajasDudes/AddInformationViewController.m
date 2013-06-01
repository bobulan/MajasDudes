//
//  AddPersonViewController.m
//  MajasDudes
//
//  Created by Jonathan Jonsson on 2013-04-27.
//  Copyright (c) 2013 Jonathan Jonsson. All rights reserved.
//

#import "AddInformationViewController.h"
#import "FirstViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Criteria.h"

@interface AddInformationViewController ()
{
    NSManagedObjectContext *context;
}

@end

@implementation AddInformationViewController

Criteria * criteria;
NSMutableArray *addedInformationArray;
bool firstnameDidload;
bool lastnameDidload;
bool nicknameDidload;
bool bodyDidload;
bool intelligenceDidload;
bool sexDidload;
bool humorDidload;

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
    
    [[self nickName]setDelegate:self];
    [[self firstName]setDelegate:self];
    [[self lastName]setDelegate:self];
    
    _addedInformationArray = [[NSMutableArray alloc] init];
    //self.tableView.backgroundColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    
    
    // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]]];
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    
    firstnameDidload = false;
    lastnameDidload=false;
    nicknameDidload=false;
    bodyDidload=false;
    intelligenceDidload=false;
    sexDidload=false;
    humorDidload=false;
    
    
    _firstName.delegate = self;
    _lastName.delegate = self;
    _nickName.delegate = self;

    
    
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.contentInset = inset;
    
     
    //self.navigationItem.title = @"MyTitle";
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    //[self.navigationController presentViewController:self animated:YES completion:nil];
    //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];
    
    [self addAllObjectsOnce];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Closes the keyboard at return
-(BOOL) textFieldShouldReturn: (UITextField *)textField{
    NSLog(@"FIRST RESPONDER");
    return [textField resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"FIRST RESPONDER111");
    [textField resignFirstResponder];
}


-(int)checkDuplicates:(NSString *)personToAdd{
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Criteria" inManagedObjectContext:context];
    NSFetchRequest *request= [[NSFetchRequest alloc]init];
    
    [request setEntity:entityDescription ];
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nick_name like %@ and first_name like %@ and last_name like %@" , @"*", @"*", @"*"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nick_name like %@" , personToAdd];
    
    [request setPredicate:predicate];
    NSError *error;
    NSArray * matchingData = [context executeFetchRequest:request error:&error];
    
    //NSLog(@"matching data %d", matchingData.count);
    
    return matchingData.count;
}

- (IBAction)addPerson:(id*)sender {
    

    
    int duplicate = [self checkDuplicates:self.nickName.text];
  
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Criteria" inManagedObjectContext:context];
    NSManagedObject * newPerson = [[NSManagedObject alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:context];
    
    if(duplicate >=1){
       // NSString *addedString = [NSString stringWithFormat:@"%@%@%d", self.nickName.text, @"#", duplicate];
        
        NSLog(@"EN DUPLICATE");
        //[newPerson setValue:addedString forKey:@"nick_name"];
       //  [newPerson setValue:self.nickName.text forKey:@"nick_name"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nickname already added"
                                                        message:@"Please specify a unique Nickname"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    else{
        
        [newPerson setValue:self.nickName.text forKey:@"nick_name"];
        [newPerson setValue:self.firstName.text forKey:@"first_name"];
        [newPerson setValue:self.lastName.text forKey:@"last_name"];
        
        int tempBodyValue = self.bodyRating.value;
        int tempIntelligenceValue = self.intelligenceRating.value;
        
        if(tempIntelligenceValue < 10){
             NSString *intelligenceIntToString = [NSString stringWithFormat:@"0%d",tempIntelligenceValue];
            [newPerson setValue:intelligenceIntToString forKey:@"intelligence"];
        }
        else{
             NSString *intelligenceIntToString = [NSString stringWithFormat:@"%d",tempIntelligenceValue];
            [newPerson setValue:intelligenceIntToString forKey:@"intelligence"];
        }
        
        if(tempBodyValue < 10){
            NSString *bodyIntToString = [NSString stringWithFormat:@"0%d",tempBodyValue];
            [newPerson setValue:bodyIntToString forKey:@"body"];
        }
        else{
            NSString *bodyIntToString = [NSString stringWithFormat:@"%d",tempBodyValue];
            [newPerson setValue:bodyIntToString forKey:@"body"];
        }
        
       
       
        
       // [newPerson setValue:bodyIntToString forKey:@"body"];
        //[newPerson setValue:intelligenceIntToString forKey:@"intelligence"];
        
        int tempHumorValue = self.humorRating.value;
        int tempSexValue = self.sexRating.value;
        
        if(tempHumorValue < 10){
            NSString *humorIntToString = [NSString stringWithFormat:@"0%d",tempHumorValue];
            [newPerson setValue:humorIntToString forKey:@"humor"];
        }
        else{
            NSString *humorIntToString = [NSString stringWithFormat:@"%d",tempHumorValue];
            [newPerson setValue:humorIntToString forKey:@"humor"];
        }
        
        if(tempBodyValue < 10){
            NSString *sexIntToString = [NSString stringWithFormat:@"0%d",tempSexValue];
            [newPerson setValue:sexIntToString forKey:@"sex"];
        }
        else{
            NSString *sexIntToString = [NSString stringWithFormat:@"%d",tempSexValue];
            [newPerson setValue:sexIntToString forKey:@"sex"];
        }
        
        /*
        NSString *humorIntToString = [NSString stringWithFormat:@"%d",tempHumorValue];
        NSString *sexIntToString = [NSString stringWithFormat:@"%d",tempSexValue];
        
        [newPerson setValue:humorIntToString forKey:@"humor"];
        [newPerson setValue:sexIntToString forKey:@"sex"];
        */
         
         
        int totalPoints = tempBodyValue + tempHumorValue + tempIntelligenceValue + tempSexValue;
        
        if(totalPoints < 10){
            NSString *totalPointsIntToString = [NSString stringWithFormat:@"0%d",totalPoints];
            [newPerson setValue:totalPointsIntToString forKey:@"total"];
        }
        else{
            NSString *totalPointsIntToString = [NSString stringWithFormat:@"%d",totalPoints];
            [newPerson setValue:totalPointsIntToString forKey:@"total"];
        }
        
       // NSString *totalPointsIntToString = [NSString stringWithFormat:@"%d",totalPoints];
        //[newPerson setValue:totalPointsIntToString forKey:@"total"];
        
        NSError *error;
        
        [context save:&error];
        
        NSLog(@"%@ added", [newPerson valueForKey:@"first_name"]);
        
        
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"cell_top.png"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"cell_bottom.png"];
    } else {
        background = [UIImage imageNamed:@"cell_middle.png"];
    }
    
    return background;
}



- (void)sliderHandler:(UISlider *)sender
{
    //NSLog(@"value:%f", sender.value);
    [[UIScreen mainScreen] setBrightness:sender.value];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}


-(void)addAllObjectsOnce{
    _firstName = [[UITextField alloc] initWithFrame:CGRectMake(16, 7,274,32)];
    // _firstName = [[UITextField alloc] initWithFrame: CGRectMake(cell.frame.origin.x,cell.frame.origin.y,268,32)];
    _firstName.borderStyle = UITextBorderStyleRoundedRect;
    _firstName.textColor = [UIColor blackColor];
    _firstName.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0];
    _firstName.placeholder = @"First Name";
    _firstName.autocorrectionType = UITextAutocorrectionTypeNo;
    _firstName.backgroundColor = [UIColor clearColor];
    _firstName.keyboardType = UIKeyboardTypeDefault;
    _firstName.delegate = self;
    [_addedInformationArray addObject:_firstName];
    
    
    _lastName = [[UITextField alloc] initWithFrame:CGRectMake(16,7,274,32)];
    _lastName.borderStyle = UITextBorderStyleRoundedRect;
    _lastName.textColor = [UIColor blackColor];
    _lastName.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0];
    _lastName.placeholder = @"Last Name";
    _lastName.backgroundColor = [UIColor whiteColor];
    _lastName.autocorrectionType = UITextAutocorrectionTypeNo;
    _lastName.backgroundColor = [UIColor clearColor];
    _lastName.keyboardType = UIKeyboardTypeDefault;
    _lastName.delegate = self;
      [_addedInformationArray addObject:_lastName];
    
    
    _nickName = [[UITextField alloc] initWithFrame:CGRectMake(16,7,274,32)];
    _nickName.borderStyle = UITextBorderStyleRoundedRect;
    _nickName.textColor = [UIColor blackColor];
    _nickName.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0];
    _nickName.placeholder = @"Nickname";
    _nickName.backgroundColor = [UIColor whiteColor];
    _nickName.autocorrectionType = UITextAutocorrectionTypeNo;
    _nickName.backgroundColor = [UIColor clearColor];
    _nickName.keyboardType = UIKeyboardTypeDefault;
    _nickName.delegate = self;
      [_addedInformationArray addObject:_nickName];
    
    
    
    _bodyRating = [[UISlider alloc] initWithFrame:CGRectMake(16,7,274,32)];
    [_bodyRating addTarget:self action:@selector(sliderHandler:) forControlEvents:UIControlEventValueChanged];
    _bodyRating.minimumValue = 1;
    _bodyRating.maximumValue = 10;
    _bodyRating.value = [[UIScreen mainScreen] brightness];
      [_addedInformationArray addObject:_bodyRating];
    

    _humorRating = [[UISlider alloc] initWithFrame:CGRectMake(16,7,274,32)]; 
    [_humorRating addTarget:self action:@selector(sliderHandler:) forControlEvents:UIControlEventValueChanged];
    _humorRating.minimumValue = 1;
    _humorRating.maximumValue = 10;
    _humorRating.value = [[UIScreen mainScreen] brightness];
     [_addedInformationArray addObject:_humorRating];
    
    
    
    _sexRating = [[UISlider alloc] initWithFrame:CGRectMake(16,7,274,32)];
    [_sexRating addTarget:self action:@selector(sliderHandler:) forControlEvents:UIControlEventValueChanged];
    _sexRating.minimumValue = 1;
    _sexRating.maximumValue = 10;
    _sexRating.value = [[UIScreen mainScreen] brightness];
     [_addedInformationArray addObject:_sexRating];
    
    
    
    _intelligenceRating = [[UISlider alloc] initWithFrame:CGRectMake(16,7,274,32)];
    [_intelligenceRating addTarget:self action:@selector(sliderHandler:) forControlEvents:UIControlEventValueChanged];
    _intelligenceRating.minimumValue = 1;
    _intelligenceRating.maximumValue = 10;
    _intelligenceRating.value = [[UIScreen mainScreen] brightness];
     [_addedInformationArray addObject:_intelligenceRating];
    
    NSLog(@"Size of array %d", [_addedInformationArray count]);
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if(!cell)
    {
        //cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
   // NSLog(@"infor at indexpath %@", [_addedInformationArray objectAtIndex:4]);
    switch (indexPath.row) {
        case 0:
            [cell.contentView addSubview:[_addedInformationArray objectAtIndex:indexPath.row]];
            break;
        case 1:
             [cell.contentView addSubview:[_addedInformationArray objectAtIndex:indexPath.row]];
            break;
        case 2:
             [cell.contentView addSubview:[_addedInformationArray objectAtIndex:indexPath.row]];
            break;
        case 3:
            cell.textLabel.text = @"Body";
           
            break;
        case 4:
           [cell.contentView addSubview:[_addedInformationArray objectAtIndex:(indexPath.row-1)]];
            break;
        case 5:
            cell.textLabel.text = @"Humor";
            
            break;
        case 6:
            [cell.contentView addSubview:[_addedInformationArray objectAtIndex:(indexPath.row-2)]];
            break;
        case 7:
            cell.textLabel.text = @"Sex";
            
            break;
        case 8:
            [cell.contentView addSubview:[_addedInformationArray objectAtIndex:(indexPath.row-3)]];
            break;
        case 9:
            cell.textLabel.text = @"Intelligence";
            
            break;
        case 10:
            [cell.contentView addSubview:[_addedInformationArray objectAtIndex:(indexPath.row-4)]];
            break;
        default:
            break;
    }
    
    
    
    
    
    

    
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:12.0f];
    
    return cell;
}

/*
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if(!cell)
    {
        //cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if(indexPath.section == 0 ){
        
        
        if(indexPath.row == 0){
            
            
            if(!firstnameDidload){
                
                NSLog(@"ska bara köras en gång!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                _firstName = [[UITextField alloc] initWithFrame:CGRectMake(16, 7,274,32)];
                // _firstName = [[UITextField alloc] initWithFrame: CGRectMake(cell.frame.origin.x,cell.frame.origin.y,268,32)];
                _firstName.borderStyle = UITextBorderStyleRoundedRect;
                _firstName.textColor = [UIColor blackColor];
                _firstName.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0];
                _firstName.placeholder = @"First Name";
                
                _firstName.autocorrectionType = UITextAutocorrectionTypeNo;
                _firstName.backgroundColor = [UIColor clearColor];
                _firstName.keyboardType = UIKeyboardTypeDefault;
                
                _firstName.delegate = self;
                
                [cell.contentView addSubview:_firstName];
                firstnameDidload = true;
            }
            
            
        }
        if(indexPath.row == 1 ){
            
            
            
            
            //[[self view]addSubview:_firstName];
            
            if(!lastnameDidload){
                
                NSLog(@"DEN GÅR IN I ROW 1 -------------------------------------");
                _lastName = [[UITextField alloc] initWithFrame:CGRectMake(16,7,274,32)];
                _lastName.borderStyle = UITextBorderStyleRoundedRect;
                _lastName.textColor = [UIColor blackColor];
                _lastName.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0];
                _lastName.placeholder = @"Last Name";
                _lastName.backgroundColor = [UIColor whiteColor];
                _lastName.autocorrectionType = UITextAutocorrectionTypeNo;
                _lastName.backgroundColor = [UIColor clearColor];
                _lastName.keyboardType = UIKeyboardTypeDefault;
                //_lastName.returnKeyType = UIReturnKeyDone;
                //_lastName.clearButtonMode = UITextFieldViewModeWhileEditing;
                _lastName.delegate = self;
                [cell.contentView addSubview:_lastName];
                lastnameDidload = true;
                
            }
            
            
            
            
            
            //   [cell.contentView addSubview:self.lastName];
            //cell.textLabel.text = self.lastName.text;
            
            //cell.detailTextLabel.text = @"Last Name";
        }
        if(indexPath.row == 2){
            
            if(!nicknameDidload){
                
                NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                _nickName = [[UITextField alloc] initWithFrame:CGRectMake(16,7,274,32)];
                _nickName.borderStyle = UITextBorderStyleRoundedRect;
                _nickName.textColor = [UIColor blackColor];
                _nickName.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0];
                _nickName.placeholder = @"Nickname";
                _nickName.backgroundColor = [UIColor whiteColor];
                _nickName.autocorrectionType = UITextAutocorrectionTypeNo;
                _nickName.backgroundColor = [UIColor clearColor];
                _nickName.keyboardType = UIKeyboardTypeDefault;
                //_nickName.returnKeyType = UIReturnKeyDone;
                //_lastName.clearButtonMode = UITextFieldViewModeWhileEditing;
                _nickName.delegate = self;
                
                [cell.contentView addSubview:_nickName];
                nicknameDidload = true;
            }
            
        }
        
    }
    if(indexPath.section == 1){
        NSLog(@"section1");
        
        if(indexPath.row == 0){
            cell.textLabel.text = @"Body";
        }
        
        if(indexPath.row == 1){
            
            if(!bodyDidload){
                _bodyRating = [[UISlider alloc] initWithFrame:CGRectMake(16,7,274,32)];
                
                [_bodyRating addTarget:self action:@selector(sliderHandler:) forControlEvents:UIControlEventValueChanged];
                _bodyRating.minimumValue = 1;
                _bodyRating.maximumValue = 10;
                _bodyRating.value = [[UIScreen mainScreen] brightness];
                //[[self view]addSubview:_bodyRating];
                [cell.contentView addSubview:_bodyRating];
            }
            
            
        }
    }
    if(indexPath.section == 2){
        NSLog(@"section2");
        
        
        if(indexPath.row == 0){
            cell.textLabel.text = @"Humor";
        }
        
        if(indexPath.row == 1){
            if(!humorDidload){
                _humorRating = [[UISlider alloc] initWithFrame:CGRectMake(16,7,274,32)];
                
                [_humorRating addTarget:self action:@selector(sliderHandler:) forControlEvents:UIControlEventValueChanged];
                _humorRating.minimumValue = 1;
                _humorRating.maximumValue = 10;
                _humorRating.value = [[UIScreen mainScreen] brightness];
                //[[self tableView]addSubview:_humorRating];
                [cell.contentView addSubview:_humorRating];
            }
        }
    }
    if(indexPath.section == 3){
        NSLog(@"section3");
        
        if(indexPath.row == 0){
            cell.textLabel.text = @"Sex";
        }
        
        if(indexPath.row == 1){
            if(!sexDidload){
                _sexRating = [[UISlider alloc] initWithFrame:CGRectMake(16,7,274,32)];
                
                [_sexRating addTarget:self action:@selector(sliderHandler:) forControlEvents:UIControlEventValueChanged];
                _sexRating.minimumValue = 1;
                _sexRating.maximumValue = 10;
                _sexRating.value = [[UIScreen mainScreen] brightness];
                //[[self view]addSubview:_bodyRating];
                [cell.contentView addSubview:_sexRating];
            }
        }
    }
    if(indexPath.section == 4){
        NSLog(@"section4");
        
        if(indexPath.row == 0){
            cell.textLabel.text = @"Intelligence";
        }
        
        if(indexPath.row == 1){
            if(!intelligenceDidload){
                _intelligenceRating = [[UISlider alloc] initWithFrame:CGRectMake(16,7,274,32)];
                
                [_intelligenceRating addTarget:self action:@selector(sliderHandler:) forControlEvents:UIControlEventValueChanged];
                _intelligenceRating.minimumValue = 1;
                _intelligenceRating.maximumValue = 10;
                _intelligenceRating.value = [[UIScreen mainScreen] brightness];
                //[[self view]addSubview:_bodyRating];
                [cell.contentView addSubview:_intelligenceRating];
            }
        }
    }
    
    
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:12.0f];
    
    return cell;
}
*/

@end
