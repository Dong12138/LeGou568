//
//  FenLeiGoodsModel.m
//  Lg
//
//  Created by echo21 on 15/10/8.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "FenLeiGoodsModel.h"

@implementation FenLeiGoodsModel
-(void)setFenLeiGoods:(NSDictionary *)dic{
    self.goods_id = dic[@"goods_id"];
    self.goods_name = dic[@"goods_name"];
    self.goods_title = dic[@"goods_title"];
    self.goods_imgs = dic[@"goods_imgs"];
    self.goods_price = dic[@"goods_price"];
    self.goods_sales = dic[@"goods_sales"];
    self.goods_addtime = dic[@"goods_addtime"];
    self.goods_link = dic[@"goods_link"];
}
@end
