//
//  FuLiViewController.h
//  Lg
//
//  Created by echo21 on 15/10/13.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FuliDelegate<NSObject>
-(void)callBack:(NSArray *)arr;
@end

@interface FuLiViewController : UIViewController
@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic,strong) id<FuliDelegate>delegete;
@end
