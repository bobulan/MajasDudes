//
//  Criteria.h
//  MajasDudes
//
//  Created by Jonathan Jonsson on 2013-04-28.
//  Copyright (c) 2013 Jonathan Jonsson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Criteria : NSManagedObject

@property (nonatomic, retain) NSString * nick_name;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * intelligence;
@property (nonatomic, retain) NSString * humor;
@property (nonatomic, retain) NSString * sex;


@end
