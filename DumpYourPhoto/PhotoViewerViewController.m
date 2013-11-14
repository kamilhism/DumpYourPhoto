//
//  PhotoViewerViewController.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/14/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "PhotoViewerViewController.h"
#import "ImageCacher.h"
#import "Photo.h"
#import "DumpYourPhotoApiEngine.h"

@interface PhotoViewerViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *viewerImage;
@property (strong, nonatomic) IBOutlet UILabel *viewerImageTitle;

@end

@implementation PhotoViewerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *cachedImage = [[ImageCacher sharedCacher] getImageForURL:[self.selectedPhoto imageUrl:@"large"]];
    if (cachedImage) {
        [self viewerImage].image = cachedImage;
    } else {
        [DumpYourPhotoApiEngine getImageFor:[self selectedPhoto] withSize:@"large" callback:^(UIImage *image) {
            if (image) {
                [[ImageCacher sharedCacher] setImage:image forURL:[self.selectedPhoto imageUrl:@"large"]];
                [self viewerImage].image = image;
            }
        }];
    }
    
    if ([self.selectedPhoto title].length == 0)
        [DumpYourPhotoApiEngine getPhotoData:[self selectedPhoto] callback:^(Photo *photoWithData) {
            self.selectedPhoto = photoWithData;
            [self viewerImageTitle].text = [self.selectedPhoto title];
        }];
    else
        [self viewerImageTitle].text = [self.selectedPhoto title];
}

@end
