//
//  EventAlbumsTableViewController.m
//  CloudRun
//
//  Created by PAN on 2014/8/1.
//  Copyright (c) 2014年 PAN. All rights reserved.
//

#import "EventAlbumsTableViewController.h"

@interface EventAlbumsTableViewController ()


@property (strong, nonatomic) DataHelper *dh;

@end

@implementation EventAlbumsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.dh = [[DataHelper alloc] init];
	//self.eventAlbumsModel.alumbs = [self.dh FetchAlbumsWithId:self.eventAlbumsModel.eventAlbumsId];
	//[NSString stringWithFormat:@"select * from running_albums where ID_F like '%@%@%@'", @"%", albumsId, @"%"];
	
	self.eventAlbumsModel.alumbs = [self.dh sqlSelectModelCommand:@"Select *"
													   fromTable:@"running_albums"
														   where:[NSString stringWithFormat:@"where ID_F like '%@%@%@'", @"%", self.eventAlbumsModel.eventAlbumsId, @"%"]];
	
	self.navigationItem.title = self.eventAlbumsModel.event;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.eventAlbumsModel.alumbs count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"AlbumsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	
	
	AlbumsModel *eventAlbums = [self.eventAlbumsModel.alumbs objectAtIndex:indexPath.row];
	
	cell.textLabel.text = eventAlbums.name;
	cell.detailTextLabel.text = eventAlbums.photoNumbers;
	cell.accessoryType = UITableViewCellStyleDefault;
	return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AlbumsSegue"]) {
		if ([segue.destinationViewController isKindOfClass:[WebViewController class]]) {
			WebViewController *wvc = segue.destinationViewController;
			NSIndexPath *path = [self.tableView indexPathForSelectedRow];
			AlbumsModel *albums;
			albums = [self.eventAlbumsModel.alumbs objectAtIndex:path.row];
			wvc.url = [NSURL URLWithString:albums.url];
		}
	}
}


@end
