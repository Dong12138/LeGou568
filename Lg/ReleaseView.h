//
//  ReleaseView.h
//  Lg
//
//  Created by echo21 on 15/10/13.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReleaseViewDelegate <NSObject>
-(void)callBack:(NSString *)str : (NSDictionary *)dic;
@end
@interface ReleaseView : UIView
@property (nonatomic,assign) int flag;
@property (nonatomic,strong) NSDictionary *fenleiDic;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) id<ReleaseViewDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame :  (int)f;
@end


