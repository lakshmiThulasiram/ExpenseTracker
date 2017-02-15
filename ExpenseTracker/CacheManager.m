//
//  CacheManager.m
//  ExpenseTracker
//
//  Created by Lakshmi Thulasiram on 15/02/17.
//  Copyright © 2017 Lakshmi Thulasiram. All rights reserved.
//

#import "CacheManager.h"
static CacheManager *sharedAppData;

@implementation CacheManager
@synthesize currentUser;
+(instancetype)sharedInstance
{
    if(!sharedAppData)
    {
        sharedAppData = [[CacheManager alloc] init];
        
    }
    return sharedAppData;
    
}
@end
