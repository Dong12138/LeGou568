//
//  ProductModel.m
//  Lg
//
//  Created by echo21 on 15/9/29.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel
-(void)setProductModelValue:(NSDictionary *)dic{
    self.company_pro_id= dic[@"company_pro_id"];
    self.company_pro_imgsrc= dic[@"company_pro_imgsrc"];
    self.company_pro_title= dic[@"company_pro_title"];
    self.company_pro_content= dic[@"company_pro_content"];
    self.company_pro_remarks= dic[@"company_pro_remarks"];
    self.company_id= dic[@"company_id"];
    self.company_pro_listorder= dic[@"company_pro_listorder"];
    
}
@end
