//
//  ViewController.h
//  OurCalender
//
//  Created by shuang yang on 3/10/15.
//  Copyright (c) 2015 shuang yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController<NSStreamDelegate>
{
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    NSMutableArray *returnedEvents;
    NSString *returnedStatus;
}

- (void)sendMsg:(NSString *)msg;
- (void)initNetworkCommunication;
@property (strong,nonatomic) NSMutableArray *events;
@property (strong,nonatomic) NSString *status;

@end
