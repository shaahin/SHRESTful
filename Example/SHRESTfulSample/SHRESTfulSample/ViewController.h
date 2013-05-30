//
//  ViewController.h
//  SHRESTfulSample
//
//  Created by Shahin Katebi on 5/27/13.
//  Copyright (c) 2013 Shaahin.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *baseURL;
@property (weak, nonatomic) IBOutlet UITextField *method;
@property (weak, nonatomic) IBOutlet UITextField *parameterKey;
@property (weak, nonatomic) IBOutlet UITextField *parameterValue;
@property (weak, nonatomic) IBOutlet UISegmentedControl *httpMethodSegmentView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *requestTypeSegmentView;
- (IBAction)sendRequest:(UIButton *)sender;

@end
