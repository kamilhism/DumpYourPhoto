//
//  ImageCacher.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/13/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCacher : NSObject

@property (nonatomic, strong) NSMutableDictionary *images;

+ (ImageCacher *)sharedCacher;

- (void)setImage:(UIImage *)img forURL:(NSString *)urlString;
- (UIImage *)getImageForURL:(NSString *)urlString;

@end
