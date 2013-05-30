//
//  SHResponse.h
//  SHRESTful Client
//
//  Created by Shahin Katebi on 5/27/13.
//  Copyright (c) 2013 Shaahin.us. All rights reserved.
//

#define SHRESTFUL_DATATYPE_JSON 2
#define SHRESTFUL_DATATYPE_FORMS 3

#import <Foundation/Foundation.h>

@interface SHResponse : NSObject
@property (nonatomic) NSHTTPURLResponse *response;
@property (nonatomic) NSError *error;
@property (nonatomic) id result;

-(BOOL) processResponseData: (NSData *) data ofType: (NSInteger) dataType;
@end
