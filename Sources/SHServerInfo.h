//
//  SHServerInfo.h
//  SHRESTfulSample
//
//  Created by Shahin Katebi on 5/27/13.
//  Copyright (c) 2013 Shaahin.us. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SHServerInfo : NSObject
@property (nonatomic) NSString *baseURL;
@property (nonatomic) NSInteger resultDataType;
@property (nonatomic) NSInteger requestDataType;
@property (nonatomic) NSDictionary *sharedParams;

@end
