//
//  ImageCacher.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/13/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "ImageCacher.h"

@implementation ImageCacher

+ (ImageCacher *)sharedCacher {
    static dispatch_once_t once;
    static ImageCacher *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[ImageCacher alloc] init];
        sharedInstance.images = [NSMutableDictionary dictionary];
    });
    return sharedInstance;
}

- (void)setImage:(UIImage *)img forURL:(NSString *)urlString {
    [self.images setObject:img forKey:urlString];
}

- (UIImage *)getImageForURL:(NSString *)urlString {
    return [self.images objectForKey:urlString];
}

@end
