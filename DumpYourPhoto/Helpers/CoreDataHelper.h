//
//  CoreDataHelper.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/10/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSManagedObjectContext *moc;

@end
