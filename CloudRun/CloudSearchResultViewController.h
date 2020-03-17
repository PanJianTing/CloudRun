//
//  CloudSearchResultViewController.h
//  CloudRun
//
//  Created by PAN on 2014/10/1.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHelper.h"
#import "CloudPlayerVideoViewController.h"

@interface CloudSearchResultViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString* searchName;

@end
