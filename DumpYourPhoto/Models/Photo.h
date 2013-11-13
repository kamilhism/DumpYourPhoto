//
//  Photo.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/13/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSString * photoHash;
@property (nonatomic, retain) NSNumber * photoId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * viewsCount;
@property (nonatomic, retain) Album *album;

- (void)setupWithObject:(id)photoData;
- (NSString *)imageUrl:(NSString *)imageSize;

+ (void)clearPhotos;

@end
