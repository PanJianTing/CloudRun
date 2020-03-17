//
//  PlayerListViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/15.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "PlayerListViewController.h"

#define PLAYER_TABLEVIEW_WIDTH self.PlayerListTableview.frame.size.width
#define PLAYER_TABLEVIEW_HEIGHT self.PlayerListTableview.frame.size.height


@interface PlayerListViewController ()


@property (strong, nonatomic) NSArray *allPlayerArray;
@property (strong, nonatomic) JsonResponseModel *jsonModel;

@end

@implementation PlayerListViewController


- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

@end