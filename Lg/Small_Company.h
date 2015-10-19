//
//  Small_Company.h
//  Lg
//
//  Created by echo21 on 15/9/26.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Small_Company : NSObject
@property (nonatomic,strong) NSString *company_type_ico;
@property (nonatomic,assign) NSInteger company_type_id;
@property (nonatomic,strong) NSString *company_type_name;
@property (nonatomic,strong) NSArray *company;
-(void)setSmallCompanyValue:(NSDictionary *)dic;
@end
