//
//  Photo.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/13/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "Photo.h"
#import "Album.h"

#import "CoreDataHelper.h"

@implementation Photo

@dynamic fileName;
@dynamic photoHash;
@dynamic photoId;
@dynamic title;
@dynamic viewsCount;
@dynamic album;

- (void)setupWithObject:(id)photoData{
    
    if (!!photoData[@"title"]) { // error in site api - only url fields in json response of get all photos request
        self.title = photoData[@"title"];
        self.photoId = [NSNumber numberWithInteger:[photoData[@"id"] integerValue]];
        self.viewsCount = [NSNumber numberWithInteger:[photoData[@"views"] integerValue]];
    }
    
    NSURL *imageUrl = [NSURL URLWithString:photoData[@"url"][@"full"]];
    self.photoHash = [[imageUrl pathComponents] objectAtIndex:1];
    self.fileName = [[imageUrl pathComponents] objectAtIndex:2];
}

+ (void)clearPhotos{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    NSArray *photos = [[CoreDataHelper sharedInstance].moc executeFetchRequest:fetchRequest error:nil];
    for (NSManagedObject *photo in photos) {
        [[CoreDataHelper sharedInstance].moc deleteObject:photo];
    }
}

- (NSString *)imageUrl:(NSString *)imageSize {
    imageSize = [imageSize isEqualToString:@"full"] ? @"" : [imageSize stringByAppendingString:@"/"];
    return [NSString stringWithFormat:@"http://static.dyp.im/%@/%@%@", self.photoHash, imageSize, self.fileName];
}

@end
