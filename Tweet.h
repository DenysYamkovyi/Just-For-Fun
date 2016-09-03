//
//  Tweet.h
//  Just For Fun v.1.0
//
//  Created by Denis Yamkovyy on 8/24/16.
//  Copyright © 2016 CompanyYamkovyiBrother's. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *tweetData;
@property (strong, nonatomic) NSString *tweetImageURL;

+(Tweet*)tweetWithData:(NSDictionary*)data;

@end
