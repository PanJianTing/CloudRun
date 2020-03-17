//
//  CloudPlayerVideoViewController.h
//  CloudRun
//
//  Created by PAN on 2014/10/1.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudioModel.h"
#import "CloudStudioViewController.h"
#import "CloudFeaturedViewController.h"

@interface CloudPlayerVideoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString *playerName;


@end
