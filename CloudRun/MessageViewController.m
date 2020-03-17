//
//  MessageViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/25.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.title = self.player.name;
	[self handleChildVCs];
}

- (void) handleChildVCs
{
	for ( id vc in self.childViewControllers ) {
		NSLog(@"%@", vc);
		if ([vc isKindOfClass:[MessageBoardViewController class]]) {
			MessageBoardViewController *mbvc = vc;
			mbvc.playerId = self.player.number.intValue;
		}
		else if ([vc isKindOfClass:[SendMessageViewController class]]){
			SendMessageViewController *smvc = vc;
			smvc.playerId = self.player.number.intValue;
		}
	}
}

- (void) reloadMessageTableview
{
	for ( id vc in self.childViewControllers ) {
		if ([vc isKindOfClass:[MessageBoardViewController class]]) {
			MessageBoardViewController *mbvc = vc;
			[mbvc getMessageData];
			[mbvc.MessageTableview reloadData];
			[mbvc.MessageTableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
		}
	}
}

@end
