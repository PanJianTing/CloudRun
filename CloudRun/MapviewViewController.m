//
//  MapviewViewController.m
//  CloudRun
//
//  Created by PAN on 2014/7/29.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "MapviewViewController.h"
#define DETAILVIEW_WIDTH self.DetailViewContainer.frame.size.width
#define DETAILVIEW_HEIGHT self.DetailViewContainer.frame.size.height


@interface MapviewViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *LocationMapview;
@property (weak, nonatomic) IBOutlet UIView *DetailViewContainer;

@property (nonatomic) BOOL isShow;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@property (nonatomic) CGRect originPos;

@end

@implementation MapviewViewController

- (void) viewDidAppear:(BOOL)animated
{
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	region.center.latitude = self.latitude;
	region.center.longitude = self.longitude;
	span.latitudeDelta = .01;
	span.longitudeDelta = .01;
	region.span = span;
	[self.LocationMapview setRegion:region animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.latitude = 25.032054;
	self.longitude = 121.529266;
	self.navigationItem.title = self.eventModel.event;
	self.originPos = self.DetailViewContainer.frame;
	[self getModel];
	[self searchCoordinatesForAddress:[NSString stringWithFormat:@"%@%@", self.eventModel.eventCity, self.eventModel.location]];
	[self pin];
}

- (void) pin
{
	MKPointAnnotation *pin;
	
	pin = [[MKPointAnnotation alloc] init];
	pin.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
	pin.title = self.eventModel.event;
	pin.subtitle = self.eventModel.location;
	[self.LocationMapview addAnnotation:pin];
}

- (void) getModel
{
	NSArray *vcs = self.childViewControllers;
	for (id vc in vcs) {
		if ([vc isKindOfClass:[DetailViewController class]]) {
			DetailViewController *dvc = vc;
			dvc.eventModel = self.eventModel;
			[dvc setDetailViewFromEvent];
		}
	}
}

#pragma mark - Handle Detail Expand

- (void) moveExpandView
{
	if (self.isShow) {
		[UIView animateWithDuration:0.5
						 animations:^(void){
							 self.DetailViewContainer.frame = CGRectMake(0, self.view.frame.size.height - 53, DETAILVIEW_WIDTH, DETAILVIEW_HEIGHT);
						 }
						 completion:^(BOOL finished){
							 self.isShow = NO;
							 self.LocationMapview.alpha = 1;
							 self.LocationMapview.multipleTouchEnabled = YES;
							 self.LocationMapview.scrollEnabled = YES;
						 }];
	}else{
		[UIView animateWithDuration:0.3
						 animations:^(void){
							 self.DetailViewContainer.frame = CGRectMake(0, self.view.frame.size.height - DETAILVIEW_HEIGHT, DETAILVIEW_WIDTH, DETAILVIEW_HEIGHT);
						 }
						 completion:^(BOOL finished){
							 self.LocationMapview.alpha = 0.5;
							 self.isShow = YES;
							 self.LocationMapview.multipleTouchEnabled = NO;
							 self.LocationMapview.scrollEnabled = NO;
						 }];
	}
}

#pragma mark - Search Adderss use Google Geocode

- (void) searchCoordinatesForAddress:(NSString *)inAddress
{
	NSString *lookUpString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true", inAddress];
	lookUpString = [lookUpString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	lookUpString = [lookUpString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
	
	NSData *jsonResponse = [NSData dataWithContentsOfURL:[NSURL URLWithString:lookUpString]];

	if (jsonResponse) {
		NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonResponse options:kNilOptions error:nil];
		NSArray *locationArray = [[[jsonDict valueForKey:@"results"] valueForKey:@"geometry"] valueForKey:@"location"];
		if ([locationArray count] != 0) {
			locationArray = [locationArray objectAtIndex:0];
			
			NSString *latitudeString = [locationArray valueForKey:@"lat"];
			NSString *longitudeString = [locationArray valueForKey:@"lng"];

			self.latitude = latitudeString.doubleValue;
			self.longitude = longitudeString.doubleValue;
			//self.location = inAddress;
		} else {
			[self showWarningAlert];
		}
	} else {
		[self showWarningAlert];
	}
}

#pragma mark - Handle Gesture Event

- (IBAction)tapGestureEvent:(UITapGestureRecognizer *)sender {
	if (self.isShow) {
		[self moveExpandView];
	}
}

#pragma mark - Handle Press Button Event

- (IBAction)pressPlusButton:(UIBarButtonItem *)sender {
	UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil
													delegate:self
										   cancelButtonTitle:@"Cancel"
									  destructiveButtonTitle:nil
										   otherButtonTitles:@"Add Favorite", @"Go to Registration", nil];
	[as showInView:self.view];
}

#pragma mark - Handle Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
		case 0:
#warning Add Favorite didn't implementation
			break;
		
		case 1:
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.eventModel.url]];
			break;
		
		default:
			break;
	}
}

#pragma mark - Warning Alert View

- (void) showWarningAlert
{
	[[[UIAlertView alloc] initWithTitle:@"Warning"
								message:@"The Location not available"
							   delegate:nil
					  cancelButtonTitle:@"OK"
					  otherButtonTitles:nil] show];
}

@end
