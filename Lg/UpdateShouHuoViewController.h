//
//  UpdateShouHuoViewController.h
//  Lg
//
//  Created by echo21 on 15/10/17.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UpdateShouHuoDelegate<NSObject>
-(void)callback:(NSDictionary *)dic;
@end
@interface UpdateShouHuoViewController : UIViewController
@property(nonatomic,strong) NSDictionary *dic;
@property(nonatomic,strong) id<UpdateShouHuoDelegate>delegate;
@end
