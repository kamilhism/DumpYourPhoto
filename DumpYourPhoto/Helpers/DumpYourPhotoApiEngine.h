//
//  DumpYourPhotoApiEngine.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/8/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Album.h"
#import "Photo.h"

@interface DumpYourPhotoApiEngine : NSObject

+ (void)getAlbums:(void (^)(NSArray *array))callback;
+ (void)createAlbum:(NSDictionary *)albumData
           callback:(void (^)(bool success, NSString *error))callback;

+ (void)getPhotosForAlbum:(Album *)album
                 callback:(void (^)(NSArray *array))callback;
+ (void)getImageFor:(Photo *)photo
           withSize:(NSString *)size
           callback:(void (^)(UIImage *image))callback;
+ (void)getPhotoData:(Photo *)photo
            callback:(void (^)(Photo *photoWithData))callback;
+ (void)uploadPhoto:(NSData *)imageData
         withName:(NSString *)imageName
           forAlbum:(Album *)album
           callback:(void (^)(bool success, NSString *error))callback;

@end
