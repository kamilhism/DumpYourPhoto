//
//  AlbumsViewController.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/8/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "AlbumsViewController.h"

@interface AlbumsViewController ()

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
}

- (IBAction)exitTapped:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"apiKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
