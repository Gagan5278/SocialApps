//
//  ViewController.m
//  SocialApps
//
//  Created by Gagan Mishra on 10/14/14.
//  Copyright (c) 2014 Gagan_Work. All rights reserved.
//

#import "ViewController.h"
#import "YahooViewController.h"
#import "LoginViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSBundle mainBundle]loadNibNamed:@"ViewController" owner:self options:nil];
    _myTableView.backgroundColor=[UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark-TableView Delehgate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell=nil;
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.textLabel.shadowColor=[UIColor blackColor];
    }
    cell.backgroundColor=[UIColor clearColor];
    switch (indexPath.row) {
        case 0:
                 cell.textLabel.text=@"Yahoo";//Yahoo Login
            break;
            case 1:
                cell.textLabel.text=@"Google +";//Yahoo Login
            break;
        default:
            break;
    }

    return cell;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            YahooViewController *object=[[YahooViewController alloc]init];
            [self.navigationController pushViewController:object animated:YES];
        }
            break;
            case 1:
        {
            LoginViewController *loginView=[[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginView animated:YES];
        }
        default:
            break;
    }

}


@end
