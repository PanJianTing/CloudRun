//
//  EventWeatherViewController.m
//  CloudRun
//
//  Created by PAN on 2014/10/6.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "EventWeatherViewController.h"

@interface EventWeatherViewController ()

@property (weak, nonatomic) IBOutlet UILabel *LocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayWeather;
@property (weak, nonatomic) IBOutlet UILabel *todayC;
@property (weak, nonatomic) IBOutlet MKMapView *WeatherMapview;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *FutureDay;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *FutureWeather;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *FutureC;



@property (strong, nonatomic) NSArray *weatherReportArray;
@property (strong, nonatomic) NSString *weatherLocation;
@property (strong, nonatomic) MKPointAnnotation *point;


@property double x;
@property double y;

@end

@implementation EventWeatherViewController

#pragma mark - Init

- (void) viewDidAppear:(BOOL)animated
{
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	region.center.latitude = 25.0335;
	region.center.longitude = 121.5651;
	span.latitudeDelta = .01;
	span.longitudeDelta = .01;
	region.span = span;
	[self.WeatherMapview setRegion:region animated:YES];
	self.point.coordinate = self.WeatherMapview.centerCoordinate;
	[self.WeatherMapview addAnnotation:self.point];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.point = [[MKPointAnnotation alloc] init];
	self.weatherLocation = @"台北市";
	[self getWeatherData];
	// Do any additional setup after loading the view.
}

#pragma mark - Handle Soap Delegate

- (void) getWeatherData
{
	SoapObject *object = [[SoapObject alloc] init];
	object.url = @"http://www.mojotaiwan.com.tw/mojoitravelsvc/weathersvc.asmx";
	object.functionName = @"QueryWeatherInfo";
	object.delegate = self;
	NSDictionary *dictionary = @{
								 @"sAddr" : self.weatherLocation,
								 @"unit": @"C",
								 @"format": @"JSON"
								 };
	object.parameterDictionary = dictionary;
	[object connectionWithVersion:1.1];
}

- (void) soapObject:(SoapObject *)soapObject didfinishLoadDictionary:(NSDictionary *)dictionary
{
	
	NSString *jsonString = [[dictionary objectForKey:@"QueryWeatherInfoResult"] objectForKey:@"text"];
	if (jsonString != nil) {
		NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
		if (jsonDict != nil) {
			NSArray *weatherReport = [[[[[jsonDict objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"channel"] objectForKey:@"item"] objectForKey:@"forecast"];
			if (weatherReport.count != 0) {
				self.weatherReportArray = weatherReport;
				self.LocationLabel.text = self.weatherLocation;
				self.todayWeather.text = [[self.weatherReportArray objectAtIndex:0] objectForKey:@"text"];
				self.todayC = [[self.weatherReportArray objectAtIndex:0] objectForKey:@"high"];
				
				for (int i = 0; i < 4; i++) {
					UILabel *dayLabel = [self.FutureDay objectAtIndex:i];
					UIImageView *dayImage = [self.FutureWeather objectAtIndex:i];
					UILabel *dayC = [self.FutureC objectAtIndex:i];
					dayLabel.text = [[self.weatherReportArray objectAtIndex:(i+1)] objectForKey:@"day"];
					[dayImage setImage:[UIImage imageNamed:[[self.weatherReportArray objectAtIndex:(i+1)] objectForKey:@"code"]]];
					dayC.text = [NSString stringWithFormat:@"%@/%@", [[self.weatherReportArray objectAtIndex:(i+1)] objectForKey:@"high"], [[self.weatherReportArray objectAtIndex:(i+1)] objectForKey:@"low"]];
				}
			}
		}
	}
}

- (void) convertAddress
{
	CLGeocoder *geocoder = [[CLGeocoder alloc] init];
	CLLocation *location = [[CLLocation alloc] initWithLatitude:self.WeatherMapview.centerCoordinate.latitude
													  longitude:self.WeatherMapview.centerCoordinate.longitude];
	[geocoder reverseGeocodeLocation:location
				   completionHandler:^(NSArray *placemarks, NSError *error){
					   self.weatherLocation = [placemarks[0] locality];
	}];
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	// MapView End move
	self.x = mapView.centerCoordinate.latitude;
	self.y = mapView.centerCoordinate.longitude;
	self.point.coordinate = self.WeatherMapview.centerCoordinate;
	[self convertAddress];
	if (self.weatherLocation != nil) {
		[self getWeatherData];
	}
}

@end
