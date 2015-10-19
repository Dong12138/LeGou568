//
//  Add_goodsModel.h
//  Lg
//
//  Created by echo21 on 15/10/6.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Add_goodsModel : NSObject
@property (nonatomic,strong) NSString *goods_id;
@property (nonatomic,strong) NSString *goods_name;
@property (nonatomic,strong) NSString *goods_ad;
@property (nonatomic,strong) NSString *goods_url;
-(void)setAdd_goodsValue:(NSDictionary *)dic;
@end
