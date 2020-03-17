//
//  FilterViewController.m
//  CloudRun
//
//  Created by PAN on 2014/7/23.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

#pragma mark - Init

- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark - Handle Button Press Envent

- (IBAction)pressCancelButton:(UIBarButtonItem *)sender
{
	[self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)pressOKButton:(UIBarButtonItem *)sender {
	[self.presentedViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Handle Child Controller

- (void) setSelectValue
{
	for (id vc in self.childViewControllers) {
		if ([vc isKindOfClass:[DatePickerViewController class]]) {
			DatePickerViewController *dpvc = vc;
			self.month = dpvc.pickerSelectMonth;
			self.year = dpvc.pickerSelectYear;
		}
		else if ([vc isKindOfClass:[KindTableViewController class]]){
			KindTableViewController *ktvc = vc;
			self.kind = ktvc.selectKind;
		}
	}
}

@end
