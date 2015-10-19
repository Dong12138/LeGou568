//
//  ProductModel.h
//  Lg
//
//  Created by echo21 on 15/9/29.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
/**
 *产品id
 */
@property (nonatomic,strong) NSString *company_pro_id;
/**
 *产品图片路径
 */
@property (nonatomic,strong) NSString *company_pro_imgsrc;
/**
 *产品名称
 */
@property (nonatomic,strong) NSString *company_pro_title;
/**
 *产品内容
 */
@property (nonatomic,strong) NSString *company_pro_content;
/**
 *产品备注
 */
@property (nonatomic,strong) NSString *company_pro_remarks;
/**
 *所属公司id
 */
@property (nonatomic,strong) NSString *company_id;
/**
 *产品排序
 */
@property (nonatomic,strong) NSString *company_pro_listorder;
-(void)setProductModelValue:(NSDictionary *)dic;
@end
