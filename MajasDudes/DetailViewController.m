
//  DetailViewController.m
//  MajasDudes
//
//  Created by Jonathan Jonsson on 2013-05-01.
//  Copyright (c) 2013 Jonathan Jonsson. All rights reserved.
//

#import "DetailViewController.h"
#import "AddInformationViewController.h"
#import "FirstViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>



@interface DetailViewController ()
{
    //NSMutableArray * criteriaArray;
    NSManagedObjectContext *context;
    NSFetchedResultsController *fetchedResultsController;
    NSMutableArray * informationArray;
    NSData *imageData;
    //UIImage * buttonImage;
    UIButton * imageButton;
    //UIImagePickerController * imagePicker;
    
}


@end

@implementation DetailViewController


Criteria * criteria;
bool firstnameDidload;
bool lastnameDidload;
bool nicknameDidload;
bool bodyDidload;
bool intelligenceDidload;
bool sexDidload;
bool humorDidload;
bool imageLoaded;
NSString * nicknameForImage;
UIImage * profilePicture;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 1;
}



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
    }
    return self;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundView = nil;
    self.view.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    
    imageLoaded = false;
     
    /*
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    */
    
    firstnameDidload = false;
    lastnameDidload=false;
    nicknameDidload=false;
    bodyDidload=false;
    intelligenceDidload=false;
    sexDidload=false;
    humorDidload=false;
    
    [self.tableView setShowsVerticalScrollIndicator:NO];
   
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];

    
    informationArray = [[NSMutableArray alloc]init];

    [self getDataForSelectedRow];

    
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.contentInset = inset;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return 1;
        //case 2:
          //  return 1;
        default:
            return 4;
    }

}
 

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:1];
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

-(void)getDataForSelectedRow{
   
   
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Criteria" inManagedObjectContext:context];
    NSFetchRequest *request= [[NSFetchRequest alloc]init];
    
 
    [request setEntity:entityDescription ];
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"first_name like %@ and last_name like %@", @"*", @"*"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nick_name like %@", _fetchedStringFromSelectedItem];
    
    
    [request setPredicate:predicate];
    NSError *error;
    NSArray * matchingData = [context executeFetchRequest:request error:&error];
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
        NSString *imageURL;
        //NSString *totalInteger;
        
               
        for (NSManagedObject *obj in matchingData) {
            
            
            nicknameNSString = [obj valueForKey:@"nick_name"];
            nicknameForImage = [obj valueForKey:@"nick_name"];;
            firstnameNSString = [obj valueForKey:@"first_name"];
            lastnameNSString = [obj valueForKey:@"last_name"];
            bodyInteger = [obj valueForKey:@"body"];
            intelligenceInteger = [obj valueForKey:@"intelligence"];
            humorInteger = [obj valueForKey:@"humor"];
            sexInteger = [obj valueForKey:@"sex"];
            imageURL = [obj valueForKey:@"image"];
            //totalInteger = [obj valueForKey:@"total"];
            
            if([obj valueForKey:@"nick_name"]){
                [informationArray addObject:nicknameNSString];
            }
            if([obj valueForKey:@"first_name"]){
                [informationArray addObject:firstnameNSString];
            }
            if([obj valueForKey:@"last_name"]){
                [informationArray addObject:lastnameNSString];
            }
            if([obj valueForKey:@"body"]){
                [informationArray addObject:bodyInteger];
            }
            if([obj valueForKey:@"humor"]){
                [informationArray addObject:intelligenceInteger];
            }
            if([obj valueForKey:@"sex"]){
                [informationArray addObject:humorInteger];
            }
            if([obj valueForKey:@"intelligence"]){
                [informationArray addObject:sexInteger];
            }
            if([obj valueForKey:@"image"]){
                [informationArray addObject:imageURL];
            }
        }
    }
}

//Adds a photo from the camera library
- (IBAction) addPhoto:(id) sender{
    
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePicker animated:YES completion:nil];
    
}

