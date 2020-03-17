//
//  EventViewController.m
//  CloudRun
//
//  Created by PAN on 2014/7/29.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *DataTableView;
@property (weak, nonatomic) IBOutlet UILabel *SorryLabel;

@property (strong, nonatomic) NSMutableArray *eventArray;

@property (strong, nonatomic) DataHelper *dh;

@end

@implementation EventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.dh = [[DataHelper alloc] init];
	[self connectWithChildController];
	[self getEventWithDateAndYear:self.date Year:self.year];
}


#pragma mark - Handle Data

-(void) getEventWithDateAndYear:(NSString *)Date Year:(NSString *)Year
{
	//self.eventArray = [self.dh FetchEventWithDate:Date searchYear:Year];
	NSString *whereStr = [NSString stringWithFormat:@"Where EVENT_DT_F Like '%@%@%@' and YEAR_F Like '%@%@%@'", @"%", Date, @"%", @"%", Year, @"%"];
	
	self.eventArray = [self.dh sqlSelectModelCommand:@"Select * "
										  fromTable:@"sportsnote_tw"
											  where:whereStr
											  group:@"group by EVENT_F"];
	
	[self checkHaveEvent];
}

-(void) getEventWithKindAndDateAndYear:(NSString *)Date Year:(NSString *)Year Kind:(NSString *)kind
{
	//self.eventArray = [self.dh FetchEventWithDateAndKindAndYear:Date searchYear:Year searchKind:kind];
	
	if (!kind) kind = @"";
	
	NSString *whereStr = [NSString stringWithFormat:@"Where EVENT_DT_F Like '%@%@%@' and YEAR_F Like '%@%@%@' and CATELOG_F like '%@%@%@'", @"%", Date, @"%", @"%", Year, @"%", @"%", kind, @"%"];
	
	self.eventArray = [self.dh sqlSelectModelCommand:@"Select *"
										  fromTable:@"sportsnote_tw"
											  where:whereStr
											  group:@"Group by EVENT_F"];
	
	[self checkHaveEvent];
}

#pragma mark - Update UI

- (void) updateUIAfterUnwind
{
	[self connectWithChildController];
	[self getEventWithKindAndDateAndYear:self.date Year:self.year Kind:self.kind];
	[self.DataTableView reloadData];
}


- (void) updateTableviewEvent
{
	[self getEventWithKindAndDateAndYear:self.date Year:self.year Kind:self.kind];
	[self.DataTableView reloadData];
}

- (void) checkHaveEvent
{
	if (![self.eventArray count] ) {
		self.SorryLabel.hidden = NO;
		self.DataTableView.multipleTouchEnabled = NO;
		self.DataTableView.scrollEnabled = NO;
	} else {
		self.SorryLabel.hidden = YES;
		self.DataTableView.multipleTouchEnabled = YES;
		self.DataTableView.scrollEnabled = YES;
	}
}

#pragma mark Connect Child Controller

- (void) connectWithChildController
{
	for (id vc in self.childViewControllers) {
		if ([vc isKindOfClass:[SearchViewController class]]) {
			SearchViewController *svc = vc;
			self.date = [svc.dateArray firstObject];
			self.year = svc.year;
		}
	}
}

- (void) connectWithChildControllerAfterUnwind:(NSString *) month Year:(NSString *)year
{
	for (id vc in self.childViewControllers) {
		if ([vc isKindOfClass:[SearchViewController class]]) {
			SearchViewController *svc = vc;
			svc.month = month;
			svc.year = year;
			[svc updateDate];
			[svc.DateCollectionView reloadData];
		}
	}
}


#pragma mark - Handle Tableview Delegate

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
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@", eventModel.eventCity, eventModel.location];
	//cell.imageView.image = [UIImage imageNamed:@"rain30x30"];
	return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.eventArray count];
}


#pragma mark - Filter unwind

- (IBAction)filterUnwind :(UIStoryboardSegue *)sender
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ) {
		[self.presentedViewController dismissViewControllerAnimated:YES completion:NULL];
	}
	
	if ([sender.sourceViewController isKindOfClass:[FilterViewController class]]) {
		FilterViewController *fvc = sender.sourceViewController;
		[fvc setSelectValue];
		self.kind = fvc.kind;
		[self connectWithChildControllerAfterUnwind:fvc.month Year:fvc.year];
	}
	[self updateUIAfterUnwind];
}


#pragma mark - Handle Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"FilterSegue"]) {
		if ([segue.destinationViewController isKindOfClass:[FilterViewController class]]) {
			FilterViewController *fvc = segue.destinationViewController;
			fvc.modalPresentationStyle = UIModalPresentationFormSheet;
		}
	}
	else if ([segue.identifier isEqualToString:@"EventSegue"]){
		if ([segue.destinationViewController isKindOfClass:[MapviewViewController class]]) {
			MapviewViewController *mvc = segue.destinationViewController;
			NSIndexPath *path = [self.DataTableView indexPathForSelectedRow];
			mvc.eventModel = [self.eventArray objectAtIndex:path.row];
		}
	}
}

@end
