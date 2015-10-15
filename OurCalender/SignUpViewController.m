//
//  SignUpViewController.m
//  OurCalender
//
//  Created by shuang yang on 3/10/15.
//  Copyright (c) 2015 shuang yang. All rights reserved.
//

#import "SignUpViewController.h"
#import "ChatViewController.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *password2;

@end

@implementation SignUpViewController
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
    NSString *pw2 = self.password2.text;
    NSLog(@"Submit signup msg");

    if ([un length] == 0 || [pw length] == 0 || [pw2 length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty username or password"
                                                        message:@"Please try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    }
    if ([pw isEqualToString:pw2]) {
        NSString *msg = [NSString stringWithFormat:@"0%@_%@\n", un, pw];
        [chat sendMsg:msg];
    } else {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password not matching"
                                                        message:@"Please try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"afterSignUp"]) {
        
        UIViewController *destViewController = segue.destinationViewController;
    }
}


@end
