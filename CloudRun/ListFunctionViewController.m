//
//  ListFunctionViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/25.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "ListFunctionViewController.h"

@interface ListFunctionViewController ()

//@property (strong, nonatomic) NSArray *playerDetail;

@property (strong, nonatomic) PlayerModel *player;

@end

@implementation ListFunctionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Handle press Button Event

- (IBAction)pressListFunctionButton:(UIButton *)sender {
	
	[self findPlayer];
}

- (IBAction)pressFollowButton:(UIButton *)sender {
	
#warning follow button no implementation
}

# pragma mark - Find Player

- (void) findPlayer
{
	if ([self.parentViewController isKindOfClass:[PlayerDetailViewController class]]) {
		PlayerDetailViewController *pdvc = (PlayerDetailViewController *) self.parentViewController;
		//self.playerDetail = pdvc.playerDetaile;
		self.player = pdvc.player;
		[pdvc setExpand:NO];
	}
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AboutSegue"]) {
		if ([segue.destinationViewController isKindOfClass:[AboutViewController class]]) {
			AboutViewController *avc = (AboutViewController *) segue.destinationViewController;
			avc.player = self.player;
		}
	}
	else if ([segue.identifier isEqualToString:@"CompareSegue"]){
		if ([segue.destinationViewController isKindOfClass:[CompareRouteViewController class]]) {
			CompareRouteViewController *crvc = segue.destinationViewController;
			crvc.player = self.player;
		}
	}
	else if ([segue.identifier isEqualToString:@"MessageSegue"]){
		if ([segue.destinationViewController isKindOfClass:[MessageViewController class]]) {
			MessageViewController *mvc = segue.destinationViewController;
			mvc.player = self.player;
		}
	}
}
@end
