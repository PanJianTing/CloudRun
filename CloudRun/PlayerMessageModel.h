//
//  PlayerMessageModel.h
//  CloudRun
//
//  Created by PAN on 2014/9/3.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerMessageModel : NSObject

@property (nonatomic) NSInteger autoId;
@property (strong, nonatomic) NSString *senderName;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *date;


@end
