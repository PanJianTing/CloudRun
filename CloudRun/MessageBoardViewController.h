//
//  MessageBoardViewController.h
//  CloudRun
//
//  Created by PAN on 2014/9/4.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "DataHelper.h"


@interface MessageBoardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *MessageTableview;
@property (nonatomic) NSInteger playerId;

- (void)getMessageData;

@end
