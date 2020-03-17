//
//  CompareRouteViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/22.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "CompareRouteViewController.h"

@interface CompareRouteViewController ()

@property (strong, nonatomic) IBOutletCollection(UIProgressView) NSArray *DistanceProgresses;


@property (weak, nonatomic) IBOutlet MKMapView *RouteMapview;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;

@property (strong, nonatomic) DataHelper *dh;

@property (strong, nonatomic) NSMutableArray *selfPointArray;
@property (strong, nonatomic) NSMutableArray *compareOnePoints;
@property (strong, nonatomic) NSMutableArray *compareTwoPoints;
@property (strong, nonatomic) NSMutableArray *compareThreePoints;
@property (strong, nonatomic) NSMutableArray *compareFourPoints;

@property (strong, nonatomic) MKPointAnnotation *selfPin;
@property (strong, nonatomic) MKPointAnnotation *onePin;
@property (strong, nonatomic) MKPointAnnotation *twoPin;
@property (strong, nonatomic) MKPointAnnotation *threePin;
@property (strong, nonatomic) MKPointAnnotation *fourPin;

@property (strong, nonatomic) MKPolyline *selfRoutePolyline;
@property (strong, nonatomic) MKPolyline *compareOnePolyLine;
@property (strong, nonatomic) MKPolyline *compareTwoPolyLine;
@property (strong, nonatomic) MKPolyline *compareThreePolyLine;
@property (strong, nonatomic) MKPolyline *compareFourPolyLine;

@end

@implementation CompareRouteViewController

- (void) viewDidAppear:(BOOL)animated
{
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	Location *loc = self.player.tracker.firstObject;
	
	region.center.latitude = loc.lat.doubleValue;
	region.center.longitude = loc.lng.doubleValue;
	span.latitudeDelta = .05;
	span.longitudeDelta = .05;
	region.span = span;
	
	self.selfRoutePolyline = [self drawRouteWithPoints:self.selfPointArray];
	[self.RouteMapview addOverlay:self.selfRoutePolyline];
	[self.RouteMapview setRegion:region animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.dh = [[DataHelper alloc] init];
	self.selfPin = [[MKPointAnnotation alloc] init];
	
	self.navigationItem.title = self.player.name;
	self.selfPointArray = self.player.tracker;
	[self.RouteMapview setNeedsDisplay];
	[self addPinWithIndex:0  StoreArray:self.selfPointArray ShowPin:self.selfPin];
}


#pragma mark - Handle Distance

- (NSInteger) distanceWithPlayerPoint:(NSMutableArray *)points Index:(NSInteger)index
{
	NSInteger distance = 0;
	
	if ([points count] > index) {
		for ( int i = 0; i < index; i++ ) {
			Location *point = [points objectAtIndex:i];
			distance += point.distance.intValue;
		}
		return distance;
	} else {
		return 81000;
	}
}

- (void) setProgressWithIndex:(NSInteger)index Distance:(NSInteger) distance
{
	UIProgressView *progressView = [self.DistanceProgresses objectAtIndex:index];
	
	progressView.progress = distance / 81000.00;
}

#pragma mark - Handle Point

- (void) addPinWithIndex:(NSUInteger) index StoreArray:(NSMutableArray *)array ShowPin:(MKPointAnnotation *)pin
{
	Location *location = [array objectAtIndex:index];
	pin.coordinate = CLLocationCoordinate2DMake(location.lat.doubleValue, location.lng.doubleValue);
	pin.title = [NSString stringWithFormat:@"%@", location.Id];
	pin.subtitle = [NSString stringWithFormat:@"%@", location.speed];
	[self.RouteMapview addAnnotation:pin];
}

#pragma mark - Handle Mapview & Slider Init

- (void) removeMapviewRouteAndPin
{
	self.timeSlider.value = 0;
	[self addPinWithIndex:0 StoreArray:self.selfPointArray ShowPin:self.selfPin];
	
	[self.RouteMapview removeOverlay:self.compareOnePolyLine];
	[self.RouteMapview removeOverlay:self.compareTwoPolyLine];
	[self.RouteMapview removeOverlay:self.compareThreePolyLine];
	[self.RouteMapview removeOverlay:self.compareFourPolyLine];
	
	[self.RouteMapview removeAnnotation:self.onePin];
	[self.RouteMapview removeAnnotation:self.twoPin];
	[self.RouteMapview removeAnnotation:self.threePin];
	[self.RouteMapview removeAnnotation:self.fourPin];
}

#pragma mark - Handle Map Delegate

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	MKPinAnnotationView *annotaionView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
	if ( annotation == self.selfPin ) {
		annotaionView.pinColor = MKPinAnnotationColorRed;
	}
	else if ( annotation == self.onePin ) {
		annotaionView.pinColor = MKPinAnnotationColorGreen;
	}
	else if ( annotation == self.twoPin ){
		annotaionView.pinColor = MKPinAnnotationColorPurple;
	}
	else if ( annotation == self.threePin ){
		annotaionView.image = [UIImage imageNamed:@"GrayPin"];
	}
	else if ( annotation == self.fourPin ){
		annotaionView.image = [UIImage imageNamed:@"OrangePin"];
	}
	return annotaionView;
}

