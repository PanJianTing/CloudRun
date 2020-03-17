//
//  AroundMapviewViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/22.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "AroundMapviewViewController.h"

@interface AroundMapviewViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *AroundMapview;
@property (weak, nonatomic) IBOutlet UIButton *FilterButton;

@property (strong, nonatomic) DataHelper *dh;
@property (strong, nonatomic) NSArray *aroundArray;
@property (strong, nonatomic) NSMutableArray *pinArray;
@property (nonatomic) NSUInteger index;

@end

@implementation AroundMapviewViewController

- (void) viewDidAppear:(BOOL)animated
{
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	
	region.center.latitude = @"35.681382".doubleValue;
	region.center.longitude = @"139.766084".doubleValue;
	span.latitudeDelta = .8;
	span.longitudeDelta = .8;
	region.span = span;
	
	[self.AroundMapview setRegion:region animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.dh = [[DataHelper alloc] init];
	self.pinArray = [[NSMutableArray alloc] init];
	self.index = 0;
	self.aroundArray = [self.dh sqlSelectModelCommand:@"select POI_ID_F, NAME_F,LAT_F,LNG_F"
											fromTable:@"shopping_jp"
												where:@"limit 30"];
	[self addPin];
}

#pragma mark - Handle Filter Button Press

- (IBAction)pressFilterButton:(UIButton *)sender {
	
	self.index++;
	switch (self.index % 4) {
		case 0:
			[sender setTitle:@"All" forState:UIControlStateNormal];
			self.aroundArray = [self.dh sqlSelectModelCommand:@"select POI_ID_F, NAME_F,LAT_F,LNG_F"
													fromTable:@"shopping_jp"
														where:@"limit 30"];
			break;
			
		case 1:
			[sender setTitle:@"玩" forState:UIControlStateNormal];
			self.aroundArray = [self.dh sqlSelectModelCommand:@"select POI_ID_F, NAME_F,LAT_F,LNG_F"
													fromTable:@"hotspot_jp"
														where:@"limit 30"];
			break;
			
		case 2:
			[sender setTitle:@"吃" forState:UIControlStateNormal];
			self.aroundArray = [self.dh sqlSelectModelCommand:@"select POI_ID_F, NAME_F,LAT_F,LNG_F"
													fromTable:@"food_jp"
														where:@"limit 30"];
			break;
			
		case 3:
			[sender setTitle:@"住" forState:UIControlStateNormal];
			self.aroundArray = [self.dh sqlSelectModelCommand:@"select POI_ID_F, NAME_F,LAT_F,LNG_F"
													fromTable:@"hotel_jp"
														where:@"limit 30"];
			break;
			
		default:
			break;
	}
	[self addPin];
}

- (void) addPin
{
	[self.AroundMapview removeAnnotations:self.pinArray];
	[self.pinArray removeAllObjects];
	for (AroundModel *aroundModel in self.aroundArray) {
		MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
		pin.title = aroundModel.name;
		
		pin.coordinate = CLLocationCoordinate2DMake(aroundModel.lat.doubleValue, aroundModel.lng.doubleValue);
		[self.AroundMapview addAnnotation:pin];
		[self.pinArray addObject:pin];
	}
}

@end
