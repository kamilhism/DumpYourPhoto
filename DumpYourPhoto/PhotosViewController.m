//
//  PhotosViewController.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/11/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "PhotosViewController.h"
#import "DumpYourPhotoApiEngine.h"
#import "Photo.h"
#import "ImageCacher.h"
#import "PhotoViewerViewController.h"
#import "CreatePhotoViewController.h"

@interface PhotosViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *photosArray;

@end

@implementation PhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = [self.album name];
    
    [DumpYourPhotoApiEngine getPhotosForAlbum:[self album] callback:^(NSArray *array) {
        [self setupPhotosFromDatabase];
    }];
}

-(void) viewDidAppear:(BOOL)animated {
    [self setupPhotosFromDatabase];
}

-(void)setupPhotosFromDatabase {
    self.photosArray = [[Photo findAllPhotosIn:self.album] mutableCopy];
    [self.collectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self photosArray] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Photo *photo = self.photosArray[indexPath.row];
    
    UIImageView *cellImageView = (UIImageView *)[cell.contentView viewWithTag:1];
    
    UIImage *cachedImage = [[ImageCacher sharedCacher] getImageForURL:[photo imageUrl:@"small"]];
    if (cachedImage) {
        cellImageView.image = cachedImage;
    } else {
        [DumpYourPhotoApiEngine getImageFor:photo withSize:@"small" callback:^(UIImage *image) {
            if (image) {
                [[ImageCacher sharedCacher] setImage:image forURL:[photo imageUrl:@"small"]];
                cellImageView.image = image;
                [cell setNeedsLayout];
            }
        }];
    }
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"viewPhoto"]) {
        UICollectionViewCell *cell = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        int rowNumber = indexPath.row;
        Photo *photo = self.photosArray[rowNumber];
        PhotoViewerViewController *controller = segue.destinationViewController;
        controller.selectedPhoto = photo;
    }
    
    if ([[segue identifier] isEqualToString:@"createPhoto"]) {
        CreatePhotoViewController *controller = segue.destinationViewController;
        controller.album = self.album;
    }
}

@end
