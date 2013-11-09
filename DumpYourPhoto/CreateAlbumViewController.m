//
//  CreateAlbumViewController.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/9/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "CreateAlbumViewController.h"
#import "DumpYourPhotoApiEngine.h"

@interface CreateAlbumViewController ()

@property (strong, nonatomic) IBOutlet UITextField *albumNameField;
@property (strong, nonatomic) IBOutlet UISwitch *isPublicSwitch;

@end

@implementation CreateAlbumViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)doneTapped:(id)sender {
    NSDictionary *albumData = @{
        @"name": self.albumNameField.text,
        @"public": self.isPublicSwitch.on ? @"1" : @"0"
    };
    [DumpYourPhotoApiEngine createAlbum:albumData callback:^(bool success, NSString *error) {
        if (success) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Can not create album. Error: '%@' has been occured", error] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

@end
