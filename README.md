SHRESTful
=========

## Description
SHRESTful is a complete solution for using RESTful web APIs on iOS/MacOSX in Cocoa.

It uses the standard `NSURLConnection` to send requests to RESTful services and get the results.

It supports 'JSON' or 'forms' data format for requests.

It automatically handles connections, status codes and parsing the results returned from server.

## Technical Specs
`SHRESTful` class is the base class to be used in Xcode for iOS/MacOS projects.

You can send RESTful requests **synchronously** using method:

`executeMethodSynchronously:withParams:andHTTPMethod:`

or **asynchronously** using method:

`executeMethodAsynchronously:withParams:andHTTPMethod:`

`SHServerInfo` class is an object which holds RESTful server info. Including **API BaseURL**, **Request DataType (JSON or forms)**, **Response DataType & Shared Parameters (Not applicable yet)** 

`SHResponse` class is the result object returned from `SHRESTful`. it contains original `NSHTTPURLResponse` object as `response`, parsed data using selected `resultDataType` parser as `result` and error object as `error`.

**NOTE:** the `error` object is nil when the request has been sent without errors.

## How to Use
Include required headers:

	#import "SHRESTful.h"

For using **asynchronous** requests, implement `SHRESTfulAsyncConnectionDelegate` in your controller class.

Create an instance of `SHServerInfo` class in the controller (or whatever class) you want to send requests in.
Set your API server data:

	SHServerInfo *server = [SHServerInfo new];
    server.baseURL = @"http://your-api.com";
    server.resultDataType = SHRESTFUL_DATATYPE_JSON;
    server.requestDataType = SHRESTFUL_DATATYPE_JSON;


Then create an instance of `SHRESTful` and set `self` as it's delegate:

	SHRESTful *restfulClient = [[SHRESTful alloc] initClientForServer:server andDelegate:self];
	
Now send a **synchronous** request:

	SHResponse *response = [self.restfulClient executeMethodSynchronously:@"login" withParams:@{@"username": @"shahin", @"password": @"111"} andHTTPMethod:SHRESTFUL_HTTPMETHOD_GET];
	
	// use response:
	NSInteger statusCode = response.response.statusCode;
	id result = response.result;
    NSError *error = response.error;
	
or send an **asynchronous** request:

	[self.restfulClient executeMethodAsynchronously:@"login" withParams:@{@"username": @"shahin", @"password": @"111"} andHTTPMethod:SHRESTFUL_HTTPMETHOD_GET];
	
and implement delegate methods to get result:

	- (void)shRESTful:(SHRESTful *)restfulClient didFinishRequest:(NSURLRequest *)urlRequest withResponse:(SHResponse *)response
	{
		NSInteger statusCode = response.response.statusCode;
		id result = response.result;

		// do something
	}
	
	- (void)shRESTful:(SHRESTful *)restfulClient failedFinishingRequest:(NSURLRequest *)urlRequest withResponse:(SHResponse *)response
	{
    	NSInteger statusCode = response.response.statusCode;
    	id result = response.result;
    	NSError *error = response.error;
    	
    	// do something
	}

Please check the sample project too for a complete implementation of `SHRESTful`

## To do
Any ideas to make this better?


## About

Shahin Katebi

- [Shaahin.us](http://shaahin.us)
- [GitHub/shaahin](http://github.com/shaahin)
- [Twitter/ShahinKatebi](http://twitter.com/ShahinKatebi)