#pragma mark - Handle Draw Map Route

- (MKPolyline *) drawRouteWithPoints : (NSArray *) points
{
	MKPolyline *route;
	CLLocationCoordinate2D *coords = malloc([points count] * sizeof(CLLocationCoordinate2D));
	for (int i = 0; i < [points count]; i++) {
		Location *location = [points objectAtIndex:i];
		CLLocationCoordinate2D point = CLLocationCoordinate2DMake(location.lat.doubleValue, location.lng.doubleValue);
		coords[i] = point;
	}
	route = [MKPolyline polylineWithCoordinates:coords count:[points count]];
	free(coords);
	return route;
}

- (MKOverlayRenderer *) mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
	MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
	renderer.lineWidth = 1.0;
	
	if ( overlay == self.selfRoutePolyline ) {
		renderer.strokeColor = [UIColor redColor];
	}
	else if ( overlay == self.compareOnePolyLine ){
		renderer.strokeColor = [UIColor greenColor];
	}
	else if ( overlay == self.compareTwoPolyLine ){
		renderer.strokeColor = [UIColor purpleColor];
	}
	else if ( overlay == self.compareThreePolyLine ){
		renderer.strokeColor = [UIColor grayColor];
	}
	else if ( overlay == self.compareFourPolyLine ){
		renderer.strokeColor = [UIColor orangeColor];
	}
	
	return renderer;
}

#pragma mark - Handle Slider Event

- (IBAction)pressSlider:(UISlider *)sender
{
	NSInteger index = sender.value * 66;
	NSInteger distance;
	
	distance = [self distanceWithPlayerPoint:self.selfPointArray Index:index];
	[self setProgressWithIndex:0 Distance:distance];
	
	for (int i = 1; i <= [self.comparePlayer count]; i++) {
		
		if ( i == 1 )
			distance = [self distanceWithPlayerPoint:self.compareOnePoints Index:index];
		else if ( i == 2 )
			distance = [self distanceWithPlayerPoint:self.compareTwoPoints Index:index];
		else if ( i == 3 )
			distance = [self distanceWithPlayerPoint:self.compareThreePoints Index:index];
		else if ( i == 4 )
			distance = [self distanceWithPlayerPoint:self.compareFourPoints Index:index];
		
		[self setProgressWithIndex:i Distance:distance];
	}
	
	// Have Map
	[self addPinWithIndex:sender.value * ([self.selfPointArray count] - 1) StoreArray:self.selfPointArray ShowPin:self.selfPin];
	
	switch ([self.comparePlayer count]) {
		case 1:
			[self addPinWithIndex:sender.value * ([self.compareOnePoints count] - 1) StoreArray:self.compareOnePoints ShowPin:self.onePin];
			break;
			
		case 2:
			[self addPinWithIndex:sender.value * ([self.compareOnePoints count] - 1) StoreArray:self.compareOnePoints ShowPin:self.onePin];
			[self addPinWithIndex:sender.value * ([self.compareTwoPoints count] - 1) StoreArray:self.compareTwoPoints ShowPin:self.twoPin];
			break;
			
		case 3:
			[self addPinWithIndex:sender.value * ([self.compareOnePoints count] - 1) StoreArray:self.compareOnePoints ShowPin:self.onePin];
			[self addPinWithIndex:sender.value * ([self.compareTwoPoints count] - 1) StoreArray:self.compareTwoPoints ShowPin:self.twoPin];
			[self addPinWithIndex:sender.value * ([self.compareThreePoints count] - 1) StoreArray:self.compareThreePoints ShowPin:self.threePin];
			break;
			
		case 4:
			[self addPinWithIndex:sender.value * ([self.compareOnePoints count] - 1) StoreArray:self.compareOnePoints ShowPin:self.onePin];
			[self addPinWithIndex:sender.value * ([self.compareTwoPoints count] - 1) StoreArray:self.compareTwoPoints ShowPin:self.twoPin];
			[self addPinWithIndex:sender.value * ([self.compareThreePoints count] - 1) StoreArray:self.compareThreePoints ShowPin:self.threePin];
			[self addPinWithIndex:sender.value * ([self.compareFourPoints count] - 1) StoreArray:self.compareFourPoints ShowPin:self.fourPin];
			break;
			
		default:
			break;
	}
	self.RouteMapview.centerCoordinate = self.selfPin.coordinate;
}

