//
//  AddPlayerCompareViewController.h
//  CloudRun
//
//  Created by PAN on 2014/8/26.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHelper.h"
#import "CompareRouteViewController.h"

@interface AddPlayerCompareViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *PlayerTableview;

@property (nonatomic) NSInteger playerId;

@end
