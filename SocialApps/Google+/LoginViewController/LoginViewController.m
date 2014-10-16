//
//  LoginViewController.m
//  SocialApps
//
//  Created by Gagan Mishra on 10/16/14.
//  Copyright (c) 2014 Gagan_Work. All rights reserved.
//

#import "LoginViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
@interface LoginViewController ()

@end
static NSString * const kClientId = @"160252709827-891kvgpnbhcmb7ucnono0u0kt214iqre.apps.googleusercontent.com";

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoginIntoGooglePlus];
    self.myTableView.backgroundColor=[UIColor clearColor];
}

-(void)LoginIntoGooglePlus
{
    GPPSignIn *signin=[GPPSignIn sharedInstance];
     signin.shouldFetchGooglePlusUser=YES;
    signin.shouldFetchGoogleUserEmail=YES;
    signin.shouldFetchGoogleUserID=YES;
    signin.clientID=kClientId;
    signin.scopes=@[kGTLAuthScopePlusLogin];  // You can use profile as scope.
    signin.delegate=self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark Gplus SignIn Delegate
-(void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    if(!error)
    {
        self.myTableView.alpha=0.0;
        self.myTableView.hidden=NO;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        self.myTableView.alpha=1.0;
        self.myTableView.frame=CGRectMake(0, 64, 320, [UIScreen mainScreen].bounds.size.height/2);
        self.logiNbutton.frame=CGRectMake(self.logiNbutton.frame.origin.x, [UIScreen mainScreen].bounds.size.height/2+74, self.logiNbutton.frame.size.width, self.logiNbutton.frame.size.height);
        [UIView commitAnimations];
    }
    else{
    }
    [self.myActivityIndicator stopAnimating];

}

- (void)presentSignInViewController:(UIViewController *)viewController {
    [[self navigationController] pushViewController:viewController animated:YES];
}

//-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
//    [self.navigationController pushViewController:viewControllerToPresent animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    [self.myActivityIndicator startAnimating];
    [[GPPSignIn sharedInstance] authenticate];
}
#pragma mark-TableView Delehgate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell=nil;
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=@"Share";
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        default:
            break;
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.textColor=[UIColor whiteColor];
    return cell;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self performSelector:@selector(ShareItem)];
            break;
        case 1:
            
            break;
        case 2:
            
            break;

        default:
            break;
    }
}

-(void)ShareItem
{
      [GPPShare sharedInstance].delegate = self;
    id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
    //Share URL
//    [shareBuilder setURLToShare:[NSURL URLWithString:@"https://www.example.com/restaurant/sf/1234567/"]];
    
    //Share Images
//    NSString *path=[[NSBundle mainBundle]pathForResource:@"SharedImage" ofType:@"png"];
//    UIImage *image=[UIImage imageWithContentsOfFile:path];
//    [shareBuilder attachImage:image];
    
    //Share Videos
    NSString *videoStr=[[NSBundle mainBundle]pathForResource:@"LipidLayer" ofType:@"mp4"];
    NSURL *videoURL=[NSURL URLWithString:videoStr];
    [shareBuilder attachVideoURL:videoURL];
    [shareBuilder open];
}

#pragma marh-share delegate
- (void)finishedSharingWithError:(NSError *)error
{
    if(error)
    {
       NSLog(@"Error in share is : %@",error.localizedDescription);
    }
}
- (void)finishedSharing:(BOOL)shared
{
    NSLog(@"Shared successfully");
}

@end