#pragma mark - Handle Unwind From Add Player

- (IBAction)addPlayerUnwind:(UIStoryboardSegue *)segue
{
	[self removeMapviewRouteAndPin];
	if ( [segue.sourceViewController isKindOfClass:[AddPlayerCompareViewController class]] ) {
		AddPlayerCompareViewController *apcvc = segue.sourceViewController;
		self.comparePlayer = [apcvc.PlayerTableview indexPathsForSelectedRows];
		[self addComparePlayerPoint];
	}
}

#pragma mark - Handle After Unwind

- (void) addComparePlayerPoint
{
	for (int i = 0; i < [self.comparePlayer count]; i++) {
		NSIndexPath *path = [self.comparePlayer objectAtIndex:i];
		NSMutableArray *points = [self.dh sqlSelectModelCommand:@"Select *"
													  fromTable:@"runner_tracker"
														  where:[NSString stringWithFormat:@"Where userId = '%ld'", path.row + 1]];
		switch (i) {
			case 0:
				self.onePin = [[MKPointAnnotation alloc] init];
				self.compareOnePoints = points;
				[self addPinWithIndex:0 StoreArray:self.compareOnePoints ShowPin:self.onePin];
				self.compareOnePolyLine = [self drawRouteWithPoints:self.compareOnePoints];
				[self.RouteMapview addOverlay:self.compareOnePolyLine];
				break;
				
			case 1:
				self.twoPin = [[MKPointAnnotation alloc] init];
				self.compareTwoPoints = points;
				[self addPinWithIndex:0 StoreArray:self.compareTwoPoints ShowPin:self.twoPin];
				self.compareTwoPolyLine = [self drawRouteWithPoints:self.compareTwoPoints];
				[self.RouteMapview addOverlay:self.compareTwoPolyLine];
				break;
				
			case 2:
				self.threePin = [[MKPointAnnotation alloc] init];
				self.compareThreePoints = points;
				[self addPinWithIndex:0 StoreArray:self.compareThreePoints ShowPin:self.threePin];
				self.compareThreePolyLine = [self drawRouteWithPoints:self.compareThreePoints];
				[self.RouteMapview addOverlay:self.compareThreePolyLine];
				break;
				
			case 3:
				self.fourPin = [[MKPointAnnotation alloc] init];
				self.compareFourPoints = points;
				[self addPinWithIndex:0 StoreArray:self.compareFourPoints ShowPin:self.fourPin];
				self.compareFourPolyLine = [self drawRouteWithPoints:self.compareFourPoints];
				[self.RouteMapview addOverlay:self.compareFourPolyLine];
				break;
				
			default:
				break;
		}
	}
}

#pragma mark - Hanlde Navigation

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.destinationViewController isKindOfClass:[AddPlayerCompareViewController class]]) {
		if ([segue.identifier isEqualToString:@"AddPlayerSegue"]) {
			AddPlayerCompareViewController *apcvc = segue.destinationViewController;
			apcvc.playerId = self.player.number.intValue;
		}
	}
}






@end