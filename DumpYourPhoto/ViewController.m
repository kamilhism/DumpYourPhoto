//
//  ViewController.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/4/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <ObjectiveGumbo.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (IBAction) signinTapped
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"https://dumpyourphoto.com" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        OGNode *data = [ObjectiveGumbo parseDocumentWithString:operation.responseString];
        OGElement *input = [data elementsWithID:@"form_dyp_csrf_token"].firstObject;
        NSString *csrf_token = input.attributes[@"value"];
        
        NSDictionary *parameters = @{
            @"username": _usernameField.text,
            @"password": _passwordField.text,
            @"dyp_csrf_token": csrf_token
        };
        
        [manager POST:@"https://dumpyourphoto.com/user/log_in" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", operation.responseString);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    /*
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not log in. Please check username and password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    */
}

@end
