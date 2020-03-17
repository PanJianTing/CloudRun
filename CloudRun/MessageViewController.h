//
//  MessageViewController.h
//  CloudRun
//
//  Created by PAN on 2014/8/25.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerModel.h"
#import "MessageBoardViewController.h"
#import "SendMessageViewController.h"

@interface MessageViewController : UIViewController

@property (strong, nonatomic) PlayerModel *player;

- (void) reloadMessageTableview;

@end
