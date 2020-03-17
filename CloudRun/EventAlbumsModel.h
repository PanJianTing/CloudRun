//
//  EventAlbumsModel.h
//  CloudRun
//
//  Created by PAN on 2014/8/1.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlbumsModel.h"

@interface EventAlbumsModel : NSObject

@property (strong, nonatomic) NSString *eventAlbumsId;
@property (strong, nonatomic) NSString *eventDate;
@property (strong, nonatomic) NSString *event;
@property (strong, nonatomic) NSString *photoNumbers;
@property (strong, nonatomic) NSString *clickRate;
@property (strong, nonatomic) NSMutableArray *alumbs;

@end
