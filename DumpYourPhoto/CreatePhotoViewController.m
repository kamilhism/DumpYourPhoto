//
//  CreatePhotoViewController.m
//  DumpYourPhoto
//
//  Created by Администратор on 11/15/13.
//  Copyright (c) 2013 KamilHism. All rights reserved.
//

#import "CreatePhotoViewController.h"
#import "DumpYourPhotoApiEngine.h"

@interface CreatePhotoViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *imageButton;

@property (nonatomic, strong) NSData *uploadImageData;
@property (nonatomic, strong) NSString *uploadImageName;

@end

@implementation CreatePhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageButton setImage:image forState:UIControlStateNormal];
    self.uploadImageData = UIImageJPEGRepresentation(image, 0.5);
    
    NSURL *imagePath = [info objectForKey:UIImagePickerControllerReferenceURL];
    self.uploadImageName = [imagePath lastPathComponent];
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex<=1){
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = buttonIndex==0? UIImagePickerControllerSourceTypePhotoLibrary:UIImagePickerControllerSourceTypeCamera;
        
        controller.delegate = self;
        
        [self presentViewController:controller animated:YES completion:^{
        }];
    } else {
    }
}

- (IBAction)addImageTapped:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose from library", @"Take a photo", nil];
    [sheet showInView:self.view];
}

- (IBAction)doneTapped:(id)sender {
    if ([self uploadImageName].length == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self uploadProgressIndicator];
        
        NSMutableDictionary *photoParams = [[NSMutableDictionary alloc] init];
        [photoParams addEntriesFromDictionary: @{ @"albumHash": [self.album albumHash], @"name": [self uploadImageName] }];
        
        [DumpYourPhotoApiEngine uploadPhoto:self.uploadImageData withName:self.uploadImageName forAlbum:self.album callback:^(bool success, NSString *error) {
            if (success) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Can not create album. Error: '%@' has been occured", error] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
            self.navigationItem.titleView = nil;
        }];
    }
}

-(void) uploadProgressIndicator {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.titleView = indicator;
    [indicator startAnimating];
}

@end
