//
//  SHRESTful.m
//  SHRESTful Client
//
//  Created by Shahin Katebi on 5/27/13.
//  Copyright (c) 2013 Shaahin.us. All rights reserved.
//

#import "SHRESTful.h"

@implementation SHRESTful
- (SHRESTful *)initClientForServer:(SHServerInfo *)server
{
    self = [SHRESTful new];
    self.server = server;
    return self;
}
- (SHRESTful *)initClientForServer:(SHServerInfo *)server andDelegate:(id<SHRESTfulAsyncConnectionDelegate>)delegate
{
    self = [[SHRESTful alloc] initClientForServer:server];
    self.delegate = delegate;
    return self;
}
-(NSURLRequest *) createRequestWithMethodUrl: (NSString*)methodUrl params:(NSDictionary *)parameters andMethodType: (NSString *)type
{
    __block NSMutableString* reqString = [NSMutableString string];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        [reqString appendFormat:@"&%@=%@", key,obj];
    }];

    //Request
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",self.server.baseURL,methodUrl]]];
    if(parameters.count > 0)
    {
        [reqString deleteCharactersInRange:NSMakeRange(0,1)];
        if([type isEqualToString:SHRESTFUL_HTTPMETHOD_GET])
        {
            request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",request.URL,reqString]];
        }else {



            NSData* requestData = nil;
            switch (self.server.requestDataType) {
                case SHRESTFUL_DATATYPE_JSON:
                default:
                    requestData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
                    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                    break;
                case SHRESTFUL_DATATYPE_FORMS:
                    requestData = [reqString dataUsingEncoding:NSUTF8StringEncoding];
                    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                    break;
            }

            [request setHTTPBody: requestData];
        	[request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
        }

	}

	[request setHTTPMethod: type];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	
    return request;
}

-(SHResponse *) executeMethodSynchronously:(NSString*)methodUrl withParams:(NSDictionary *)parameters andHTTPMethod: (NSString *)type
{
    NSHTTPURLResponse* response;
    NSError* error = nil;

    //Capturing server response
    NSData* data = [NSURLConnection sendSynchronousRequest:[self createRequestWithMethodUrl:methodUrl params:parameters andMethodType:type] returningResponse:&response error:&error];
    SHResponse *responseData = [SHResponse new];
    responseData.response = response;
    responseData.error = error;
    [responseData processResponseData:data ofType:self.server.resultDataType];
    return responseData;
}
-(BOOL) executeMethodAsynchronously:(NSString*)methodUrl withParams:(NSDictionary *)parameters andHTTPMethod: (NSString *)type
{
    NSURLRequest *request = [self createRequestWithMethodUrl:methodUrl params:parameters andMethodType:type];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

        //Capturing server response
        SHResponse *responseData = [SHResponse new];
        responseData.response = (NSHTTPURLResponse *)response;
        responseData.error = error;
        if(error)
        {
            [self.delegate shRESTful:self failedFinishingRequest:request withResponse:responseData];
        }else
        {
            [responseData processResponseData:data ofType:self.server.resultDataType];
            [self.delegate shRESTful:self didFinishRequest:request withResponse: responseData];
        }
    }];
    return YES;
}
@end
