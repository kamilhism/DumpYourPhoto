//
//  Photo.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/8/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic) uint64_t photoId;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *file_name;

@property (nonatomic) uint64_t views;

@property (nonatomic, strong) NSString *hash;

@property (nonatomic, strong) NSURL *smallUrl;
@property (nonatomic, strong) NSURL *mediumUrl;
@property (nonatomic, strong) NSURL *largeUrl;
@property (nonatomic, strong) NSURL *fullUrl;

@end
