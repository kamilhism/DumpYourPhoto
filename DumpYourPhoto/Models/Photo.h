//
//  Photo.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/9/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) NSNumber * photoId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSNumber * viewsCount;
@property (nonatomic, retain) NSString * photoHash;

@end
