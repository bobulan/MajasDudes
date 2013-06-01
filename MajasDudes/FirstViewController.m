//
//  FirstViewController.m
//  MajasDudes
//
//  Created by Jonathan Jonsson on 2013-04-27.
//  Copyright (c) 2013 Jonathan Jonsson. All rights reserved.
//

#import "FirstViewController.h"
#import "Criteria.h"
#import "AddPersonViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "DetailViewController.h"


@interface FirstViewController()
{
    NSMutableArray * criteriaArray;
    NSMutableArray * fullNameArray;
    NSManagedObjectContext *context;
    NSFetchedResultsController *fetchedResultsController;
    NSString * selectedPerson;
}

@end

@implementation FirstViewController
@synthesize selectedPerson;

Criteria * criteria;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	
    //[[self myDudeView]setDelegate:self]; //self.dudeView..delegate = self
    self.myDudeView.delegate = self;
    self.myDudeView.dataSource = self;
    //[[self myDudeView]setDataSource:self];
    
    criteriaArray = [[NSMutableArray alloc] init];
    fullNameArray = [[NSMutableArray alloc] init];

    
    [self.myDudeView setShowsVerticalScrollIndicator:NO];
    [self.myDudeView setScrollsToTop:NO];
   // [self.myDudeView setScrollEnabled:NO];
    //[self.myDudeView setContentOffset:CGPointZero animated:NO];
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    [self.myDudeView setSeparatorStyle:UITableViewCellSeparatorStyleNone];


    //[self getDataFromDataBase];
    
    //[self.myDudeView reloadData];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    self.myDudeView.backgroundColor = [UIColor clearColor];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.myDudeView.contentInset = inset;
    
    /*
    UISwipeGestureRecognizer *showExtrasSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipe:)];
    showExtrasSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.myDudeView addGestureRecognizer:showExtrasSwipe];
    */
    
}

-(void)getDataFromDataBase{
  
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];
    
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Criteria" inManagedObjectContext:context];
    NSFetchRequest *request= [[NSFetchRequest alloc]init];
    
    [request setEntity:entityDescription ];
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"first_name like %@ and last_name like %@", @"*", @"*"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nick_name like %@", @"*"];
    
    [request setPredicate:predicate];
    NSError *error;
    NSArray * matchingData = [context executeFetchRequest:request error:&error];
    
    if(matchingData.count <= 0){
        NSLog(@"No persons found");
    }
    else{
        NSString *firstnameNSString;
        NSString *lastnameNSString;
        NSString *nicknameNSString;
        NSString *bodyInteger; 
        NSString *intelligenceInteger;
        NSString *sexInteger;
        NSString *humorInteger;
        
        [criteriaArray removeAllObjects];
        [fullNameArray removeAllObjects];
        
        for (NSManagedObject *obj in matchingData) {
            firstnameNSString = [obj valueForKey:@"first_name"];
            lastnameNSString = [obj valueForKey:@"last_name"];
            nicknameNSString = [obj valueForKey:@"nick_name"];
            bodyInteger = [obj valueForKey:@"body"];
            intelligenceInteger = [obj valueForKey:@"intelligence"];
            humorInteger = [obj valueForKey:@"humor"];
            sexInteger = [obj valueForKey:@"sex"];
            
            [criteriaArray addObject:[NSString stringWithFormat:@"%@", nicknameNSString]];
            [fullNameArray addObject:[NSString stringWithFormat:@"%@ %@", firstnameNSString,lastnameNSString]];
            
        
        }
    }
        
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview datasource and delegate methods 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"SCROLL");
    
    //[self.myDudeView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataFromDataBase];
    [self.myDudeView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    NSLog(@"selected tableview row is %d",indexPath.row);
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *str = cell.textLabel.text;
    NSLog(@"selected content is %@", str);
    detailViewController.fetchedStringFromSelectedItem = str;
 
    [self.navigationController pushViewController:detailViewController animated:YES];
    NSLog(@"TESTING %@", self.selectedPerson);

}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [criteriaArray count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NULL;
}

-(void)cellSwipe:(UISwipeGestureRecognizer *)gesture{
    
    NSLog(@"SWWWWWIPPPE");
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

/*
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"AOIEHHOAEHOIHOIBEAHIOEABHIABEOIHBAHIE");
    [self.myDudeView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}
 */


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
       // [self.myDudeView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *content = cell.textLabel.text;

        NSLog(@"cell content %@", content);
        
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Criteria" inManagedObjectContext:context];
        NSFetchRequest *request  = [[NSFetchRequest alloc]init];
        [request setEntity:entityDescription];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nick_name like %@", content ];
        [request setPredicate:predicate];
        
        NSError *error;
        NSArray *matchingData =  [context executeFetchRequest:request error:&error];
        
        if(matchingData.count <= 0){
            NSLog(@"No person deleted");
        }
        else{
            int count = 0;
            for(NSManagedObject *obj in matchingData){
                [context deleteObject:obj];
                count++;
            }
            [context save:&error];
            NSLog(@"%d persons deleted", count);
        }
       // [self.myDudeView deleteRowsAtIndexPaths:matchingData withRowAnimation:UITableViewRowAnimationAutomatic];
        [criteriaArray removeObjectAtIndex:indexPath.row];
        [fullNameArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }

   
}

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self myDudeView] numberOfRowsInSection:0];
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
    
    
    //NSLog(@"%@", [fullNameArray objectAtIndex:0]);
    
    cell.textLabel.text = [criteriaArray objectAtIndex:indexPath.row];
    //cell.textLabel.text = [criteriaArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [fullNameArray objectAtIndex:indexPath.row];
    
   
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20.0f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:12.0f];
    /*
    cell.textLabel.numberOfLines=2;
    cell.textLabel.backgroundColor=[UIColor clearColor];
    */
    
    
    /*
    NSIndexPath *topPath = [NSIndexPath indexPathForRow:9 inSection:0];
    [self.myDudeView scrollToRowAtIndexPath:topPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    */
    
       
    return cell;
}



@end
