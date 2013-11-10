//
//  Album.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/9/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Album : NSManagedObject

@property (nonatomic, retain) NSNumber * albumId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * albumHash;
@property (nonatomic, retain) NSNumber * isPublic;

- (void)setupWithObject:(id)albumData;

+ (NSArray *)findAllAlbums;
+ (Album *)findAlbumWithId:(NSNumber *)albumId;
+ (void)clearAlbums;

@end
