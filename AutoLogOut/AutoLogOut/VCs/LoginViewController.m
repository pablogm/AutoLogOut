//
//  LoginViewController.m
/*
 * Copyright 2014 Pablo GM <invanzert@gmail.com>. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LoginViewController.h"
#import "ContentViewController.h"
#import "AutoLogOutUIApplication.h"


@implementation LoginViewController


#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}


#pragma mark - Login

- (IBAction)goToContentScreen:(id)sender
{
    ContentViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:kContentID];
    [self.navigationController pushViewController:cvc animated:YES];
}


#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Hide navigation bar
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    ((AutoLogOutUIApplication *)[UIApplication sharedApplication]).enableAutoLogout = YES;
    [(AutoLogOutUIApplication *)[UIApplication sharedApplication] resetAlarm];
    
    PGMLogger("Enable Auto Logout");
}

- (void)viewWillAppear:(BOOL)animated
{
    // Stop time out observer
    ((AutoLogOutUIApplication *)[UIApplication sharedApplication]).enableAutoLogout = NO;
    
    PGMLogger("Disable Auto Logout");
}


#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
