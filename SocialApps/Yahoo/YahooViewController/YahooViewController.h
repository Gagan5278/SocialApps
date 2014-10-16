//
//  YahooViewController.h
//  SocialApps
//
//  Created by Gagan Mishra on 10/14/14.
//  Copyright (c) 2014 Gagan_Work. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YahooSession.h"
@interface YahooViewController : UIViewController
- (IBAction)loginButtonPressed:(id)sender;
@property(nonatomic,strong) YahooSession *objectSession;
@end
