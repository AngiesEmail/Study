//
//  CSViewController.m
//  ConnectInternet
//
//  Created by playcrab on 24/9/14.
//  Copyright (c) 2014年 playcrab. All rights reserved.
//

#import "CSViewController.h"

@interface CSViewController ()

@end

@implementation CSViewController
@synthesize request;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)requestData:(id)sender {
    [request setTitle:@"Hello" forState:UIControlStateNormal];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://email.edu2act.org/owa/auth/logon.aspx?replaceCurrent=1&url=https%3a%2f%2femail.edu2act.org%2f"]];
    NSString *addressText = @"beijing";
    addressText = [addressText stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSString *urlText = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",addressText];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlText]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
