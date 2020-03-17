//
//  CloudSearchResultViewController.m
//  CloudRun
//
//  Created by PAN on 2014/10/1.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "CloudSearchResultViewController.h"

@interface CloudSearchResultViewController ()

@property (weak, nonatomic) IBOutlet UITableView *ResultTableview;

@property (strong, nonatomic) NSArray *nameArray;

@property (strong, nonatomic) DataHelper *dh;

@end

@implementation CloudSearchResultViewController

- (void)viewDidLoad {
	
    [super viewDidLoad];
	self.dh = [[DataHelper alloc] init];
	self.nameArray = [self.dh sqlSelectModelCommand:@"select *"
										  fromTable:@"cloud_member"
											  where:[NSString stringWithFormat:@"where userName like '%@%@%@'", @"%", self.searchName, @"%"]];
}


#pragma mark - Handle Tableview Delegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.nameArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identity = @"PlayerNameCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
	}
	
	PlayerModel *playerModel = [self.nameArray objectAtIndex:indexPath.row];
	cell.textLabel.text = playerModel.name;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ( [segue.identifier isEqualToString:@"PlayerVideoSegue"] ) {
		if ( [segue.destinationViewController isKindOfClass:[CloudPlayerVideoViewController class]] ) {
			CloudPlayerVideoViewController *cpvvc = (CloudPlayerVideoViewController *) segue.destinationViewController;
			NSIndexPath *path = [self.ResultTableview indexPathForSelectedRow];
			PlayerModel *playerModel = [self.nameArray objectAtIndex:path.row];
			cpvvc.playerName = playerModel.name;
		}
	}
}

@end
