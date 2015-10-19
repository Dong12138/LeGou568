//
//  Small_Company.m
//  Lg
//
//  Created by echo21 on 15/9/26.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "Small_Company.h"

@implementation Small_Company
-(void)setSmallCompanyValue:(NSDictionary *)dic{
    self.company_type_id = [dic[@"company_type_id"] integerValue];
    self.company_type_name = dic[@"company_type_name"];
    self.company_type_ico = dic[@"company_type_ico"];
    self.company = dic[@"company"];
}
@end
