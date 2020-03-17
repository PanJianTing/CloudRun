//
//  CloudRunViewController.h
//  CloudRun
//
//  Created by PAN on 2014/7/18.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHelper.h"
#import "CloudRunAppDelegate.h"
#import "FilterViewController.h"
#import "DetailViewController.h"


@interface CloudRunViewController : UIViewController

@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger month;
@property (strong, nonatomic) NSString *date;

@end
