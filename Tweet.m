//
//  Tweet.m
//  Just For Fun v.1.0
//
//  Created by Denis Yamkovyy on 8/24/16.
//  Copyright © 2016 CompanyYamkovyiBrother's. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

+(Tweet*)tweetWithData:(NSDictionary*)data
{
    Tweet *tweet = [Tweet new];
    NSDictionary *statuses = [data objectForKey:@"retweeted_status"];
    tweet.tweetData = statuses[@"text"];
    tweet.tweetImageURL = data[@"image"];
    
    return tweet;
}


@end
