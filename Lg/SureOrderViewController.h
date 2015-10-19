//
//  SureOrderViewController.h
//  Lg
//
//  Created by echo21 on 15/10/16.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "UserMpdel.h"
@interface SureOrderViewController : UIViewController
@property (nonatomic,strong) GoodsModel *good;
@property (nonatomic,strong) NSString *count;
@property (nonatomic,strong) UserMpdel *user;
@end
