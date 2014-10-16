//
//  InfoViewController.h
//  SocialApps
//
//  Created by Gagan Mishra on 10/14/14.
//  Copyright (c) 2014 Gagan_Work. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YahooSession.h"
#import "JPRadialActivityIndicator.h"
typedef void (^FetchCompletionHandler)(BOOL);
@interface InfoViewController : UIViewController<UISearchBarDelegate>
@property(strong,nonatomic)YahooSession *sessionObject;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIDLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (nonatomic, retain) JPRadialActivityIndicator *activityIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActivityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *myFrndTableView;
@end
