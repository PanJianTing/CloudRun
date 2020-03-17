//
//  SearchViewController.m
//  CloudRun
//
//  Created by PAN on 2014/7/30.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *SearchBar;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) DataHelper *dh;
@property (strong, nonatomic) NSDate *selectDate;
@property (strong, nonatomic) NSString *date;

@end

@implementation SearchViewController


- (void)viewDidLoad
{
	[super viewDidLoad];
	self.dh = [[DataHelper alloc] init];
	self.selectDate = [[NSDate alloc] init];
	self.year = [[NSString alloc] init];
	self.month = [[NSString alloc] init];
	
	[self handleDate];
	self.dateArray = [self.dh FetchDate:self.month searchYear:self.year];
}


#pragma mark - Handle Update UI

- (void) handleDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	
	[formatter setDateFormat:@"y"];
	self.year = [formatter stringFromDate:self.selectDate];
	
	[formatter setDateFormat:@"MM"];
	self.month = [formatter stringFromDate:self.selectDate];
}

- (void) updateDate
{
	self.dateArray = [self.dh FetchDate:self.month searchYear:self.year];
}


#pragma mark - Handle SearchBar Delegate

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
}

#pragma mark - Handle SearchBar Keyboard

- (void) keyboardDown
{
	[self.SearchBar resignFirstResponder];
}

#pragma mark - Handle Button Press Event

- (IBAction)pressSearchButton:(UIButton *)sender {
	
	[self.SearchBar resignFirstResponder];
	//self.searchText = self.SearchBar.text;
}

#pragma mark - Handle Collectionview Delegate

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"DateCollectCell";
	
	CollectionLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
	
	if (cell == nil)
	{
		cell = [[CollectionLabelCell alloc] init];
	}
	
	cell.label.text = [self.dateArray objectAtIndex:indexPath.row];
	cell.layer.cornerRadius = 10;
	cell.layer.masksToBounds = YES;
	return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.dateArray count];
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	self.date = [self.dateArray objectAtIndex:indexPath.row];
	if ([self.parentViewController isKindOfClass:[EventViewController class]]) {
		EventViewController *evc = (EventViewController *)self.parentViewController;
		evc.date = self.date;
		evc.year = self.year;
		[evc updateTableviewEvent];
	}
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

#pragma mark - Handle Segue Event

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"SearchSegue"]) {
		if ([segue.destinationViewController isKindOfClass:[SearchResultTableViewController class]]) {
			SearchResultTableViewController *srtvc = (SearchResultTableViewController *)segue.destinationViewController;
			srtvc.searchText = self.SearchBar.text;
		}
		else if ([segue.destinationViewController isKindOfClass:[ResultsAlbumsTableViewController class]]) {
			ResultsAlbumsTableViewController *ratvc = (ResultsAlbumsTableViewController *)segue.destinationViewController;
			ratvc.searchText = self.SearchBar.text;
		}
	}
}

@end