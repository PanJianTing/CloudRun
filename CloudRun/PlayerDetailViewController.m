//
//  PlayerDetailViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/15.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "PlayerDetailViewController.h"

#define EXPAND_X self.ExpandContainer.frame.origin.x
#define EXPAND_Y self.ExpandContainer.frame.origin.y
#define EXPAND_WIDTH self.ExpandContainer.frame.size.width
#define EXPAND_HEIGHT self.ExpandContainer.frame.size.height


@interface PlayerDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *ExpandContainer;
@property (weak, nonatomic) IBOutlet MKMapView *PlayerLocationMapview;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (strong, nonatomic) Location *lastLoc;

@property (nonatomic) BOOL isExpand;
@property (nonatomic) CGRect expandPos;
@property (nonatomic) CGRect originPos;


//@property (strong, nonatomic) JsonResponseModel *jsonModel;
//@property (strong, nonatomic) NSDictionary *playerDetailDic;
@end

@implementation PlayerDetailViewController

- (void) viewDidAppear:(BOOL)animated
{
	[self addAnnotation];
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	NSString *lat,*lng;
	lat = self.lastLoc.lat;
	lng = self.lastLoc.lng;
	//lat = [[[self.playerDetailDic valueForKey:@"list"] valueForKey:@"latitude"] objectAtIndex:0];
	//lng = [[[self.playerDetailDic valueForKey:@"list"] valueForKey:@"longitude"] objectAtIndex:0];
	region.center.latitude = lat.doubleValue;
	region.center.longitude = lng.doubleValue;
	span.latitudeDelta = .01;
	span.longitudeDelta = .01;
	region.span = span;
	[self.PlayerLocationMapview setRegion:region animated:YES];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	//self.navigationItem.title = [self.playerDetaile valueForKey:@"name"];
	//self.jsonModel = [[JsonResponseModel alloc] init];
	//self.playerDetailDic = [self.jsonModel getJsonOnePlayerWithID:[self.playerDetaile valueForKey:@"userId"]];
	
	self.navigationItem.title = self.player.name;
	self.lastLoc = [self.player.tracker lastObject];
	self.originPos = self.ExpandContainer.frame;
	self.ExpandContainer.hidden = YES;
	self.isExpand = NO;
}

#pragma mark - Handle Expand show

- (void) setExpand:(BOOL)isExpand
{
	self.isExpand = isExpand;
}

#pragma mark - Handle Annotation 

- (void) addAnnotation
{
	MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
	NSString *lat, *lng;
		
	lat = self.lastLoc.lat;
	lng = self.lastLoc.lng;
		
	point.coordinate = CLLocationCoordinate2DMake(lat.doubleValue, lng.doubleValue);
	point.title = self.player.name;
	point.subtitle = [NSString stringWithFormat:@"No. %@", self.player.number];
	
	self.locationLabel.text = [NSString stringWithFormat:@"%@        %@", lat, lng];
	[self.PlayerLocationMapview addAnnotation:point];
}


#pragma mark - Handle Expand Contanier Event

- (IBAction)pressExpandBarButton:(UIBarButtonItem *)sender
{
	if ( self.isExpand ) {
		[UIView animateWithDuration:0.2
						 animations:^(void){
							 self.ExpandContainer.frame = self.originPos;
						 }
						 completion:^(BOOL finished){
							 self.isExpand = NO;
							 self.ExpandContainer.hidden = YES;
						 }];
	} else {
		[UIView animateWithDuration:0.2
						 animations:^(void){
							 self.ExpandContainer.hidden = NO;
							 self.ExpandContainer.frame = CGRectMake(0, EXPAND_HEIGHT-1, EXPAND_WIDTH, EXPAND_HEIGHT);
						 }
						 completion:^(BOOL finished){
							 self.isExpand = YES;
						 }];
	}
}
@end