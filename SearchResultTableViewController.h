//
//  SearchResultTableViewController.h
//  CloudRun
//
//  Created by PAN on 2014/7/30.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CloudRun/DataHelper.h"
#import "CloudRun/MapviewViewController.h"

@interface SearchResultTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSString *searchText;
@property (strong, nonatomic) NSArray *resultArray;

@end
