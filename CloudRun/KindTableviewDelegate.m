//
//  TableviewDelegate.m
//  CloudRun
//
//  Created by PAN on 2014/7/23.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "KindTableviewDelegate.h"

@implementation KindTableviewDelegate


- (KindTableviewDelegate *) initWithVariable
{
	if (self == [super init]) {
		self.kindArray =[[NSMutableArray alloc] init];
		[self kindArray];
	}
	return self;
}

-(NSMutableArray *)selectTalbleViewDataArray:(int)select
{
	return nil;
}


- (void) getData
{
	DataHelper *dh = [[DataHelper alloc] init];
	self.kindArray = [dh FetchAllKind];
}

#pragma mark - Handle Tableview Delegate

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
