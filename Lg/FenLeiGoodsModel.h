//
//  FenLeiGoodsModel.h
//  Lg
//
//  Created by echo21 on 15/10/8.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FenLeiGoodsModel : NSObject
@property (nonatomic,strong) NSString *goods_id;
@property (nonatomic,strong) NSString *goods_name;
@property (nonatomic,strong) NSString *goods_title;
@property (nonatomic,strong) NSString *goods_imgs;
@property (nonatomic,strong) NSString *goods_price;
@property (nonatomic,strong) NSString *goods_sales;
@property (nonatomic,strong) NSString *goods_addtime;
@property (nonatomic,strong) NSString *goods_link;
-(void)setFenLeiGoods:(NSDictionary *)dic;
@end
