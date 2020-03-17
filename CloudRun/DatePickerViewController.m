//
//  DatePickerViewController.m
//  CloudRun
//
//  Created by PAN on 2014/7/29.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@property (strong, nonatomic) NSMutableArray *monthArray;
@property (strong, nonatomic) NSMutableArray *yearArray;
@property (strong, nonatomic) DataHelper *dh;


@end

@implementation DatePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.dh = [[DataHelper alloc] init];
	self.monthArray = [[NSMutableArray alloc] initWithObjects:@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", nil];
	self.yearArray = [self.dh FetchAllYear];
	self.pickerSelectMonth = [self.monthArray firstObject];
	self.pickerSelectYear = [self.yearArray firstObject];
}

#pragma mark - Handle Pickerview Delegate

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	switch (component) {
		case 0:
			return [self.yearArray count];
			
		case 1:
			return [self.monthArray count];
			
		default:
			return 0;
	}
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	switch (component) {
		case 0:
			return [self.yearArray objectAtIndex:row];
			
		case 1:
			return [self.monthArray objectAtIndex:row];
			
		default:
			return nil;
	}
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	switch (component) {
		case 0:
			self.pickerSelectYear = [self.yearArray objectAtIndex:row];
			break;
			
		case 1:
			self.pickerSelectMonth = [self.monthArray objectAtIndex:row];
			break;
			
		default:
			break;
	}
}

@end
