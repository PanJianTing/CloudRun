//
//  ResultsAlbumsTableViewController.h
//  CloudRun
//
//  Created by PAN on 2014/8/4.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHelper.h"
#import "MemoryEventTableViewCell.h"
#import "EventAlbumsTableViewController.h"


@interface ResultsAlbumsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSString *searchText;
@property (strong, nonatomic) NSMutableArray *albumsArray;
@property (strong, nonatomic) NSArray *resultArray;

@end
