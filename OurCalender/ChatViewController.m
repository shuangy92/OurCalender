//
//  ViewController.m
//  OurCalender
//
//  Created by shuang yang on 3/10/15.
//  Copyright (c) 2015 shuang yang. All rights reserved.
//

#import "ChatViewController.h"
#import "Event.h"
#import "User.h"

@interface ChatViewController ()
@property NSMutableArray *returnedEvents;
@end

@implementation ChatViewController

@synthesize events = _events;
@synthesize status = _status;

- (NSMutableArray *)events {
    return _events;
}
- (NSString *)status {
    return _status;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.returnedEvents = [NSMutableArray array];
    returnedStatus = @"";
    
}
- (id)init {
    NSLog(@"Initialize connect");
    
    self = [super init];
    [self initNetworkCommunication];
    self.returnedEvents = [NSMutableArray array];
    returnedStatus = @"";
    return self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initNetworkCommunication {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"104.238.96.138", 1992, &readStream, &writeStream);
    NSLog(@"Sending msg..");
    
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
}
- (void)sendMsg:(NSString *)msg {
    NSLog(msg);
    
    NSData *data = [[NSData alloc] initWithData:[msg dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
}
- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    NSString *result = @"";
    switch (streamEvent) {
            
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
            
        case NSStreamEventErrorOccurred:
            NSLog(@"Can not connect to the host!");
            break;
            
        case NSStreamEventEndEncountered:
            break;
            
        case NSStreamEventHasBytesAvailable:
            
            if (theStream == inputStream) {
                
                uint8_t buffer[1024];
                int len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        result =  [result stringByAppendingString:output];
                        if (nil != output) {
                            NSLog(@"server said: %@", output);
                        }
                        
                        
                    }
                }
                [self messageReceived:result];
            }
            
            break;
            
        default:
            NSLog(@"Unknown event");
    }
}

- (void) messageReceived:(NSString *)result {
    if (result.length > 0) {
        NSString *r = (NSString *) [result substringFromIndex:1];
        if (r.length > 0) {
            NSString *cid = [result substringToIndex:1];
            NSString *rr = [r substringToIndex:r.length-1];
            if ([cid isEqualToString:@"0"]) {
                returnedStatus = rr;
            }
            else if ([cid isEqualToString:@"1"]) {
                if (![r isEqualToString:@"failed"]) {
                    [User setUsername:rr];
                }
            }
            else if ([cid isEqualToString:@"2"] || [cid isEqualToString:@"3"] || [cid isEqualToString:@"4"]) {
                [self parseResult:rr];
            }
            else if ([cid isEqualToString:@"5"]) {
                returnedStatus = rr;
            }
        }
        
    }
    
}
- (void) parseResult:(NSString *)result {
    if (result.length > 0) {
        NSString *r = [result substringToIndex:result.length-1];
        NSArray *eventL = [r componentsSeparatedByString:@"_"];
        for (NSString *c in eventL) {
            NSString *cc = [c substringToIndex:c.length-1];
            NSArray *detailL = [c componentsSeparatedByString:@"^"];
            Event *e = [[Event alloc]init];
            e.hostname = [detailL objectAtIndex:0];
            e.eventTitle = [detailL objectAtIndex:1];
            e.eventLocation = [detailL objectAtIndex:2];
            e.eventDetail = [detailL objectAtIndex:3];
            e.startDate = [detailL objectAtIndex:4];
            e.endDate = [detailL objectAtIndex:5];
            e.invites = [detailL objectAtIndex:6];
            [self.returnedEvents addObject:e];
        }
        [User setEvents:self.returnedEvents];

        returnedStatus = @"EventsOK";
    }
}
/*
 /*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
