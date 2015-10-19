//
//  UpdateInfoViewController.h
//  Lg
//
//  Created by echo21 on 15/10/15.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UpdateInfoDelegate<NSObject>
-(void)callBack:(long)row : (NSString *)infoStr;
@end
@interface UpdateInfoViewController : UIViewController
@property (nonatomic,assign) long row;
@property (nonatomic,strong) NSString *str;
@property (nonatomic,assign) int flag;
@property (nonatomic,strong) id<UpdateInfoDelegate>delegeta;
@end
