//
//  GoodsTypeModel.h
//  Lg
//
//  Created by echo21 on 15/10/6.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsTypeModel : NSObject
@property (nonatomic,strong) NSString *goods_type_id;
@property (nonatomic,strong) NSString *goods_type_name;
@property (nonatomic,strong) NSArray *add_goods;
@property (nonatomic,strong) NSArray *listgoods;
-(void)setGoodsTypeValue:(NSDictionary *)dic;
@end
