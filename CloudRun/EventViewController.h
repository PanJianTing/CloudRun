//
//  EventViewController.h
//  CloudRun
//
//  Created by PAN on 2014/7/29.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHelper.h"
#import "SearchViewController.h"
#import "FilterViewController.h"
#import "MapviewViewController.h"

@interface EventViewController : UIViewController

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *month;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *kind;

- (void) updateTableviewEvent;
- (void) connectWithChildController;


@end
