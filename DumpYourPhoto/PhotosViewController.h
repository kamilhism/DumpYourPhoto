//
//  PhotosViewController.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/11/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface PhotosViewController : UICollectionViewController

@property (nonatomic, strong) Album *album;

@end
