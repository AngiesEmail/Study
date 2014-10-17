//
//  CSShyNavigationBar.m
//  SQTShyNavigationBar
//
//  Created by playcrab on 13/10/14.
//  Copyright (c) 2014年 playcrab. All rights reserved.
//

#import "CSShyNavigationBar.h"

const CGFloat kSQTDefaultAnimationDuration = 0.2f;
@interface CSShyNavigationBar () <UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic) CGFloat zeroingOffset;
@end

@implementation CSShyNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonSetup];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonSetup];
    }
    return  self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)commonSetup
{
    _enabled = YES;
    _settled = NO;
    _shyHeight = 20.0f;
    _fullHeight = self.frame.size.height;
    _shouldSnap = YES;
    _zeroingOffset = 0.0f;
    
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlerPath:)];
    _panRecognizer.delegate = self;
    
    self.updateBlock = ^(CGRect visibleFrame,CGFloat shyFraction,NSArray *subviews){
        for (UIView *view in subviews) {
            bool isBackgroundView = (view == subviews[0]);
            bool isViewHidden = view.hidden || view.alpha <FLT_EPSILON;
            
            if (!isBackgroundView && !isViewHidden) {
                view.alpha = MAX(shyFraction, FLT_EPSILON);
            }
        }
    };
    
}

-(void)setToFullHeight:(BOOL)animated
{
    CGRect frame = self.frame;
    frame.size.height = self.fullHeight;
    
    NSDictionary *locations = [self scrollLocationsForOffest:[self offsetOfScrollView:self.scrollView] frame:frame];
    CGFloat maximumLocation = [locations[@"maximum"] floatValue];
    
    frame.origin.y = maximumLocation;
    
    self.zeroingOffset = [self offsetOfScrollView:self.scrollView];
    
    [self moveToFrame:frame animated:animated];
}

-(NSDictionary*)scrollLocationsForOffest:(CGFloat)offset frame:(CGRect)frame
{
    CGFloat defaultLocation = [self defaultLocation];
    CGFloat minimumLocation = [self minimumLocationForFrame:frame];
    CGFloat maximumLocation = defaultLocation;
    
    CGFloat originY = MAX(MIN(maximumLocation, defaultLocation - offset), minimumLocation);
    CGFloat offsetOriginY = MAX(MIN(maximumLocation, defaultLocation - offset + self.zeroingOffset), minimumLocation);
    
    NSDictionary *locations = @{@"minimum": @(minimumLocation),
                                @"maximum": @(maximumLocation),
                                @"originY": @(originY),
                                @"offestOriginY":@(offsetOriginY)};
    return locations;
    
}

-(CGFloat)offsetOfScrollView:(UIScrollView*)scrollView
{
    CGFloat offset = self.fullHeight + [self defaultLocation] +scrollView.contentOffset.y;
    return offset;
}

-(CGFloat)defaultLocation
{
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            return [UIApplication sharedApplication].statusBarFrame.size.height;
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            return 0.0f;
            break;
        default:
            return 20.0f;
            break;
    }
    
}

-(CGFloat)minimumLocationForFrame:(CGRect)frame
{
    return self.shyHeight - frame.size.height;
}

-(void)moveToFrame:(CGRect)frame animated:(BOOL)animated
{
    [self moveToFrame:frame duration:(animated ? kSQTDefaultAnimationDuration : 0.0f)];
}

-(void)moveToFrame:(CGRect)frame duration:(CGFloat)duration
{
    void(^moveBlock)(void) = ^(void)
    {
        self.frame = frame;
        if (self.updateBlock && self.settled) {
            CGFloat maximumLocation = [self defaultLocation];
            CGFloat minimumLocation = [self minimumLocationForFrame:frame];
            CGFloat shyFraction = (frame.origin.y - minimumLocation)/(maximumLocation-minimumLocation);
            
            CGRect screenRect = [UIScreen mainScreen].bounds;
            CGRect intersection = CGRectIntersection(screenRect, frame);
            if (CGRectIsNull(intersection)) {
                intersection = CGRectZero;
            }
            self.updateBlock(intersection,shyFraction,self.subviews);
        }
        UIEdgeInsets inset = self.scrollView.contentInset;
        CGFloat statusBarHeight = [self defaultLocation];
        inset.top = MAX(MIN(self.fullHeight+statusBarHeight, frame.origin.y+frame.size.height), self.shyHeight);
        self.scrollView.contentInset = inset;
    };
    
    if (duration > 0.0f) {
        [UIView animateWithDuration:duration animations:moveBlock];
    }
    else
    {
        moveBlock();
    }
}

-(void)snapToLoactionForFrame:(CGRect)frame offset:(CGFloat)offset
{
    
}

@end
