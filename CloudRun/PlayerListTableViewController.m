//
//  PlayerListTableViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/28.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "PlayerListTableViewController.h"

@interface PlayerListTableViewController ()

//@property (strong, nonatomic) NSArray *allPlayerArray;
//@property (strong, nonatomic) JsonResponseModel *jsonModle;
@property (strong, nonatomic) NSMutableArray *allPlayerArray;
@property (strong, nonatomic) DataHelper *dh;

@property (nonatomic) BOOL isPlayerSelect;
@property (nonatomic) CGRect tableOrigin;

@end

@implementation PlayerListTableViewController


- (void) viewWillAppear:(BOOL)animated
{
	if ( !self.isPlayerSelect ) {
		[self.tableView setFrame:CGRectMake(0, 64, self.tableOrigin.size.width, self.tableOrigin.size.height - 114)];
	} else {
		[self.tableView setFrame:CGRectMake(0, 0, self.tableOrigin.size.width, self.tableOrigin.size.height - 44)];
	}
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	//self.jsonModle = [[JsonResponseModel alloc] init];
	//self.allPlayerArray = [[self.jsonModle getJsonAllPlayer] valueForKey:@"list"];
	
	self.dh = [[DataHelper alloc] init];
	self.allPlayerArray = [self.dh sqlSelectModelCommand:@"Select *" fromTable:@"cloud_member"];
	[self getTrackerAndFollowCount];
	
	self.isPlayerSelect = NO;
	self.tableOrigin = self.tableView.frame;
}

- (void) getTrackerAndFollowCount
{
	for (PlayerModel *player in self.allPlayerArray) {
		if ([player isKindOfClass:[PlayerModel class]]) {
			player.followCount = [self.dh getPlayerFollowCountWithUserId:player.number];
			player.tracker = [self.dh sqlSelectModelCommand:@"Select *"
												  fromTable:@"runner_tracker"
													  where:[NSString stringWithFormat:@"Where userId = '%@'", player.number]];
		}
	}
}

#pragma mark - Handle Tableview Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.allPlayerArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"PlayerCell";
    PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
	if (cell == nil) {
		cell = [[PlayerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	
	PlayerModel *player = [self.allPlayerArray objectAtIndex:indexPath.row];
	
	cell.UserPhotoButton.imageView.image = [UIImage imageNamed:player.photo];
	cell.PlayerNameLabel.text = player.name;
	cell.PlayerNumerLabel.text = [NSString stringWithFormat:@"No. %@", player.number];
	cell.PlayerRankLabel.text = [NSString stringWithFormat:@"%ldth", indexPath.row + 1];
	
	return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PlayerDetail"]) {
		if ([segue.destinationViewController isKindOfClass:[PlayerDetailViewController class]]) {
			PlayerDetailViewController *pdvc = (PlayerDetailViewController *) segue.destinationViewController;
			NSIndexPath *path = [self.tableView indexPathForSelectedRow];
			pdvc.player = [self.allPlayerArray objectAtIndex:path.row];
			//pdvc.playerDetaile = [self.allPlayerArray objectAtIndex:path.row];
			self.isPlayerSelect = YES;
		}
	}
}

@end