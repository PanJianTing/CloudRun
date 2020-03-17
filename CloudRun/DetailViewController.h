//
//  DetailViewController.h
//  CloudRun
//
//  Created by PAN on 2014/7/24.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "EventModel.h"
#import "MapviewViewController.h"


//#import <GoogleMaps/GoogleMaps.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) EventModel *eventModel;
@property (weak, nonatomic) IBOutlet UIButton *pressButton;

- (void) setDetailViewFromEvent;

@end
