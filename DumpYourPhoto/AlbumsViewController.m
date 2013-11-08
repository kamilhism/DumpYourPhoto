//
//  AlbumsViewController.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/8/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "AlbumsViewController.h"
#import "DumpYourPhotoApiEngine.h"
#import "Album.h"

@interface AlbumsViewController ()


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *albumsArray;

@end

@implementation AlbumsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [DumpYourPhotoApiEngine getAlbums:^(NSArray *array) {
        self.albumsArray = [array mutableCopy];
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albumsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Album *album = self.albumsArray[indexPath.row];
    cell.textLabel.text = album.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%llu", album.photosCount];
    
    return cell;
}

- (IBAction)exitTapped:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"apiKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
