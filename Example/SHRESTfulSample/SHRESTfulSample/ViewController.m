//
//  ViewController.m
//  SHRESTfulSample
//
//  Created by Shahin Katebi on 5/27/13.
//  Copyright (c) 2013 Shaahin.us. All rights reserved.
//

#import "ViewController.h"
#import "SHRESTful.h"

@interface ViewController () <SHRESTfulAsyncConnectionDelegate>
@property (nonatomic) SHRESTful *restfulClient;
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SHRESTful *)restfulClient
{
    if(!_restfulClient)
    {
        SHServerInfo *server = [SHServerInfo new];
        server.baseURL = self.baseURL.text;
        // set data type for the data returned from the API (for setting Accept header)
        // currently only JSON data type is supported.
        server.resultDataType = SHRESTFUL_DATATYPE_JSON;
        // set data type for the data being sent to the server
        // currently JSON and forms data type is supported.
        server.requestDataType = SHRESTFUL_DATATYPE_JSON;

        _restfulClient = [[SHRESTful alloc] initClientForServer:server andDelegate:self];
    }
    return _restfulClient;
}

- (IBAction)sendRequest:(UIButton *)sender {
    // update baseUrl
    self.restfulClient.server.baseURL = self.baseURL.text;

    NSString *httpMethod = @"";

    switch (self.httpMethodSegmentView.selectedSegmentIndex) {
        case 0:
            httpMethod = SHRESTFUL_HTTPMETHOD_GET;
            break;
        case 1:
            httpMethod = SHRESTFUL_HTTPMETHOD_POST;
            break;
        case 2:
            httpMethod = SHRESTFUL_HTTPMETHOD_DELETE;
            break;
        case 3:
            httpMethod = SHRESTFUL_HTTPMETHOD_PUT;
            break;
    }

    if(self.requestTypeSegmentView.selectedSegmentIndex == 0)
    {
        // Synchronously
        SHResponse *response = [self.restfulClient executeMethodSynchronously:self.method.text withParams:@{self.parameterKey.text: self.parameterValue.text} andHTTPMethod:httpMethod];

        NSString *message = [NSString stringWithFormat:@"Result code: %d\nerror: %@\nData is: %@", response.response.statusCode, response.error, response.result];
        [[[UIAlertView alloc] initWithTitle:@"SHRESTful Sync" message:message  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }else
    {
        // Asynchronously
        [self.restfulClient executeMethodAsynchronously:self.method.text withParams:@{self.parameterKey.text: self.parameterValue.text} andHTTPMethod:httpMethod];
    }

}

#pragma mark - SHRESTful Delegate
- (void)shRESTful:(SHRESTful *)restfulClient didFinishRequest:(NSURLRequest *)urlRequest withResponse:(SHResponse *)response
{
    NSString *message = [NSString stringWithFormat:@"Done. Result code: %d\nData is: %@", response.response.statusCode, response.result];
    [[[UIAlertView alloc] initWithTitle:@"SHRESTful Async" message:message  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}
- (void)shRESTful:(SHRESTful *)restfulClient failedFinishingRequest:(NSURLRequest *)urlRequest withResponse:(SHResponse *)response
{
    NSString *message = [NSString stringWithFormat:@"Failed. Result code: %d\nerror: %@", response.response.statusCode, response.error];
    [[[UIAlertView alloc] initWithTitle:@"SHRESTful Async" message:message  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}
@end
