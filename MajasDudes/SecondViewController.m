//
//  SecondViewController.m
//  MajasDudes
//
//  Created by Jonathan Jonsson on 2013-04-27.
//  Copyright (c) 2013 Jonathan Jonsson. All rights reserved.
//

#import "SecondViewController.h"
#import <UIKit/UIKit.h>
//#import "AddPersonViewController.h"
#import "AddInformationViewController.h"
#import "Criteria.h"
#import "FirstViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface SecondViewController ()
{
    NSManagedObjectContext *context;
    NSMutableArray * criteriaArray;
    NSMutableArray * fullNameArray;
    NSMutableArray * imageArray;
}

@end

@implementation SecondViewController

Criteria * criteria;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Top Dudes";
    
    self.topListView.delegate = self;
    self.topListView.dataSource = self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    

    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];

    
    [self.topListView setShowsVerticalScrollIndicator:NO];
    //[self.topListView setScrollsToTop:NO];
    
    
    criteriaArray = [[NSMutableArray alloc] init];
    fullNameArray = [[NSMutableArray alloc] init];
    imageArray = [[NSMutableArray alloc]init];
    
   // _topScoreList.backgroundColor = [UIColor clearColor];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    self.topListView.backgroundColor = [UIColor clearColor];

   
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.topListView.contentInset = inset;
    
    self.topListView.userInteractionEnabled = NO;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /*
    _backgroundTopList = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper-01"]];
    _backgroundTopList.frame = CGRectMake(_backgroundTopList.frame.origin.x,  _backgroundTopList.frame.origin.y, 320, 360);
    [self.view addSubview:_backgroundTopList];
    
    */
    [self viewTopScores];
    
   

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewTopScores{
    
    [self.topScoreList setText:@""];
    
   
   
   NSError *error;
    

    
    
    
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Criteria" inManagedObjectContext:context];
    NSFetchRequest *request= [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription ];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"total" ascending:NO];
    
    
    
    
    
    
    
    
    
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    //NSArray *sortedResults = [context executeFetchRequest:request error:&error];
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"first_name like %@ and last_name like %@", @"*", @"*"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nick_name like %@", @"*"];
    
    
    [request setPredicate:predicate];
    
    NSArray * matchingData = [context executeFetchRequest:request error:&error];
    
    
    /*
    NSSortDescriptor *name = [[NSSortDescriptor alloc] initWithKey:@"total" ascending:YES];
    NSArray *sortedValues = [NSArray arrayWithObject: name];
    
    NSArray *reverseOrder = [matchingData sortedArrayUsingDescriptors:sortedValues];
    */
    


    //NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"total" ascending:YES];
    //[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
   

        
    if(matchingData.count <= 0){
        NSLog(@"No persons found");
    }
    else{
        NSString *nicknameNSString;
        NSString *firstnameNSString;
        NSString *lastnameNSString;
        NSString *bodyInteger;
        NSString *intelligenceInteger;
        NSString *sexInteger;
        NSString *humorInteger;
        NSString *totalInteger;
            
        for (NSManagedObject *obj in matchingData) {
            nicknameNSString = [obj valueForKey:@"nick_name"];
            firstnameNSString = [obj valueForKey:@"first_name"];
            lastnameNSString = [obj valueForKey:@"last_name"];
            bodyInteger = [obj valueForKey:@"body"];
            intelligenceInteger = [obj valueForKey:@"intelligence"];
            humorInteger = [obj valueForKey:@"humor"];
            sexInteger = [obj valueForKey:@"sex"];
            totalInteger = [obj valueForKey:@"total"];
           
               /*
            [self.topScoreList setText:[NSString stringWithFormat:@"%@ %@ - %@p \n", self.topScoreList.text, firstnameNSString, totalInteger]];
         */
            [criteriaArray addObject:[NSString stringWithFormat:@"%@", totalInteger]];
            [fullNameArray addObject:[NSString stringWithFormat:@"%@ %@", firstnameNSString,lastnameNSString]];
            
        }
     
       // [self.view addSubview:_topScoreList];

        //NSSortDescriptor *name = [[NSSortDescriptor alloc] initWithKey:@"total" ascending:YES];
        
        //NSArray *sortDescriptors = [NSArray arrayWithObjects:name, nil];
        //NSArray *sortDescriptors = @[name];
        
        
        //[request setSortDescriptors:sortDescriptors];
        

       
    }
}

#pragma tableview datasource and delegate methods



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    
    
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    
        
    cell.detailTextLabel.text = [criteriaArray objectAtIndex:indexPath.row];
    //cell.textLabel.text = [criteriaArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [fullNameArray objectAtIndex:indexPath.row];
    
    //[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    [cell setAccessoryType:NO];
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:12.0f];
    
    //cell.imageView.image = [UIImage imageNamed:@"first.png"];
    
    
    
    //UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    
    
    //imgView.image = [UIImage imageNamed:@"first.png"];
    

    UIImageView *yourImageView = [[UIImageView alloc] initWithFrame:CGRectMake(cell.frame.size.width-40, cell.frame.size.height/4 ,30,30)];
    
    [yourImageView setImage:[UIImage imageNamed:@"first.png"]]; //You can have an Array with the name of
    
    [cell addSubview:yourImageView];
    
    
    /*
    UIImageView *imgView;
    UIView *imageContainer = [[UIView alloc] initWithFrame:cell.frame];
    imageContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageContainer.contentMode = UIViewContentModeRight;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    imgView.center = CGPointMake(imageContainer.frame.size.width-70, imageContainer.frame.size.height/2);
    [imageContainer addSubview:imgView];
    [cell.contentView addSubview:imageContainer];
*/
    
    
    return cell;
}




- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self topListView] numberOfRowsInSection:0];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return NO;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NULL;
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [criteriaArray count];
}

@end
