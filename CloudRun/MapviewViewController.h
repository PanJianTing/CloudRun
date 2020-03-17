//
//  MapviewViewController.h
//  CloudRun
//
//  Created by PAN on 2014/7/29.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "DetailViewController.h"

@interface MapviewViewController : UIViewController <UIActionSheetDelegate>

@property (weak, nonatomic) EventModel* eventModel;

- (void) moveExpandView;


@end