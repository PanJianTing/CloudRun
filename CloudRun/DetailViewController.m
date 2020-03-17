//
//  DetailViewController.m
//  CloudRun
//
//  Created by PAN on 2014/7/24.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *EventLabel;
@property (weak, nonatomic) IBOutlet UILabel *LocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *EventdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *CatelogLabel;
@property (weak, nonatomic) IBOutlet UILabel *HostLabel;
@property (weak, nonatomic) IBOutlet UILabel *LimitDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *DescribeTextview;

@end

@implementation DetailViewController

@synthesize eventModel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void) setDetailViewFromEvent
{
	self.EventLabel.text = self.eventModel.event;
	self.LocationLabel.text = [NSString stringWithFormat:@"%@%@", self.eventModel.eventCity, self.eventModel.location];
	self.EventdateLabel.text = [NSString stringWithFormat:@"%@ %@", self.eventModel.year, self.eventModel.eventDate];
	self.CatelogLabel.text = [NSString stringWithFormat:@"%@ %@", self.eventModel.catelog, self.eventModel.item];
	self.HostLabel.text = self.eventModel.hostBy;
	self.LimitDateLabel.text = self.eventModel.dateLimit;
	[self.DescribeTextview setText:self.eventModel.desc];
	[self.DescribeTextview setTextColor:[UIColor whiteColor]];
}



- (IBAction)pressExpendButton:(UIButton *)sender {
	if ([self.parentViewController isKindOfClass:[MapviewViewController class]]) {
		MapviewViewController *mvc = (MapviewViewController *)self.parentViewController;
		[mvc moveExpandView];
	}
}



@end
