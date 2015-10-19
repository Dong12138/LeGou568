//
//  ListgoodsModel.m
//  Lg
//
//  Created by echo21 on 15/10/6.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "ListgoodsModel.h"

@implementation ListgoodsModel
-(void)setListgoodsValue:(NSDictionary *)dic{
    self.goods_id = dic[@"goods_id"];
    self.goods_imgs = dic[@"goods_imgs"];
    self.goods_name = dic[@"goods_name"];
    self.goods_url = dic[@"goods_url"];
}
@end