//Adds object at every cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
  
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    if(indexPath.section == 0){
        if(indexPath.row == 0){
           
            
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", [informationArray objectAtIndex:1], [informationArray objectAtIndex:2]];
            //cell.detailTextLabel.text = @"Nickname";
            cell.textLabel.text = [informationArray objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
            //if(!imageLoaded){
            if([paths objectAtIndex:0] != NULL){
                NSLog(@"BILD SKAPAD");
               

                if([paths objectAtIndex:0] != NULL){
                    
                                      
                           
                    NSLog(@"NICNAKEKEKAMK: %@", nicknameForImage);
                    
                    
                    //NSString *imgName= [[NSUserDefaults standardUserDefaults]valueForKey:nicknameForImage];
                    NSString *fileName = [NSString stringWithFormat:@"%@%@", nicknameForImage, @".jpg"];
                    
                    
                    NSLog(@"%@", fileName);
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *documentsDirectory = [paths objectAtIndex:0];
                    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:fileName];
                   
                    NSData *retrievedData = [NSData dataWithContentsOfFile:savedImagePath];
                    
                    
                    NSLog(@"DOCUMENT %@", documentsDirectory);
                    
                    
                    UIImage *buttonImage = [UIImage imageWithData:retrievedData];
                    imageData = UIImageJPEGRepresentation(buttonImage, 1.0);
                    
                    
                   
                    
                    
                                     
                    imageButton =  [UIButton buttonWithType:UIButtonTypeCustom];
                    [imageButton setFrame:CGRectMake(cell.frame.size.width-140, cell.frame.size.height/4 ,120,120)];
                    [imageButton viewWithTag:indexPath.row] ;
                    [imageButton addTarget:self action:@selector(addPhoto:) forControlEvents: UIControlEventTouchUpInside];
                    //[imageButton setImage:buttonImage forState:UIControlStateNormal];
                    [imageButton setImage:buttonImage forState:UIControlStateNormal];
                    
                    [cell addSubview:imageButton];

                    
                    
                }
            //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(cell.frame.size.width-140, cell.frame.size.height/4 ,120,120)];
            //[imageView setImage:[UIImage imageNamed:@"silouette.png"]];
            }
                else{
                    NSLog(@"else");
            UIImage * buttonImage = [UIImage imageNamed:@"silouette.png"];
            
                
            imageButton =  [UIButton buttonWithType:UIButtonTypeCustom];
            [imageButton setFrame:CGRectMake(cell.frame.size.width-140, cell.frame.size.height/4 ,120,120)];
            [imageButton viewWithTag:indexPath.row] ;
            [imageButton addTarget:self action:@selector(addPhoto:) forControlEvents: UIControlEventTouchUpInside];
            [imageButton setImage:buttonImage forState:UIControlStateNormal];
            
            [cell addSubview:imageButton];
            //[cell addSubview:imageView];
                }
            imageLoaded = true;
            
            
            
        }
        else if(indexPath.row == 1){
            //cell.textLabel.text = [informationArray objectAtIndex:1];
            cell.detailTextLabel.text = @"First Name";
            cell.textLabel.text = [informationArray objectAtIndex:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if(indexPath.row == 2){
            cell.detailTextLabel.text = @"Last Name";
            //cell.textLabel.text = [informationArray objectAtIndex:2];
            cell.textLabel.text = [informationArray objectAtIndex:2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
    }
    
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            cell.detailTextLabel.text = @"Body";
            cell.textLabel.text = [informationArray objectAtIndex:3];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if(indexPath.row == 1){
            cell.detailTextLabel.text = @"Humor";
            cell.textLabel.text = [informationArray objectAtIndex:4];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if(indexPath.row == 2){
            cell.detailTextLabel.text = @"Sex";
            cell.textLabel.text = [informationArray objectAtIndex:5];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if(indexPath.row == 3){
            cell.detailTextLabel.text = @"Intelligence";
            cell.textLabel.text = [informationArray objectAtIndex:6];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
    if (indexPath.row == 0) {
        return 150;
    } else {
        return 60;
    }
    }
    else return 42;
}

//NOT USED
/*
-(void)addImageURLToCoreData:(NSURL *)url{
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Criteria" inManagedObjectContext:context];
    NSManagedObject * newImage = [[NSManagedObject alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:context];
     NSLog(@"NO ERROR SO FAR");
   
        
    [newImage setValue:url forKey:@"image"];
    NSError *error;
        
    [context save:&error];
        
    NSLog(@"%@ added", [newImage valueForKey:@"image"]);
        

}
 */

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
   
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@%@", nicknameForImage, @".jpg"];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    UIImage* tempImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    NSLog(@"NAMN PÅ BILD: %@", nicknameForImage);
    
    //imageData = UIImagePNGRepresentation(profilePicture);
    imageData = UIImageJPEGRepresentation(tempImage, 1.0);
   
    [imageData writeToFile:savedImagePath atomically:YES];
    
    NSLog(@"-------------------------: %@", savedImagePath);
    NSLog(@"-------------------------");
    
   
   
    
    ///Users/jonathanjonsson/Library/Application Support/iPhone Simulator/6.1/Applications/C8FCAC67-E39B-4BCA-8D1D-DC8AB4BF51FF/Documents/Jonta
    ///Users/jonathanjonsson/Library/Application Support/iPhone Simulator/6.1/Applications/C8FCAC67-E39B-4BCA-8D1D-DC8AB4BF51FF/Documents/Jonta
    ///Users/jonathanjonsson/Library/Application Support/iPhone Simulator/6.1/Applications/C8FCAC67-E39B-4BCA-8D1D-DC8AB4BF51FF/Documents/
    
    

    
    [self.tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
    */
}



@end
