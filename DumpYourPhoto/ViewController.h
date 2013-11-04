//
//  ViewController.h
//  DumpYourPhoto
//
//  Created by Администратор on 11/4/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    IBOutlet UITextField *_usernameField;
    IBOutlet UITextField *_passwordField;
}

- (IBAction) signinTapped;

@end
