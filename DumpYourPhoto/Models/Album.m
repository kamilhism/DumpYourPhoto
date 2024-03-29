//
//  Album.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/13/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "Album.h"
#import "Photo.h"
#import "CoreDataHelper.h"

@implementation Album

@dynamic albumHash;
@dynamic albumId;
@dynamic isPublic;
@dynamic name;
@dynamic photos;
@dynamic photosCount;

- (void)setupWithObject:(id)albumData{
    self.albumId = [NSNumber numberWithInteger:[albumData[@"id"] integerValue]];
    self.name = albumData[@"name"];
    self.albumHash = albumData[@"hash"];
    self.isPublic = [NSNumber numberWithInteger:[albumData[@"public"] integerValue]];
    self.photosCount = [NSNumber numberWithInteger:[albumData[@"photos"] integerValue]];
}

+ (NSArray *)findAllAlbums {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"albumId" ascending:YES];
    fetchRequest.sortDescriptors = @[sort];
    return [[CoreDataHelper sharedInstance].moc executeFetchRequest:fetchRequest error:nil];
}

+ (void)clearAlbums{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    NSArray *albums = [[CoreDataHelper sharedInstance].moc executeFetchRequest:fetchRequest error:nil];
    for (NSManagedObject *album in albums) {
        [[CoreDataHelper sharedInstance].moc deleteObject:album];
    }
}

+ (Album *)findAlbumWithId:(NSNumber *)albumId {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"albumId = %llu", albumId.longLongValue];
    fetchRequest.predicate = predicate;
    NSArray *array = [[CoreDataHelper sharedInstance].moc executeFetchRequest:fetchRequest error:nil];
    return [array firstObject];
}

@end
