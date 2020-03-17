//
//  CompareRouteViewController.h
//  CloudRun
//
//  Created by PAN on 2014/8/22.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PlayerModel.h"
#import "AddPlayerCompareViewController.h"

@interface CompareRouteViewController : UIViewController <MKMapViewDelegate>

//@property (strong, nonatomic) NSArray *player;

@property (strong, nonatomic) PlayerModel *player;

@property (strong, nonatomic) NSArray *comparePlayer;
		   
@end