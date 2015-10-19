//
//  GoodsTypeModel.m
//  Lg
//
//  Created by echo21 on 15/10/6.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "GoodsTypeModel.h"
#import "Add_goodsModel.h"
#import "ListgoodsModel.h"
@implementation GoodsTypeModel
-(void)setGoodsTypeValue:(NSDictionary *)dic{
    self.goods_type_id = dic[@"goods_type_id"];
    self.goods_type_name = dic[@"goods_type_name"];
    NSArray *arr = dic[@"add_goods"];
    NSMutableArray *muarr = [NSMutableArray array];
    for(NSDictionary *addDic in arr){
        Add_goodsModel *add_goods = [[Add_goodsModel alloc]init];
        [add_goods setAdd_goodsValue:addDic];
        [muarr addObject:add_goods];
    }
    self.add_goods = muarr;
    NSArray *arr1 = dic[@"listgoods"];
    NSMutableArray *muarr1 = [NSMutableArray array];
    for(NSDictionary *listDic in arr1){
        ListgoodsModel *list_goods = [[ListgoodsModel alloc]init];
        [list_goods setListgoodsValue:listDic];
        [muarr1 addObject:list_goods];
    }
    self.listgoods = muarr1;
}
@end
