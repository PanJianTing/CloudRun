//
//  WebViewController.h
//  CloudRun
//
//  Created by PAN on 2014/8/1.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <SystemConfiguration/SCNetwork.h>
#import <SystemConfiguration/SCNetworkReachability.h>


@interface WebViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) NSURL *url;

@end
