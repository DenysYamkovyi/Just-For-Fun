//
//  TweetDownloadManager.m
//  Just For Fun v.1.0
//
//  Created by Denis Yamkovyy on 8/24/16.
//  Copyright © 2016 CompanyYamkovyiBrother's. All rights reserved.
//

#import "TweetDownloadManager.h"
#import "Tweet.h"
#import "AFNetworking.h"

#define kBAseURL @"https://api.twitter.com"

@interface TweetDownloadManager()

@property (strong, nonatomic) NSString *token;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) NSMutableArray *tweetsArray;

@end

@implementation TweetDownloadManager


+ (TweetDownloadManager*)sharedManager
{
    static dispatch_once_t pred;
    static TweetDownloadManager *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[TweetDownloadManager alloc] init];
        
        shared.token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        [shared initSessionManager];
        shared.tweetsArray = [[NSMutableArray alloc] init];
    });
    
    return shared;
}

- (void)initSessionManager
{
    
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBAseURL]];
    [self.sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
}


-(void)requestTwitterDataWithCompletetionBlock:(void (^)(BOOL success, NSArray *info, NSError *error))completionBlock
{
    if (self.token)
    {
        [self requestDataWithCompletetionBlock:^(BOOL success, NSArray *info, NSError *error) {
            completionBlock(success, info, error);
        }];
    }
    else
    {
        [self.sessionManager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"e4G139SaudZm6mLoE6wvIINti"
                                           password:@"3ZFsEZKx2FwV4PpCdsfegrlSrIXSZw7XDJXvUoiEEvNE0KUPxr"];
        
        __weak TweetDownloadManager *weakSelf = self;
        [self.sessionManager POST:@"/oauth2/token?grant_type=client_credentials" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            typeof(self) strongSelf = weakSelf;
            if (strongSelf)
            {
                if (responseObject[@"access_token"])
                {
                    self.token = responseObject[@"access_token"];
                    [self requestDataWithCompletetionBlock:^(BOOL success, NSArray *array, NSError *error) {
                        completionBlock(success, array, error);
                    }];
                }
                else
                {
                    completionBlock(NO, nil, nil);
                }

            }
                    }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@" ");
                completionBlock(NO, nil, error);
            }];
                                        
                                        
    }
}

-(void)saveToken:(NSString*)token
{
    self.token = token;
    [[NSUserDefaults standardUserDefaults] setObject:self.token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)requestDataWithCompletetionBlock:(void (^)(BOOL success, NSArray *array, NSError *error))completionBlock
{
    [self.sessionManager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"" password:@""];
    NSDictionary *parameters = @{@"q":@"@FactSoup"};
    [self.sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", self.token] forHTTPHeaderField:@"Authorization"];
    [self.sessionManager GET:@"/1.1/search/tweets.json" parameters: parameters progress:nil

      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSArray *twitterArray = [responseObject objectForKey:@"statuses"];
        if (twitterArray)
        {
           
            for (NSDictionary *tempTweet in twitterArray)
            {
                Tweet *tweet = [Tweet tweetWithData:tempTweet];
                [self.tweetsArray addObject:tweet];
            }
            completionBlock (YES, self.tweetsArray, nil);
        }
        else
        {
            completionBlock (NO, nil, nil);
        }
    }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        completionBlock (NO, nil, error);
    }];
}


@end
