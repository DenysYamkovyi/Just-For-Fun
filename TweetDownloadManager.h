//
//  TweetDownloadManager.h
//  Just For Fun v.1.0
//
//  Created by Denis Yamkovyy on 8/24/16.
//  Copyright © 2016 CompanyYamkovyiBrother's. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TweetDownloadManager : NSObject

+ (TweetDownloadManager*)sharedManager;
-(void)requestTwitterDataWithCompletetionBlock:(void (^)(BOOL success, NSArray *list, NSError *error))completionBlock;
@end
