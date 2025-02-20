//
//  QukanLxButton.h
//  ButtonBlock
//
//  Created by chuanglong02 on 16/8/4.
//  Copyright © 2016年 chuanglong02. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  Font(f) [UIFont systemFontOfSize:(f)]
#define LXWS(weakSelf)  __weak __typeof(&*self)weakSelf = self
typedef void (^ButtonBlock)(UIButton *button);

@interface QukanLxButton : UIButton
@property(nonatomic,copy)ButtonBlock block;
@property(nonatomic,assign)NSInteger buttonID;

@property(nonatomic,assign)CGSize enlargeSize;

-(void)addClickBlock:(ButtonBlock)block;

+(QukanLxButton *)LXButtonWithTitle:(NSString *)title  titleFont:(UIFont *)titleLabelFont Image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleLabelColor frame:(CGRect)frame;

+(QukanLxButton *)LXButtonNoFrameWithTitle:(NSString *)title  titleFont:(UIFont *)titleLabelFont Image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleLabelColor;
@end
