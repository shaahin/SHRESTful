//
//  SHRESTful.h
//  SHRESTful Client
//
//  Created by Shahin Katebi on 5/27/13.
//  Copyright (c) 2013 Shaahin.us. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHResponse.h"
#import "SHServerInfo.h"

#define SHRESTFUL_HTTPMETHOD_GET @"GET"
#define SHRESTFUL_HTTPMETHOD_POST @"POST"
#define SHRESTFUL_HTTPMETHOD_DELETE @"DELETE"
#define SHRESTFUL_HTTPMETHOD_PUT @"PUT"


@class SHRESTful;
@protocol SHRESTfulAsyncConnectionDelegate <NSObject>

@optional
- (void) shRESTful: (SHRESTful *) restfulClient didFinishRequest: (NSURLRequest *) urlRequest withResponse: (SHResponse *) response;
- (void) shRESTful: (SHRESTful *) restfulClient failedFinishingRequest: (NSURLRequest *) urlRequest withResponse: (SHResponse *) response;

@end

@interface SHRESTful : NSObject

@property (nonatomic) SHServerInfo *server;
@property (nonatomic) id<SHRESTfulAsyncConnectionDelegate> delegate;

#pragma mark - Initializers

- (SHRESTful *) initClientForServer: (SHServerInfo *) server;
- (SHRESTful *) initClientForServer: (SHServerInfo *) server andDelegate: (id<SHRESTfulAsyncConnectionDelegate>) delegate;

#pragma mark - Execute WebAPI Methods

-(SHResponse *) executeMethodSynchronously:(NSString*)methodUrl withParams:(NSDictionary *)parameters andHTTPMethod: (NSString *)type;

-(BOOL) executeMethodAsynchronously:(NSString*)methodUrl withParams:(NSDictionary *)parameters andHTTPMethod: (NSString *)type;

@end
