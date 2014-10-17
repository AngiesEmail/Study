//
//  CSShyNavigationBar.h
//  SQTShyNavigationBar
//
//  Created by playcrab on 13/10/14.
//  Copyright (c) 2014年 playcrab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSShyNavigationBar : UINavigationBar

@property (nonatomic) CGFloat shyHeight;
@property (nonatomic) CGFloat fullHeight;
@property (nonatomic) BOOL shouldSnap;
@property (nonatomic) BOOL enabled;
@property (nonatomic) BOOL settled;

@property (nonatomic,copy) void (^updateBlock)(CGRect visibleFrame, CGFloat shyFraction, NSArray *subViews);


-(void)scrollViewDidScroll:(UIScrollView*)scrollView;

-(void)setToFullHeight:(BOOL)animated;
-(void)setToShyHeight:(BOOL)animated;

-(void)prepareForSegueAway:(BOOL)animated;
-(void)adjustForSequeInto:(BOOL)animated;
-(void)adjustForSequeInto:(BOOL)animated scrollView:(UIScrollView*)scrollView;

@end

@interface UINavigationController (CSShyNavigationBar)

@property (nonatomic,readonly) CSShyNavigationBar *shyNavigationBar;

@end