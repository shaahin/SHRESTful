//
//  SHResponse.m
//  SHRESTful Client
//
//  Created by Shahin Katebi on 5/27/13.
//  Copyright (c) 2013 Shaahin.us. All rights reserved.
//

#import "SHResponse.h"

@implementation SHResponse
-(BOOL) processResponseData: (NSData *) data ofType: (NSInteger) dataType
{
    @try {
        switch (dataType) {
            case SHRESTFUL_DATATYPE_JSON:
            default:
                self.result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
                break;
        }
    return YES;
}
@catch (NSException *exception) {}
return NO;
}
@end
