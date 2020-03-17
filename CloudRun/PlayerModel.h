//
//  PlayerModel.h
//  CloudRun
//
//  Created by PAN on 2014/9/3.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface PlayerModel : NSObject

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *photo;
@property (strong, nonatomic) NSString *sex;
@property (strong, nonatomic) NSString *city;
@property (nonatomic) NSInteger followCount;
@property (strong, nonatomic) NSMutableArray *tracker;

@end
