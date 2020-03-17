//
//  SearchPlayerViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/14.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "SearchPlayerViewController.h"

@interface SearchPlayerViewController ()

@property (strong, nonatomic) PlayerRouteViewController *prvc;

@end

@implementation SearchPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

#pragma mark - Handle Button Press Event

- (IBAction)pressExpand:(UIButton *)sender {
	
	if ([self.parentViewController isKindOfClass:[PlayerRouteViewController class]]) {
		PlayerRouteViewController *prvc = (PlayerRouteViewController *)self.parentViewController;
		[prvc expandAnimation];
	}
}

@end
