//
//  LoginViewController.m
//  OurCalender
//
//  Created by shuang yang on 3/10/15.
//  Copyright (c) 2015 shuang yang. All rights reserved.
//

#import "LoginViewController.h"
#import "ChatViewController.h"
#import "EventsViewController.h"
#import "User.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController
{
    ChatViewController *chat;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    chat = [[ChatViewController alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (IBAction)submit:(UIButton *)sender {
    NSString *un = self.username.text;
    NSString *pw = self.password.text;
    NSLog(@"Submit login msg");
    
    if ([un length] == 0 || [pw length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty username or password"
                                                        message:@"Please try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        NSString *msg = [NSString stringWithFormat:@"1%@_%@\n", un, pw];
        [chat sendMsg:msg];
    }
}

#pragma mark - Navigation
/*- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
    /*if ([identifier isEqualToString:@"afterLogin"]) {

        NSString *result = chat.status;
        if ([result isEqualToString:@"successful\n"]) {
            [User setUsername:self.username.text];
            return true;
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:result
                                                            message:@"Please try again."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return false;
        }
    }
    return false;
}*/

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"afterLogin"]) {
        
        UIViewController *destViewController = segue.destinationViewController;
        destViewController.navigationItem.hidesBackButton = YES;
        destViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logout) ];

    }
}
- (void)logout {
    
}


@end
