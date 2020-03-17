//
//  MemoryEventViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/4.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "MemoryEventViewController.h"

#define TABLEVIEW_HEIGHT self.view.bounds.size.height
#define TABLEVIEW_WIDTH self.view.bounds.size.width
#define TABLEVIEW_X self.view.bounds.origin.x
#define TABLEVIEW_Y self.view.bounds.origin.y

@interface MemoryEventViewController ()
@property (weak, nonatomic) IBOutlet UIView *DateSelectContainer;
@property (weak, nonatomic) IBOutlet UITableView *EventTableview;
@property (weak, nonatomic) IBOutlet UILabel *SorryLabel;

@property (strong, nonatomic) DataHelper *dh;

@property (strong, nonatomic) NSMutableArray *eventAlumbsArray;
@property (strong, nonatomic) NSString *searchDate;
@property (nonatomic) BOOL isDateShow;

@property (nonatomic) CGRect origin;

@end

@implementation MemoryEventViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.dh = [[DataHelper alloc] init];
	self.selectDate = [[NSDate alloc] init];
	self.origin = self.DateSelectContainer.frame;
	self.isDateShow = NO;
	
	self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
	
	[self handleFirstDate];
	//select * from running_albumlist where EVENT_DT_F like '%@%@%@' order by EVENT_DT_F", @"%", date, @"%"
	
	NSString *whereStr = [NSString stringWithFormat:@"Where EVENT_DT_F like '%@%@%@'", @"%", @"2014/07/", @"%"];
	self.eventAlumbsArray = [self.dh sqlSelectModelCommand:@"Select * "
												fromTable:@"running_albumlist"
													where:whereStr
													order:@"Order by EVENT_DT_F"];
	
	//self.eventAlumbsArray = [self.dh FetchAlbumsListWithDate:@"2014/07/"];
	//self.eventAlumbsArray = [self.dh FetchAlbumsListWithDate:self.searchDate];
	[self checkHaveEvent];
}


#pragma mark - Handle UI
- (void) handleFirstDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"y/MM"];
	self.searchDate = [formatter stringFromDate:self.selectDate];
}

- (void) checkHaveEvent
{
	if (![self.eventAlumbsArray count]) {
		self.SorryLabel.hidden = NO;
		self.EventTableview.alpha = 0.3;
		self.EventTableview.multipleTouchEnabled = NO;
		self.EventTableview.scrollEnabled = NO;
	} else {
		self.SorryLabel.hidden = YES;
		self.EventTableview.alpha = 1;
		self.EventTableview.multipleTouchEnabled = YES;
		self.EventTableview.scrollEnabled = YES;
	}
}

- (void) handleDate
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"y/MM/dd"];
	self.searchDate = [df stringFromDate:self.selectDate];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.eventAlumbsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"AlbumsEventCell";
    MemoryEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
	if (cell == nil) {
		cell = [[MemoryEventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	
	EventAlbumsModel *eventAlbums = [self.eventAlumbsArray objectAtIndex:indexPath.row];
	
	cell.DateLabel.text = [eventAlbums.eventDate stringByReplacingOccurrencesOfString:@"2014/" withString:@""];
	cell.TitleLabel.text = eventAlbums.event;
	cell.ClickRateLabel.text = eventAlbums.clickRate;
	//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

#pragma mark - Handle Button Press Events

- (IBAction)dateButtonPress:(UIBarButtonItem *)sender{
	[self keyboardDown];
	[self handleAnimator];
}

#pragma mark - Hanedle Date Container Animation

- (void) selectDateViewReturnHandle
{
	[self handleDate];
	
	NSString *whereStr = [NSString stringWithFormat:@"Where EVENT_DT_F like '%@%@%@'", @"%", self.searchDate, @"%"];
	self.eventAlumbsArray = [self.dh sqlSelectModelCommand:@"Select * "
												fromTable:@"running_albumlist"
													where:whereStr
													order:@"Order by EVENT_DT_F"];
	
	[self.EventTableview reloadData];
	[self handleAnimator];
	[self checkHaveEvent];
}

#pragma mark - Handle Aninaior

- (void) handleAnimator
{
	if (self.isDateShow) {
		[UIView animateWithDuration:0.5
						 animations:^(void){
							 self.DateSelectContainer.frame = self.origin;
							 self.EventTableview.alpha = 1;
							 self.EventTableview.userInteractionEnabled = YES;
							 self.EventTableview.multipleTouchEnabled = YES;
							 self.EventTableview.scrollEnabled = YES;
						 }
						 completion:^(BOOL finished){
							 self.isDateShow = NO;
							 self.DateSelectContainer.hidden = YES;
						 }];
	} else {
		[UIView animateWithDuration:0.5
						 animations:^(void){
							 self.EventTableview.alpha = 0.3;
							 self.EventTableview.userInteractionEnabled = NO;
							 self.EventTableview.multipleTouchEnabled = NO;
							 self.EventTableview.scrollEnabled = NO;
							 self.DateSelectContainer.hidden = NO;
							 self.DateSelectContainer.frame = CGRectMake(0, TABLEVIEW_HEIGHT - self.DateSelectContainer.frame.size.height, TABLEVIEW_WIDTH, self.DateSelectContainer.frame.size.height);
						 }
						 completion:^(BOOL finished){
							 self.isDateShow = YES;
						 }];
	}
}


#pragma mark - Handle SearchBar Keyboard Down

- (void) keyboardDown
{
	for (id vc in self.childViewControllers) {
		if ([vc isKindOfClass:[SearchViewController class]]) {
			[vc keyboardDown];
		}
	}
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"EventAlbumsSegue"]) {
		if ([segue.destinationViewController isKindOfClass:[EventAlbumsTableViewController class]]) {
			EventAlbumsTableViewController *eatvc = segue.destinationViewController;
			NSIndexPath *path = [self.EventTableview indexPathForSelectedRow];
			eatvc.eventAlbumsModel = [self.eventAlumbsArray objectAtIndex:path.row];
		}
	}
}


@end
