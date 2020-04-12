//
//  ViewController.m
//  PopupViewWrapper
//
//  Created by yangyi on 2020/4/12.
//  Copyright © 2020 yangyi. All rights reserved.
//

#import "ViewController.h"
#import "KKPopupViewWrapper.h"

// 集成自KKPopupView的浮层
@interface DemoPopupView : KKPopupView

@end

@implementation DemoPopupView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 60, 100, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"Demo 2";
        [self addSubview:label];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(60, 120, 80, 40)];
        [btn setTitle:@"OK" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)onBtnClicked:(id)sender {
    // 可以调用基类的hide方法
    [super hide];
}

@end

// 有弹出和移除动画的浮层
@interface DemoPopupView2 : KKPopupView

@end

@implementation DemoPopupView2

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(frame) - 100)/2, 80, 100, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"Demo 3";
        [self addSubview:label];
    }
    return self;
}

#pragma mark - override

- (UIView *)show:(UIView *)parentView
{
    [parentView addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = parentView.frame.size.height - frame.size.height;
        self.frame = frame;
    }];
    return self;
}

- (void)hide
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = self.superview.frame.size.height;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [super hide];
    }];
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onDemo1BtnClicked:(id)sender {
    // 只需要展示内容的简单浮层，直接创建KKPopupView对象，并在它上面添加内容子视图
    KKPopupView *popupView = [[KKPopupView alloc] initWithFrame:CGRectMake(0, 0, 200, 160)];
    popupView.backgroundColor = [UIColor whiteColor];
    popupView.center = self.view.center;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 60, 100, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Demo 1";
    [popupView addSubview:label];
    
    KKPopupViewWrapper *wrapper = [[KKPopupViewWrapper alloc] initWithView:popupView];
    // 设置外围背景颜色
    wrapper.bgColor = [UIColor colorWithWhite:0 alpha:0.5];
    // 处理浮层移除事件
    wrapper.hideHandler = ^{
        NSLog(@"Popup View is removed.");
    };
    [wrapper show:self.view];
}

- (IBAction)onDemo2BtnClicked:(id)sender {
    // 复杂一些或有交互的浮层，可以继承自KKPopupView
    DemoPopupView *popupView = [[DemoPopupView alloc] initWithFrame:CGRectMake(0, 0, 200, 180)];
    popupView.backgroundColor = [UIColor whiteColor];
    popupView.center = self.view.center;
    
    KKPopupViewWrapper *wrapper = [[KKPopupViewWrapper alloc] initWithView:popupView];
    wrapper.bgColor = [UIColor colorWithWhite:0 alpha:0.5];
    [wrapper show:self.view];
}

- (IBAction)onDemo3BtnClicked:(id)sender {
    DemoPopupView2 *popupView = [[DemoPopupView2 alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 220)];
    popupView.backgroundColor = [UIColor whiteColor];
    
    KKPopupViewWrapper *wrapper = [[KKPopupViewWrapper alloc] initWithView:popupView];
    wrapper.bgColor = [UIColor colorWithWhite:0 alpha:0.5];
    [wrapper show:self.view];
}

@end
