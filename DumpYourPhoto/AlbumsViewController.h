//
//  AlbumsViewController.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/8/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumsViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *albumsTableView;

- (IBAction)exitTapped:(id)sender;

@end
