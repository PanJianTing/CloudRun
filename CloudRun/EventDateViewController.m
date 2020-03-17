//
//  EventDateViewController.m
//  CloudRun
//
//  Created by PAN on 2014/7/28.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "EventDateViewController.h"

@interface EventDateViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *DateCollectView;

@property (strong, nonatomic) NSMutableArray *dateArray;
@property (strong, nonatomic) NSMutableArray *dateLabelArray;


@property (strong, nonatomic) NSDate *selectDate;
@property (strong, nonatomic) NSDateFormatter *formatter;
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger year;

@property (nonatomic) UIDynamicAnimator *animator;

@end


@implementation EventDateViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.dateArray = [[NSMutableArray alloc] init];
	self.dateLabelArray = [[NSMutableArray alloc] init];
	self.selectDate = [[NSDate alloc] init];
	self.formatter = [[NSDateFormatter alloc] init];
	
	
	[self handleDate];
	[self updateUI];
	[self handleDateEvent];
	// Do any additional setup after loading the view.
}

#pragma mark - Handle Date And Title Label

- (void) updateUI
{
	NSString *text = [[NSString alloc] init];
	
	text = [text stringByAppendingFormat:@"%d", self.year];
	text = [text stringByAppendingString:@"年 "];
	text = [text stringByAppendingFormat:@"%d", self.month];
	text = [text stringByAppendingString:@"月"];
	
	self.navigationItem.title = text;
}

- (void) handleDate
{
	NSString *monthStr = [[NSString alloc] init];
	NSString *yearStr = [[NSString alloc] init];
	
	[self.formatter setDateFormat:@"y"];
	yearStr = [self.formatter stringFromDate:self.selectDate];
	
	[self.formatter setDateFormat:@"MM"];
	monthStr = [self.formatter stringFromDate:self.selectDate];
	NSLog(@"%@", monthStr);
	
	self.year = [yearStr intValue];
	self.month = [monthStr intValue];
}

- (int) nowYear
{
	NSString *yearStr = [[NSString alloc] init];
	NSDate *nowDate = [[NSDate alloc] init];
	
	[self.formatter setDateFormat:@"y"];
	yearStr = [self.formatter stringFromDate:nowDate];
	
	return [yearStr intValue];
}

- (void) checkYearMonth
{
	if (self.month > 12) {
		self.year++;
		self.month = 1;
	}
	else if (self.month < 1)
	{
		self.year--;
		self.month = 12;
	}
}

#pragma mark - Handle Database Data

- (void) handleDateEvent
{
	//DataHelper *dh = [[DataHelper alloc] init];
//	self.dateArray = [dh FetchDate:self.month searchYear:self.year];
}


#pragma mark - Handle Collect Data

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"DateCollectCell";
	CollectionLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
	
	if (cell == nil)
	{
		cell = [[CollectionLabelCell alloc] init];
	}

	cell.label.text = [self.dateArray objectAtIndex:indexPath.row];
	cell.layer.cornerRadius = 10;
	cell.layer.masksToBounds = YES;
	return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.dateArray count];
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

#pragma mark - Handle Swipe Gesture

- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)sender {
	
	switch (sender.direction) {
		case UISwipeGestureRecognizerDirectionRight:
			self.month--;
			break;
			
		case UISwipeGestureRecognizerDirectionLeft:
			self.month++;
			break;
			
		default:
			break;
	}
	[self checkYearMonth];
	[self updateUI];
	[self handleDateEvent];
	[self.DateCollectView reloadData];
	
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DateSegue"]) {
		if ([segue.destinationViewController isKindOfClass:[CloudRunViewController class]]) {
			CloudRunViewController *crvc = segue.destinationViewController;
			NSIndexPath *path = [self.DateCollectView.indexPathsForSelectedItems firstObject];
			CollectionLabelCell *cell = (CollectionLabelCell *)[self.DateCollectView cellForItemAtIndexPath:path];
			if ([cell isKindOfClass:[CollectionLabelCell class]]) {
				crvc.date = cell.label.text;
				crvc.year = self.year;
			}
		}
	}
}

#pragma mark -  Handle Animation

- (void) pushBehavior
{
	UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.DateCollectView] mode:UIPushBehaviorModeInstantaneous];
	
	pushBehavior.magnitude = 1.0;
	pushBehavior.angle = 180 / 180 * M_PI;
	
	[animator addBehavior:pushBehavior];
	
	self.animator = animator;
}

//- (void)

@end
