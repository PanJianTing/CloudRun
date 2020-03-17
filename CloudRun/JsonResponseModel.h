//
//  JsonResponseModel.h
//  CloudRun
//
//  Created by PAN on 2014/8/14.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JsonResponseModel : NSObject

- (NSDictionary *) getJsonAllPlayer;
- (NSDictionary *) getJsonOnePlayerWithID : (NSString *) playerID;


@end
