//
//  ViewController.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/4/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "ViewController.h"

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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not log in. Please check username and password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
    NSLog(@"%@", _usernameField.text);
}

@end
