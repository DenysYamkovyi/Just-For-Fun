//
//  ViewController.m
//  Just For Fun v.1.0
//
//  Created by Denis Yamkovyy on 8/21/16.
//  Copyright © 2016 CompanyYamkovyiBrother's. All rights reserved.
//

#import "ViewController.h"
#import "TweetDownloadManager.h"
#import "Tweet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TweetDownloadManager sharedManager] requestTwitterDataWithCompletetionBlock:^(BOOL success, NSArray *list, NSError *error) {
        if (success)
        {
            
        }
        else
        {
            
        }
    }];
        // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
