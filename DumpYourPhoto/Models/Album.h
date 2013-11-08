//
//  Album.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/8/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (nonatomic) uint64_t albumId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *hash;
@property (nonatomic) bool isPublic;
@property (nonatomic) uint64_t photosCount;

@end
