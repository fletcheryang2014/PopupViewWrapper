//
//  KKPopupViewWrapper.h
//  KKTV
//
//  Created by yangyi on 2018/7/6.
//

#import <UIKit/UIKit.h>

@class KKPopupViewWrapper;

@protocol KKPopupViewProtocol <NSObject>

@property (nonatomic, weak) KKPopupViewWrapper * _Nullable wrapper;

- (nullable UIView *)show:(nonnull UIView *)parentView;
- (void)hide;

@end


// 给弹出视图加一个可点击的背景，点击背景视图隐藏
@interface KKPopupViewWrapper : UIButton <KKPopupViewProtocol>

- (instancetype _Nonnull )initWithView:( id<KKPopupViewProtocol> _Nonnull )popupView;

@property (nonatomic, strong) UIColor * _Nullable bgColor;//默认为nil，表示背景透明
@property (nonatomic, copy) void (^ _Nullable hideHandler) ();//背景及视图消失回调

@end

// 弹出视图需继承自该类
@interface KKPopupView : UIView <KKPopupViewProtocol>

@end


@interface KKPopupObject : NSObject <KKPopupViewProtocol>

- (void)hide NS_REQUIRES_SUPER;

@end
