//
//  YahooViewController.m
//  SocialApps
//
//  Created by Gagan Mishra on 10/14/14.
//  Copyright (c) 2014 Gagan_Work. All rights reserved.
//

#import "YahooViewController.h"
#import "InfoViewController.h"
#import "YahooSDK.h"
@interface YahooViewController ()<YahooSessionDelegate>

@end

@implementation YahooViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)loginButtonPressed:(id)sender {
    //https://developer.apps.yahoo.com/  //Please add you Consumer & Secret Key to run demo
    self.objectSession=[YahooSession  sessionWithConsumerKey:@"dj0yJmk9eW9Xek5JdFdCVjZCJmQ9WVdrOVRHZHNRrrfdsV2hVTm5t04bWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD0zZg--" andConsumerSecret:@"fc1d602938e0b49a7d02rttr61235b7246a3ed03b8ee" andApplicationId:@"Gagan224001" andCallbackUrl:@"http://openxcell.info" andDelegate:self];
    BOOL sessionExist=[self.objectSession resumeSession];
    if(!sessionExist)
    {
        [self.objectSession sendUserToAuthorization];
    }
    else{
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Already loggedin" message:@"Fetch relevant information" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES", nil];
        [alertView show];
    }
}

#pragma mark-alertView Delegate
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title=[alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"YES"])
    {
        InfoViewController *object=[[InfoViewController alloc]init];
        object.sessionObject=self.objectSession ;
        [self.navigationController pushViewController:object animated:YES];
    }
}

-(void)didReceiveAuthorization
{
    NSLog(@"Authorized");
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Loggedin successfully" message:@"Fetch relevant information" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES", nil];
    [alertView show];
}

@end
