//
//  AddPlayerCompareViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/26.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "AddPlayerCompareViewController.h"

#define MAX_COUNT 4

@interface AddPlayerCompareViewController ()

@property (strong, nonatomic) NSMutableArray *allPlayerArray;

@property (strong, nonatomic) DataHelper *dh;

@end

@implementation AddPlayerCompareViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.dh = [[DataHelper alloc] init];
	self.allPlayerArray = [self.dh sqlSelectModelCommand:@"Select *" fromTable:@"cloud_member"];
	[self.allPlayerArray removeObjectAtIndex:self.playerId - 1];
}


#pragma mark - Handle Bar Button

- (IBAction)pressCancelBarButton:(UIBarButtonItem *)sender {
	
	[self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Check Select Row Count

- (BOOL) checkSelectCount
{
	if ([[self.PlayerTableview indexPathsForSelectedRows] count] >= MAX_COUNT )  {
		return NO;
	} else {
		return YES;
	}
}

#pragma mark - Handle Table View Delegate

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	
	cell.textLabel.text = [[self.allPlayerArray objectAtIndex:indexPath.row] valueForKey:@"name"];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"No.%@", [[self.allPlayerArray objectAtIndex:indexPath.row] valueForKey:@"number"]];
	cell.imageView.image = [UIImage imageNamed:[[self.allPlayerArray objectAtIndex:indexPath.row] valueForKey:@"photo"]];
	cell.accessoryType = UITableViewCellStyleDefault;
	
	return cell;
}

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([self checkSelectCount]) {
		[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
		return indexPath;
	} else {
		return nil;
	}
}

- (NSIndexPath *) tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellStyleDefault;
	return indexPath;
}

@end
