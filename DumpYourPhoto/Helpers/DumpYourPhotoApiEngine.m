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
#import "Photo.h"
#import "CoreDataHelper.h"

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

+ (void)createAlbum:(NSDictionary *)albumData
           callback:(void (^)(bool success, NSString *error))callback {

    NSString *urlString = [NSString stringWithFormat:@"%@/albums", apiUrl];
    
    NSMutableDictionary *parameters = [albumData mutableCopy];
    [parameters addEntriesFromDictionary:[self apiKeyAsParam]];
    
    [[self requestManager] POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Album" inManagedObjectContext:[CoreDataHelper sharedInstance].moc];
        Album *albumModel = [[Album alloc] initWithEntity:entity insertIntoManagedObjectContext:[CoreDataHelper sharedInstance].moc];
        [albumModel setupWithObject:responseObject];
        [[CoreDataHelper sharedInstance].moc save:nil];
        
        callback(YES, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(NO, error.localizedDescription);
    }];
}

+ (void)getPhotosForAlbum:(Album *)album
                 callback:(void (^)(NSArray *array))callback {
    
    NSString *urlString = [NSString stringWithFormat:@"%@/albums/%@/photos", apiUrl, album.albumHash];
    
    [[self requestManager] GET:urlString parameters:[self apiKeyAsParam] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        callback([self.class photosArray:responseObject forAlbum:album]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

+ (void)getImageFor:(Photo *)photo
           withSize:(NSString *)size
           callback:(void (^)(UIImage *image))callback {
    
    AFHTTPRequestOperationManager *manager = [self requestManager];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    [manager GET:[photo imageUrl:size] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        callback(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

+ (void)getPhotoData:(Photo *)photo
            callback:(void (^)(Photo *photoWithData))callback {
    NSString *urlString = [NSString stringWithFormat:@"%@/photo/%@", apiUrl, photo.photoHash];
    
    [[self requestManager] GET:urlString parameters:[self apiKeyAsParam] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        callback([self.class updatePhotoWith:responseObject forPhoto:photo]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

+ (void)uploadPhoto:(NSData *)imageData
           withName:(NSString *)imageName
           forAlbum:(Album *)album
           callback:(void (^)(bool success, NSString *error))callback  {
    
    NSString *urlString = [NSString stringWithFormat:@"%@/albums/%@/photos?api_key=%@", apiUrl, album.albumHash, appDelegate.apiKey];
    
    [[self requestManager] POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"files" fileName:imageName mimeType:@""];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        [self newPhotoWith:responseObject[0] forAlbum:album]; // just per one photo upload yet
        callback(YES, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        callback(NO, error.localizedDescription);
    }];
}

+ (NSArray *)albumsArray:(id)albums {
    [Album clearAlbums];
    
    NSMutableArray *albumsModels = [NSMutableArray array];
    for (id album in albums) {
        NSNumber *albumId = album[@"id"];
        Album *albumModel = [Album findAlbumWithId:albumId]; // no need if we remove all firstly
        if (!albumModel) {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Album" inManagedObjectContext:[CoreDataHelper sharedInstance].moc];
            albumModel = [[Album alloc] initWithEntity:entity insertIntoManagedObjectContext:[CoreDataHelper sharedInstance].moc];
        }
        [albumModel setupWithObject:album];
        [albumsModels addObject:albumModel];
    }
    [[CoreDataHelper sharedInstance].moc save:nil];
    
    return albumsModels;
}

+ (NSArray *)photosArray:(id)photos forAlbum:(Album *)album {
    [Photo clearPhotos];
    
    NSMutableArray *photosModels = [NSMutableArray array];
    for (id photo in photos) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:[CoreDataHelper sharedInstance].moc];
        Photo *photoModel = [[Photo alloc] initWithEntity:entity insertIntoManagedObjectContext:[CoreDataHelper sharedInstance].moc];
        [photoModel setupWithObject:photo];
        [photosModels addObject:photoModel];
        
        [album addPhotosObject:photoModel];
    }
    album.photosCount = [NSNumber numberWithInt:photosModels.count];
    [[CoreDataHelper sharedInstance].moc save:nil];
    
    return photosModels;
}

+ (Photo *)updatePhotoWith:(id)photoData forPhoto:(Photo *)photoModel {
    [photoModel setupWithObject:photoData];
    [[CoreDataHelper sharedInstance].moc save:nil];
    return photoModel;
}

+ (void)newPhotoWith:(id)photoData forAlbum:(Album *)album {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:[CoreDataHelper sharedInstance].moc];
    Photo *photoModel = [[Photo alloc] initWithEntity:entity insertIntoManagedObjectContext:[CoreDataHelper sharedInstance].moc];
    [photoModel setupWithObject:photoData];
    [album addPhotosObject:photoModel];
    int increasedPhotosCount = [album.photosCount intValue];
    album.photosCount = [NSNumber numberWithInt:increasedPhotosCount + 1]; // wtf? work with nsnumber is so inconvenient
    [[CoreDataHelper sharedInstance].moc save:nil];
}

+ (AFHTTPRequestOperationManager *) requestManager {
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [serializer setHTTPMethodsEncodingParametersInURI:[NSSet setWithObjects:@"GET", @"HEAD", @"POST", nil]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = serializer;
    return manager;
}

+ (NSDictionary *) apiKeyAsParam {
    return @{@"api_key": appDelegate.apiKey};
}

@end
