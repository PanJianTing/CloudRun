//
//  CloudRunViewController.m
//  CloudRun
//
//  Created by PAN on 2014/7/18.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "CloudRunViewController.h"
#define DATELABEL_HEIGHT self.dateLabel.frame.size.height


@interface CloudRunViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *eventArray;

@property (strong, nonatomic) IBOutlet UITableView *dataTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filterButton;

@end

@implementation CloudRunViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.eventArray = [[NSMutableArray alloc] init];

	CGRect bounds = [self.dataTableView bounds];
	bounds.origin.y += self.searchBar.bounds.size.height;
	[self.dataTableView setBounds:bounds];
	[self handleEventDate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Handle Event Data

- (void) handleEventDate
{
	//DataHelper *dh = [[DataHelper alloc] init];
	//self.eventArray = [dh FetchEventWithDate:self.date searchYear:self.year];
}

#pragma mark - Tableview Delegate Handle

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"DataCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	
	EventModel *eventModel = [self.eventArray objectAtIndex:indexPath.row];
	
	cell.textLabel.text = eventModel.event;
	cell.accessoryType = UITableViewCellStyleDefault;
	cell.layer.cornerRadius = 20.0;
	
	
	return cell;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.eventArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"";
}

#pragma mark - Handle Button Press Event

- (IBAction)pressFilterButton:(id)sender
{
	NSLog(@"7/29 implement");
}

#pragma mark - Handle Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"FilterSegue"]) {
		if ([segue.destinationViewController isKindOfClass:[FilterViewController class]]) {
			FilterViewController *fvc = segue.destinationViewController;
			fvc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
			fvc.modalPresentationStyle = UIModalPresentationFormSheet;
			fvc.view.backgroundColor = [UIColor lightGrayColor];
		}
	}
	else if ([segue.identifier isEqualToString:@"EventSegue"]){
		if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
			DetailViewController *dvc = segue.destinationViewController;
			NSIndexPath *path = [self.dataTableView indexPathForSelectedRow];
			dvc.eventModel = [self.eventArray objectAtIndex:path.row];
		}
	}
}

@end