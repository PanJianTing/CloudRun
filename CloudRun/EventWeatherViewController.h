//
//  EventWeatherViewController.h
//  CloudRun
//
//  Created by PAN on 2014/10/6.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SoapObject.h"


@interface EventWeatherViewController : UIViewController <MKMapViewDelegate, SoapObjectDelegate, CLLocationManagerDelegate>

@end
