//
//  Album.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/13/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * albumHash;
@property (nonatomic, retain) NSNumber * albumId;
@property (nonatomic, retain) NSNumber * isPublic;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *photos;
@property (nonatomic, retain) NSNumber * photosCount;

- (void)setupWithObject:(id)albumData;

+ (NSArray *)findAllAlbums;
+ (Album *)findAlbumWithId:(NSNumber *)albumId;
+ (void)clearAlbums;

@end

@interface Album (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end
