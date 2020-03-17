//
//  CloudPlayerVideoViewController.m
//  CloudRun
//
//  Created by PAN on 2014/10/1.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "CloudPlayerVideoViewController.h"

@interface CloudPlayerVideoViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *KindSegmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *KindTableview;

@property (strong, nonatomic) NSMutableArray *kindArray;
@property (strong, nonatomic) NSMutableArray *studioArray;

@end

@implementation CloudPlayerVideoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.kindArray = [[NSMutableArray alloc] init];
	self.studioArray = [[NSMutableArray alloc] init];
	self.navigationItem.title = self.playerName;
	[self setStudio];
	[self.kindArray addObject:@"相片"];
	[self.kindArray addObject:@"影片"];
	
}

#pragma mark - Handle Tableview Delegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//return self.nameArray.count;
	
	if (self.KindSegmentedControl.selectedSegmentIndex == 0) {
		return [self.studioArray count];
	}
	else if (self.KindSegmentedControl.selectedSegmentIndex == 1){
		return [self.kindArray count];
	} else {
		return 0;
	}
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *studioIdentity = @"StudioCell";
	static NSString *featureIdentity = @"FeaturedCell";
	if (self.KindSegmentedControl.selectedSegmentIndex == 0) {
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studioIdentity];
		
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:studioIdentity];
		}
		
		StudioModel *studioModel = [self.studioArray objectAtIndex:indexPath.row];
		cell.textLabel.text = studioModel.name;
		cell.detailTextLabel.text = studioModel.location;
		[cell.imageView setImage:[UIImage imageNamed:@"cloudcheer_studio"]];
		return cell;
	}
	else if (self.KindSegmentedControl.selectedSegmentIndex == 1){
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:featureIdentity];
		
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:featureIdentity];
		}
		
		cell.textLabel.text = [self.kindArray objectAtIndex:indexPath.row];;
		
		return cell;
	}
	
	return nil;
}

#pragma mark - Handle Switch Segmented Event

- (IBAction)switchSegmented:(UISegmentedControl *)sender {
	[self.KindTableview reloadData];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ( [segue.identifier isEqualToString:@"StudioSegue"] ) {
		if ( [segue.destinationViewController isKindOfClass:[CloudStudioViewController class]] ) {
			CloudStudioViewController *csvc = segue.destinationViewController;
			NSIndexPath *path = [self.KindTableview indexPathForSelectedRow];
			csvc.studioModel = [self.studioArray objectAtIndex:path.row];
		}
	}
	else if ( [segue.identifier isEqualToString:@"FeaturedSegue"] ) {
		if ([segue.destinationViewController isKindOfClass:[CloudFeaturedViewController class]]) {
			CloudFeaturedViewController *cfvc = segue.destinationViewController;
			NSIndexPath *path = [self.KindTableview indexPathForSelectedRow];
			cfvc.kind = [self.kindArray objectAtIndex:path.row];
		}
	}
}










































































- (void) setStudio
{
	StudioModel *studio = [[StudioModel alloc] init];
	studio.name = @"一號攝影棚";
	studio.location = @"冬山河親水公園停車場";
	[self.studioArray addObject:studio];
	
	StudioModel *studio2 = [[StudioModel alloc] init];
	studio2.name = @"二號攝影棚";
	studio2.location = @"冬山河親水公園起跑線";
	[self.studioArray addObject:studio2];
	
	StudioModel *studio3 = [[StudioModel alloc] init];
	studio3.name = @"三號攝影棚";
	studio3.location = @"冬山河親水公園折返點";
	[self.studioArray addObject:studio3];
	
	StudioModel *studio4 = [[StudioModel alloc] init];
	studio4.name = @"四號攝影棚";
	studio4.location = @"自行車道轉折點";
	[self.studioArray addObject:studio4];
	
	StudioModel *studio5 = [[StudioModel alloc] init];
	studio5.name = @"五號攝影棚";
	studio5.location = @"？？？？？？";
	[self.studioArray addObject:studio5];
	
	StudioModel *studio6 = [[StudioModel alloc] init];
	studio6.name = @"六號攝影棚";
	studio6.location = @"yayayayaya";
	[self.studioArray addObject:studio6];
}
@end
