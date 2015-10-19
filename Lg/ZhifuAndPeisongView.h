//
//  ZhifuAndPeisongView.h
//  Lg
//
//  Created by echo21 on 15/10/17.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZhifuAndPeisongDelegate<NSObject>
-(void)callBack:(long)tag;
@end
@interface ZhifuAndPeisongView : UIView
@property (nonatomic,strong) id<ZhifuAndPeisongDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame : (NSArray *)arr;
@end
