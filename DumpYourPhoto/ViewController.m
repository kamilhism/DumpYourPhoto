//
//  ViewController.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/4/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "ViewController.h"
#import "AlbumsViewController.h"
#import "AppDelegate.h"

#import <AFNetworking.h>
#import <ObjectiveGumbo.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"apiKey"] length] != 0) {
        [self performSegueWithIdentifier:@"signInSeque" sender:nil];
    }
}

- (IBAction) signinTapped
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
 
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not log in. Please check username and password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];

    [manager GET:@"https://dumpyourphoto.com" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *csrfToken = [self valueOfHtmlNode:@"form_dyp_csrf_token" :operation.responseString];
        
        NSDictionary *parameters = @{
            @"username": _usernameField.text,
            @"password": _passwordField.text,
            @"dyp_csrf_token": csrfToken
        };
        
        [manager POST:@"https://dumpyourphoto.com/user/log_in" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *apiKey = [self valueOfHtmlNode:@"api-key" :operation.responseString];
            
            if ([apiKey length] == 0) { // dev mode is not activated
                
                NSString *csrfToken = [self valueOfHtmlNode:@"form_dyp_csrf_token" :operation.responseString];
                
                NSDictionary *parameters = @{
                   @"developer": @"true",
                   @"dyp_csrf_token": csrfToken
                };
                
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
                [manager POST:@"https://dumpyourphoto.com/user/developer" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSString *apiKey = responseObject[@"key"];
                    
                    if ([apiKey length] == 0) {
                        [alert show];
                    } else {
                        [self authComplete:apiKey];
                    }
                    
                
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [alert show];
                }];
            } else {
                [self authComplete:apiKey];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [alert show];
        }];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [alert show];
    }];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return NO;
}

- (void)authComplete:(NSString *)apiKey {
    [[NSUserDefaults standardUserDefaults] setValue:apiKey forKey:@"apiKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    appDelegate.apiKey = apiKey;
    
    NSLog(@"%@", apiKey);
    
    [self performSegueWithIdentifier:@"signInSeque" sender:nil];
}

- (NSString *)valueOfHtmlNode:(NSString *)elementId :(NSString *)html{
    OGNode *structure = [ObjectiveGumbo parseDocumentWithString:html];
    OGElement *input = [structure elementsWithID:elementId].firstObject;
    return input.attributes[@"value"];
}

@end
