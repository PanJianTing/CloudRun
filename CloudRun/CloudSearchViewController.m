//
//  CloudSearchViewController.m
//  CloudRun
//
//  Created by PAN on 2014/9/30.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "CloudSearchViewController.h"

@interface CloudSearchViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *NameSearchBar;

@end

@implementation CloudSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.NameSearchBar.delegate = self;
//	[self.NameSearchBar becomeFirstResponder];
//	 Do any additional setup after loading the view.
}

- (IBAction)pressSearchButton:(UIButton *)sender {
	[self.NameSearchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[self.NameSearchBar resignFirstResponder];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"CloudResultSegue"]) {
		if ( [segue.destinationViewController isKindOfClass:[CloudSearchResultViewController class]] ) {
			CloudSearchResultViewController *csrvc = segue.destinationViewController;
			csrvc.searchName = self.NameSearchBar.text;
		}
	}
}


@end
