//
//  AboutViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/25.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.title = self.player.name;
	[self HandleChildVCs];
}

- (void) HandleChildVCs
{
	for ( id vc in self.childViewControllers) {
		if ([vc isKindOfClass:[AboutProfileViewController class]]) {
			AboutProfileViewController *apvc = vc;
			apvc.PhotoImage.image = [UIImage imageNamed:self.player.photo];
			apvc.ContryLabel.text = self.player.city;
			apvc.SexImage.image = [UIImage imageNamed:self.player.sex];
			apvc.FollowLabel.text = [NSString stringWithFormat:@"有 %ld 人追蹤您", self.player.followCount];
		}
	}
}



@end
