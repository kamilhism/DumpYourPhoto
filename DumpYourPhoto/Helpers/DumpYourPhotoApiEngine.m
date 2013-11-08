//
//  DumpYourPhotoApiEngine.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/8/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "DumpYourPhotoApiEngine.h"
#import "AppDelegate.h"
#import "Album.h"

#import <AFNetworking.h>

#define apiUrl @"https://api.dumpyourphoto.com/v1"

@implementation DumpYourPhotoApiEngine

+ (void)getAlbums:(void (^)(NSArray *array))callback {
    
    NSString *urlString = [NSString stringWithFormat:@"%@/albums", apiUrl];
    
    [[self requestManager] GET:urlString parameters:[self apiKeyAsParam] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        callback([self.class albumsArray:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

+ (NSArray *)albumsArray:(id)albums {
    NSMutableArray *albumsModels = [NSMutableArray array];
    for (id album in albums) {
        Album *albumModel = [[Album alloc] init];
        albumModel.name = album[@"name"];
        albumModel.photosCount = [album[@"photos"] longLongValue];
        [albumsModels addObject:albumModel];
    }
    return albumsModels;
}

+ (AFHTTPRequestOperationManager *) requestManager {
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = serializer;
    return manager;
}

+ (NSDictionary *) apiKeyAsParam {
    return @{@"api_key": appDelegate.apiKey};
}

@end
