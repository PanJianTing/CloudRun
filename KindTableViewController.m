//
//  KindTableViewController.m
//  CloudRun
//
//  Created by PAN on 2014/7/30.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "KindTableViewController.h"

@interface KindTableViewController ()

@property (strong, nonatomic) NSMutableArray *kindArray;

@end

@implementation KindTableViewController

-(void) viewDidLoad
{
	[self getData];
}

- (void) getData
{
	DataHelper *dh = [[DataHelper alloc] init];
	self.kindArray = [dh FetchAllKind];
}

#pragma mark - Handle Tableview Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.selectKind = [self.kindArray objectAtIndex:indexPath.row];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.kindArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"FilterCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	
	cell.textLabel.text = [self.kindArray objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
	
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


@end