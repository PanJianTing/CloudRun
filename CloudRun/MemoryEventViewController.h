//
//  MemoryEventViewController.h
//  CloudRun
//
//  Created by PAN on 2014/8/4.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHelper.h"
#import "SearchViewController.h"
#import "MemoryEventTableViewCell.h"
#import "EventAlbumsTableViewController.h"

@interface MemoryEventViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property NSDate *selectDate;
- (void) selectDateViewReturnHandle;



@end
