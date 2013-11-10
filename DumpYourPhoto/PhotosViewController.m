//
//  PhotosViewController.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/11/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "PhotosViewController.h"

@interface PhotosViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel *photoTitle = (UILabel *)[cell.contentView viewWithTag:10];
    [photoTitle setText:@"Test photo title"];
    
    return cell;
}

@end
