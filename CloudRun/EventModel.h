//
//  EventModel.h
//  CloudRun
//
//  Created by PAN on 2014/7/25.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventModel : NSObject

@property (strong, nonatomic) NSString *eventId;
@property (strong, nonatomic) NSString *area;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *event;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *catelog;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *eventDate;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *item;
@property (strong, nonatomic) NSString *enroll;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *clickRate;
@property (strong, nonatomic) NSString *hostBy;
@property (strong, nonatomic) NSString *dateLimit;
@property (strong, nonatomic) NSString *eventCity;


@end
