//
//  LoginViewController.h
//  SocialApps
//
//  Created by Gagan Mishra on 10/16/14.
//  Copyright (c) 2014 Gagan_Work. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
typedef void(^LoginCallbackMethod)(BOOL);
@interface LoginViewController : UIViewController<GPPSignInDelegate,GPPShareDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActivityIndicator;
- (IBAction)loginButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *logiNbutton;

@end
