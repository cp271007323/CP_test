//
//  CPTableView.m
//  绘制-tableView
//
//  Created by lk06 on 17/1/13.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "CPPromptBoxView.h" 

@interface CPPromptBoxView ()<CPPromptBoxDelegate,CAAnimationDelegate>
@property (nonatomic , copy) CPPromptBoxCancleBlock cancleBlock;
@property (nonatomic , strong) CPPromptBox          *promitBox;
@property (nonatomic , strong) UIView               *backView;
@property (nonatomic , strong) NSMutableArray       *blocks;
@property (nonatomic , strong) NSMutableArray       *Arr;
@property (nonatomic , assign) BOOL                 isShowAnimation;
@end

@implementation CPPromptBoxView
#pragma mark - 实例方法
+(instancetype)promptBoxViewWithOption:(CPPromptBoxOption *)option{
    return [[self alloc] initWithOption:option];
}

- (instancetype)initWithOption:(CPPromptBoxOption *)option
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self addSubview:self.backView];
        self.backView.backgroundColor = option.coverViewBackgroundColor;
        self.promitBox = [CPPromptBox promtBoxWithOption:option];
        self.isShowAnimation = option.isShowAnimation;
        self.promitBox.promitBoxDeleget = self;
        [self addSubview:self.promitBox];
        self.backView.alpha = 0;
    }
    return self;
}


- (void)showPrompt{
        [[UIApplication sharedApplication].delegate.window addSubview:self];
    if (self.isShowAnimation) {
        [UIView animateWithDuration:0.25 animations:^{
            self.backView.alpha = 1;
        }];
    }else{
        self.backView.alpha = 1;
    }
}

#pragma mark - 添加内容
- (void)addTitles:(NSArray *)titles
           images:(NSArray *)images
      didSelector:(CPPromptBoxClipBlock)block
   cancleSelector:(CPPromptBoxCancleBlock)cancle{
    self.promitBox.titles = (NSMutableArray *)titles;
    self.promitBox.images = (NSMutableArray *)images;
    self.promitBox.block = block;
    self.cancleBlock = cancle;
    [self.promitBox refreshPromitBoxView];
}


#pragma mark - CPPromptBoxDelegate
-(void)promptBoxSelector:(CPPromptBoxClipBlock)clipblock indexPath:(NSIndexPath *)indexPath{
    if (clipblock) {
        clipblock(indexPath);
        [self promitBoxViewRemoveFromSuperview];
    }
}

-(void)tap:(UITapGestureRecognizer *)tap{
    [self.promitBox promitBoxRemoveFromSuperViewWithValues:CPPBAnimation_disappear isDelegate:YES];
    [self doCancleBlock];
    [self promitBoxViewRemoveFromSuperview];
}

#pragma mark - CAAnimationDelegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self promitBoxViewRemoveFromSuperview];
}

//移除全部视图
-(void)promitBoxViewRemoveFromSuperview{
    if (self.isShowAnimation) {
        [UIView animateWithDuration:.3 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self.backView removeFromSuperview];
            [self removeFromSuperview];
        }];
    }else{
        self.alpha = 0;
        [self.backView removeFromSuperview];
        [self removeFromSuperview];
    }
}

//执行取消代理
-(void)doCancleBlock{
    if (self.cancleBlock) {
        self.cancleBlock();
    }
}


#pragma mark - get
-(UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:self.bounds];
        [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    }
    return _backView;
}


@end
 

@implementation UITableViewCell (CPPromptBoxIdentifier)
+(NSString *)identifier{
    return @"identifier_";
}
@end
