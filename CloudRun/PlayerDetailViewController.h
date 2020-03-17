//
//  PlayerDetailViewController.h
//  CloudRun
//
//  Created by PAN on 2014/8/15.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "JsonResponseModel.h"
#import "PlayerModel.h"


@interface PlayerDetailViewController : UIViewController

@property (strong, nonatomic) PlayerModel *player;


- (void) setExpand:(BOOL)isExpand;

@end
