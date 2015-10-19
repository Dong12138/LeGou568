//
//  ListgoodsModel.h
//  Lg
//
//  Created by echo21 on 15/10/6.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListgoodsModel : NSObject
@property (nonatomic,strong) NSString *goods_id;
@property (nonatomic,strong) NSString *goods_name;
@property (nonatomic,strong) NSString *goods_imgs;
@property (nonatomic,strong) NSString *goods_url;
-(void)setListgoodsValue:(NSDictionary *)dic;
@end
