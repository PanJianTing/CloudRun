//
//  DatePickerViewController.h
//  CloudRun
//
//  Created by PAN on 2014/7/29.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHelper.h"

@interface DatePickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSString *pickerSelectYear;
@property (nonatomic, strong) NSString *pickerSelectMonth;

@end
