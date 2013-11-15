//
//  CreatePhotoViewController.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/15/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface CreatePhotoViewController : UIViewController

@property (nonatomic, strong) Album *album;

- (IBAction)doneTapped:(id)sender;
- (IBAction)addImageTapped:(id)sender;

@end
