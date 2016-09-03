//
//  TodayViewController.m
//  Today - Just For Fun
//
//  Created by Denis Yamkovyy on 8/27/16.
//  Copyright © 2016 CompanyYamkovyiBrother's. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "TweetDownloadManager.h"
#import "Tweet.h"

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[TweetDownloadManager sharedManager] requestTwitterDataWithCompletetionBlock:^(BOOL success, NSArray *list, NSError *error) {
        if (success)
        {
        
            Tweet *yourTweet= list.lastObject;
            self.todayLabel.text = yourTweet.tweetData;
        
        }
        else
        {
            
        }
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}


@end
