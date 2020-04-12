//
//  KKPopupViewWrapper.m
//  KKTV
//
//  Created by yangyi on 2018/7/6.
//

#import "KKPopupViewWrapper.h"

@implementation KKPopupViewWrapper
{
    id<KKPopupViewProtocol> _popupView;
}

@synthesize wrapper;

- (instancetype)initWithView:(id<KKPopupViewProtocol>)popupView
{
    if (self = [super init]) {
        _popupView = popupView;
        _popupView.wrapper = self;
    }
    return self;
}

- (UIView *)show:(UIView*)parentView
{
    UIView *view = [_popupView show:parentView];
    
    if (self.bgColor) self.backgroundColor = self.bgColor;
    self.frame = parentView.bounds;
    [self addTarget:self action:@selector(onBkgButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [parentView insertSubview:self belowSubview:view];
    return nil;
}

- (void)hide
{
    if (self.hideHandler) self.hideHandler();
    [self removeFromSuperview];
}

- (void)onBkgButtonClicked:(id)sender
{
    [_popupView hide];
}

@end


@implementation KKPopupView

@synthesize wrapper;

- (UIView*)show:(UIView *)parentView
{
    [parentView addSubview:self];
    return self;
}

- (void)hide
{
    [self removeFromSuperview];
    
    [self.wrapper hide];
}

@end


@implementation KKPopupObject

@synthesize wrapper;

- (UIView *)show:(UIView *)parentView
{
    return nil;
}

- (void)hide
{
    [self.wrapper hide];
}

@end
