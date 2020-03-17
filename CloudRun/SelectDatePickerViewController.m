//
//  SelectDatePickerViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/4.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "SelectDatePickerViewController.h"

@interface SelectDatePickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *SelectDatePicker;
@property (strong, nonatomic) NSDate *selectDate;

@end

@implementation SelectDatePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.selectDate = [[NSDate alloc] init];
    // Do any additional setup after loading the view.
}

#pragma mark - Handle Button Press Event

- (IBAction)selectPicker:(UIDatePicker *)sender {
	self.selectDate = sender.date;
}

- (IBAction)pressDoneButton:(UIBarButtonItem *)sender {
	if ([self.parentViewController isKindOfClass:[MemoryEventViewController class]]) {
		MemoryEventViewController *metvc = (MemoryEventViewController *)self.parentViewController;
		metvc.selectDate = self.selectDate;
		[metvc selectDateViewReturnHandle];
	}
}

@end
