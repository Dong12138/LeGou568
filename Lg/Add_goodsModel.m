//
//  Add_goodsModel.m
//  Lg
//
//  Created by echo21 on 15/10/6.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "Add_goodsModel.h"

@implementation Add_goodsModel
-(void)setAdd_goodsValue:(NSDictionary *)dic{
    self.goods_ad = dic[@"goods_ad"];
    self.goods_id = dic[@"goods_id"];
    self.goods_name = dic[@"goods_name"];
    self.goods_url = dic[@"goods_url"];
}
@end
