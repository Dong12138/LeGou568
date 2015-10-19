//
//  ZhifuAndPeisongView.m
//  Lg
//
//  Created by echo21 on 15/10/17.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "ZhifuAndPeisongView.h"


@interface ZhifuAndPeisongView ()
@property (nonatomic,strong) NSArray *butArr;
@end

@implementation ZhifuAndPeisongView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame : (NSArray *)arr{
    self = [super initWithFrame:frame];
    if (self) {
        _butArr = arr;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addViewContent];
    }
    return self;
}
-(void)addViewContent{
    UIView *butView = [[UIView alloc]initWithFrame:CGRectMake((([UIScreen mainScreen].bounds.size.width-250)/2.0), ([UIScreen mainScreen].bounds.size.height- 30*_butArr.count)/2.0, 250, 30*_butArr.count)];
    butView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i<_butArr.count; i++) {
        NSDictionary *dic = _butArr[i];
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(0, 30*i, butView.frame.size.width, 30);
        [but setTitleColor:[UIColor colorWithRed:221/255.0 green:160/255.0 blue:221/255.0 alpha:1.0] forState:UIControlStateNormal];
        but.font = [UIFont systemFontOfSize:14.0];
        but.tag = 2000+i;
        [but setTitle:dic[@"content"] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        [butView addSubview:but];
    }
    [self addSubview:butView];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   // NSLog(@"aaaaa");
    [self removeFromSuperview];
}
-(void)butClick:(UIButton *)but{
    if ([_delegate respondsToSelector:@selector(callBack:)]) {
        [_delegate callBack:but.tag];
    }
    [self removeFromSuperview];
}
@end
