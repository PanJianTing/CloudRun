//
//  CloudStudioViewController.m
//  CloudRun
//
//  Created by PAN on 2014/10/2.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "CloudStudioViewController.h"

@interface CloudStudioViewController ()

@property (strong, nonatomic) NSMutableArray *studioArray;

@end

@implementation CloudStudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = self.studioModel.name;
	self.studioArray = [[NSMutableArray alloc] init];
	[self.studioArray addObject:@"Jimmy Lin 於9:00抵達"];
	[self.studioArray addObject:@"Jimmy Lin 於11:00抵達"];
}

#pragma mark - Handle Tableview Delegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.studioArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identity = @"StudioVideoCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
	}
	
	cell.textLabel.text = [self.studioArray objectAtIndex:indexPath.row];
	[cell.imageView setImage:[UIImage imageNamed:@"ba"]];
	
	return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
