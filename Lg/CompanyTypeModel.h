//
//  CompanyTypeModel.h
//  Lg
//
//  Created by echo21 on 15/9/26.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyTypeModel : NSObject
@property (nonatomic,assign) NSInteger company_type_id;
@property (nonatomic,strong) NSString *company_type_name;
@property (nonatomic,strong) NSString *company_type_ico;
@property (nonatomic,strong) NSString *company_type_url;
@property (nonatomic,strong) NSArray *add_company;
@property (nonatomic,strong) NSArray *small_company_type;
@property (nonatomic,assign) BOOL isOpen;
-(void)setCompanyTypeModel:(NSDictionary *)dic;
@end
