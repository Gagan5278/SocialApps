//
//  InfoViewController.m
//  SocialApps
//
//  Created by Gagan Mishra on 10/14/14.
//  Copyright (c) 2014 Gagan_Work. All rights reserved.
//

#import "InfoViewController.h"
#import "YOSUserRequest.h"
@interface InfoViewController ()<YahooSessionDelegate>
{
    NSMutableArray *arrayOfFriends;
    NSMutableArray *dataHolderArray;
}
@end

@implementation InfoViewController
@synthesize sessionObject;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    arrayOfFriends=[NSMutableArray array];
    [self fetchUserProfile];
    [self.myActivityIndicator startAnimating];
    UIBarButtonItem *addButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddContactIntoYahooDirecotry)];
    [self.navigationItem setRightBarButtonItem:addButton animated:YES];
}

-(void)fetchUserProfile
{
    YOSUserRequest *userRequest = [YOSUserRequest requestWithSession:self.sessionObject];
    [userRequest fetchProfileWithDelegate:self];
}

-(void)fetchContactRequest
{
        YOSUserRequest *request=[YOSUserRequest requestWithSession:self.sessionObject];
       [request fetchContactsWithStart:0 andCount:400 withDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)requestDidFinishLoading:(YOSResponseData *)data
{
    dataHolderArray=[NSMutableArray array];
    NSDictionary *json = data.responseJSONDict;
    
    // Profile fetched
    NSDictionary *userProfile = json[@"profile"];
    if (userProfile) {
        [self performSelector:@selector(LoadUserProfile:) withObject:userProfile];
    }
    // Contacts fetched
    NSDictionary *contactDict = json[@"contacts"];
    if (contactDict) {
        NSArray *contactList = [YOSUserRequest parseContactList:contactDict];
        arrayOfFriends=[contactList mutableCopy];
        /*------------------------------------------------------------------------------------------------------Uncomment Below line If you want contacts with name only---------------------------------------------------------------------------------------
        arrayOfFriends= [[YOSUserRequest parseContactListForNameOnly:contactList] mutableCopy];
        ------------------------------------------------------------------------------------------------------Uncomment Below line If you want contacts with name only---------------------------------------------------------------------------------------*/
        dataHolderArray=[arrayOfFriends mutableCopy];
        [self.myFrndTableView reloadData];
        [self.myActivityIndicator stopAnimating];
    }
    NSDictionary *yqlDict = json[@"query"];
    if (yqlDict) {
        NSDictionary *yqlResults = yqlDict[@"results"];
        NSLog(@"%@",yqlResults);
    }
}

-(void)LoadUserProfile:(NSDictionary*)userData
{
    NSString  *birthYearStr=nil;
    NSString *birthDateStr=nil;
    if(userData[@"birthYear"])
       birthYearStr=userData[@"birthYear"];
    if(userData[@"birthdate"])
        birthDateStr=userData[@"birthdate"];
    
    NSString *fNameStr=nil;
    NSString *lNameStr=nil;
    if(userData[@"givenName"])
      fNameStr=userData[@"givenName"];
    if(userData[@"familyName"])
        lNameStr=userData[@"familyName"];

    
    self.userNameLabel.text=[NSString stringWithFormat:@"%@  %@, %@ , %@", (fNameStr.length?fNameStr:@""),(lNameStr.length?lNameStr:@""),([[userData[@"displayAge"] stringValue] length]?[userData[@"displayAge"] stringValue] :@""),([userData[@"location"] length]?userData[@"location"] :@"")];
    
    if([userData[@"emails"] count]>0)
    {
        if([[userData[@"emails"] objectAtIndex:0] valueForKey:@"handle"])
        {
            self.userIDLabel.text=[[userData[@"emails"] objectAtIndex:0] valueForKey:@"handle"];
        }
    }
    
    NSString *imgURLStr=nil;
    if(userData[@"image"])
        imgURLStr=[userData[@"image"] valueForKey:@"imageUrl"];
    if(imgURLStr)
    {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imgURLStr]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(!connectionError)
           self.userImageView.image=[UIImage imageWithData:data];
        [self fetchContactRequest];
    }];
    }
}
#pragma mark-TableView Delehgate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayOfFriends.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell=nil;
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSString *givenNameStr=nil;
    NSString *familyNameStr=nil;
    if([[arrayOfFriends[indexPath.row] valueForKey:@"name"] valueForKey:@"givenName"])
    {
        givenNameStr=[[arrayOfFriends[indexPath.row] valueForKey:@"name"] valueForKey:@"givenName"];
    }
    if([[arrayOfFriends[indexPath.row] valueForKey:@"name"] valueForKey:@"familyName"])
    {
        familyNameStr=[[arrayOfFriends[indexPath.row] valueForKey:@"name"] valueForKey:@"familyName"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%@ %@",(givenNameStr.length)?givenNameStr:@"",(familyNameStr.length)?familyNameStr:@""];
    if(cell.textLabel.text.length<=1)
    {
        cell.textLabel.text=@"No Name";
    }
    cell.textLabel.textColor=[UIColor whiteColor];
    if([[arrayOfFriends[indexPath.row] valueForKey:@"email"] valueForKey:@"value"])
    {
        cell.detailTextLabel.text=[[arrayOfFriends[indexPath.row] valueForKey:@"email"] valueForKey:@"value"];
    }
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//add Contacts into Yahoo
-(void)AddContactIntoYahooDirecotry
{
    //name, email and nickname
    YOSUserRequest *request=[YOSUserRequest requestWithSession:self.sessionObject];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:@"test" forKey:@"nickname"];
    [dict setValue:@"Gagan" forKey:@"name"];
    [dict setValue:@"gagan.aequor@gmail.com" forKey:@"email"];
   if( [request addContact:dict])
   {
       NSLog(@"Data Added");
   }
   else{
       NSLog(@"Failled ");
   }
}

#pragma mark SearchBar Delagets
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self preformSearchOfText:searchBar.text];
    [searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [arrayOfFriends removeAllObjects];
    arrayOfFriends=[dataHolderArray mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.myFrndTableView reloadData];
    });
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self preformSearchOfText:searchText];
}

-(void)preformSearchOfText:(NSString*)searchText
{
    NSMutableArray *array=[arrayOfFriends mutableCopy];
    [arrayOfFriends removeAllObjects];
    for(NSDictionary *dict in array)
    {
        if(([[[dict valueForKey:@"name"]valueForKey:@"givenName"]rangeOfString:searchText].location!=NSNotFound)||([[[dict valueForKey:@"name"]valueForKey:@"familyName"]rangeOfString:searchText].location!=NSNotFound)||([[[dict valueForKey:@"email"]valueForKey:@"value"]rangeOfString:searchText].location!=NSNotFound))
        {
            [arrayOfFriends addObject:dict];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myFrndTableView reloadData];
            });
        }
    }
}

@end
