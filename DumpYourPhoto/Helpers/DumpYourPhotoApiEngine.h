//
//  DumpYourPhotoApiEngine.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/8/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DumpYourPhotoApiEngine : NSObject

+ (void)getAlbums:(void (^)(NSArray *array))callback;

@end
