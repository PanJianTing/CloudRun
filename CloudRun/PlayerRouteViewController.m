//
//  PlayerRouteViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/14.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "PlayerRouteViewController.h"


#define PLAYERCONTANIER_X self.SearchPlayerContanier.frame.origin.x
#define PLAYERCONTANIER_Y self.SearchPlayerContanier.frame.origin.y
#define PLAYERCONTANIER_WIDTH self.SearchPlayerContanier.frame.size.width
#define PLAYERCONTANIER_HEIGHT self.SearchPlayerContanier.frame.size.height

@interface PlayerRouteViewController ()

@property (weak, nonatomic) IBOutlet UIView *SearchPlayerContanier;
@property (weak, nonatomic) IBOutlet MKMapView *RouteMapView;

//@property (strong, nonatomic) NSArray *allPlayer;
//@property (strong, nonatomic) JsonResponseModel *jsonModel;
//@property (strong, nonatomic) MKPolyline *routeLine;
//@property (strong, nonatomic) NSArray *pointArray;
//@property (strong, nonatomic) MKPointAnnotation *point;



@property (nonatomic) CGRect contanierOriginPos;
@property (nonatomic) BOOL isExpand;

@property (strong, nonatomic) KMLParser *kmlParser;
//@property (strong, nonatomic) DataHelper *dh;

@end

@implementation PlayerRouteViewController

- (void) viewDidAppear:(BOOL)animated
{
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	region.center.latitude = 24.262003;
	region.center.longitude = 120.528025;
	span.latitudeDelta = 0.5;
	span.longitudeDelta = 0.5;
	region.span = span;
	[self.RouteMapView setRegion:region animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.jsonModel = [[JsonResponseModel alloc] init];
	//self.point = [[MKPointAnnotation alloc] init];
	//self.allPlayer = [[self.jsonModel getJsonAllPlayer] valueForKey:@"list"];
	//self.contanierOriginPos = self.SearchPlayerContanier.frame;
	//self.dh = [[DataHelper alloc] init];
	
	self.isExpand = NO;
	self.tabBarController.title = @"中橫路跑";
	
	
	// KML Parser
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Path" ofType:@"kml"];
	NSURL *url = [NSURL fileURLWithPath:path];
	self.kmlParser = [[KMLParser alloc] initWithURL:url];
	[self.kmlParser parseKML];
	
	[self.RouteMapView addOverlays:[self.kmlParser overlays]];
	[self.RouteMapView setNeedsDisplay];
}

#pragma mark - Handle Mapview Annotation

//- (void) addAnnotation
//{
//	for (id player in self.allPlayer)
//	{
//		MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//		NSDictionary *playerDic;
//		NSString *lat, *lng;
//		
//		playerDic = [self.jsonModel getJsonOnePlayerWithID:[player valueForKey:@"userId"]];
//		lat = [[[playerDic valueForKey:@"list"] valueForKey:@"latitude"] objectAtIndex:0];
//		lng = [[[playerDic valueForKey:@"list"] valueForKey:@"longitude"] objectAtIndex:0];
//		
//		if ([lat isKindOfClass:[NSString class]] && [lng isKindOfClass:[NSString class]]) {
//			point.coordinate = CLLocationCoordinate2DMake(lat.doubleValue, lng.doubleValue);
//		}
//		
//		if ([[player valueForKey:@"name"] isKindOfClass:[NSString class]] && [[player valueForKey:@"userId"] isKindOfClass:[NSString class]]) {
//			point.title = [player valueForKey:@"name"];
//			point.subtitle = [player valueForKey:@"userId"];
//		}
//		
//		[self.RouteMapView addAnnotation:point];
//	}
//}

#pragma mark - Handle Expand Animation for Childviewcontroller

- (void) expandAnimation
{
}

#pragma mark - Handle Route Draw

- (MKPolyline *) drawRouteWithPoints : (NSArray *) points
{
	MKPolyline *route = [[MKPolyline alloc] init];
	CLLocationCoordinate2D *coords = malloc([points count] * sizeof(CLLocationCoordinate2D));
	for (int i = 0; i < [points count]; i++) {
		MKPointAnnotation *point = [points objectAtIndex:i];
		coords[i] = point.coordinate;
	}
	route = [MKPolyline polylineWithCoordinates:coords count:[points count]];
	
	free(coords);
	
	
	return route;
}

#pragma mark - Handle MKMap View Delegate

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	// MapView End move
}

- (void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	// MapView Start move
}

- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
	// MapView Pin Select
}

- (void) mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
	// Mapview Pin NOT Select
}


- (MKOverlayRenderer *) mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
	NSLog(@"Renderer mapview");
	MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
	renderer.strokeColor = [UIColor blueColor];
	renderer.lineWidth = 1.0;
	return renderer;
}

@end