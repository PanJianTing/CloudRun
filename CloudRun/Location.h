//
//  Location.h
//  CloudRun
//
//  Created by PAN on 2014/8/22.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;
@property (strong, nonatomic) NSString *distance;
@property (strong, nonatomic) NSString *speed;
@property (strong, nonatomic) NSString *time;


@end
