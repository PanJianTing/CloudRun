//
//  FilterViewController.h
//  CloudRun
//
//  Created by PAN on 2014/7/23.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerViewController.h"
#import "KindTableViewController.h"

@interface FilterViewController : UIViewController

@property (strong, nonatomic) NSString *month;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *kind;

- (void) setSelectValue;

@end
