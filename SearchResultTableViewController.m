//
//  SearchResultTableViewController.m
//  CloudRun
//
//  Created by PAN on 2014/7/30.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "SearchResultTableViewController.h"

@interface SearchResultTableViewController ()

@property (strong, nonatomic) DataHelper *dh;

@end

@implementation SearchResultTableViewController


- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationItem.title = @"Results";
	self.dh = [[DataHelper alloc] init];
	[self searchResults];
}


#pragma mark - Handle Search Results

- (void) searchResults
{
	if (![self.searchText isEqualToString:@""]) {
		//self.resultArray = [self.dh FetchEventWithName:self.searchText];
		//[NSString stringWithFormat:@"select * from sportsnote_tw where EVENT_F Like '%@%@%@' Group by EVENT_F", @"%", name, @"%"];
		self.resultArray = [self.dh sqlSelectModelCommand:@"Select *"
											   fromTable:@"sportsnote_tw"
												   where:[NSString stringWithFormat:@"Where EVENT_F Like '%@%@%@'", @"%", self.searchText, @"%"]
												   group:@"Group by EVENT_F"];
	}
	[self checkResults];
}

#pragma mark - Handle Table view data source and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.resultArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"SearchResult";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	
	EventModel *eventModel = [self.resultArray objectAtIndex:indexPath.row];
	
	cell.textLabel.text = eventModel.event;
	return cell;
}

#pragma mark - Check Results

- (void) checkResults
{
	if (![self.resultArray count]) {
		UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Results"
													 message:@"Sorry, No Results"
													delegate:self
										   cancelButtonTitle:@"OK"
										   otherButtonTitles:nil];
		[av show];
	}
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SearchResultSegue"]){
		if ([segue.destinationViewController isKindOfClass:[MapviewViewController class]]) {
			MapviewViewController *mvc = segue.destinationViewController;
			NSIndexPath *path = [self.tableView indexPathForSelectedRow];
			mvc.eventModel = [self.resultArray objectAtIndex:path.row];
		}
	}
}


@end
