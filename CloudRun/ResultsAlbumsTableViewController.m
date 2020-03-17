//
//  ResultsAlbumsTableViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/4.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "ResultsAlbumsTableViewController.h"

@interface ResultsAlbumsTableViewController ()

@property (strong, nonatomic) DataHelper *dh;

@end

@implementation ResultsAlbumsTableViewController

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
		//[NSString stringWithFormat:@"select * from running_albumlist where EVENT_F like '%@%@%@'", @"%", name, @"%"];
		self.resultArray = [self.dh sqlSelectModelCommand:@"Select *"
											   fromTable:@"running_albumlist"
												   where:[NSString stringWithFormat:@"Where EVENT_F like '%@%@%@'", @"%", self.searchText, @"%" ]];
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
		cell = [[MemoryEventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	
	EventAlbumsModel *eventAlbums = [self.resultArray objectAtIndex:indexPath.row];
	
	cell.textLabel.text = eventAlbums.event;
	cell.accessoryType = UITableViewCellStyleDefault;
	
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
	if ([segue.identifier isEqualToString:@"ResultAlbumsSegue"]) {
		if ([segue.destinationViewController isKindOfClass:[EventAlbumsTableViewController class]]) {
			EventAlbumsTableViewController *eatvc = segue.destinationViewController;
			NSIndexPath *path = [self.tableView indexPathForSelectedRow];
			eatvc.eventAlbumsModel = [self.resultArray objectAtIndex:path.row];
		}
	}

}



@end
