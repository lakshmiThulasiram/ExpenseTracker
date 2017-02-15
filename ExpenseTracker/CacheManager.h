//
//  CacheManager.h
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User+CoreDataClass.h"
#import "User+CoreDataProperties.h"

@interface CacheManager : NSObject
+(instancetype)sharedInstance;
@property (nonatomic, strong)User       *currentUser;
@end
