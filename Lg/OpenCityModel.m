//
//  OpenCityModel.m
//  Lg
//
//  Created by echo21 on 15/9/26.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "OpenCityModel.h"

@implementation OpenCityModel
-(void)setOpenCityModel:(NSDictionary *)dic{
    self.city_id = [dic[@"city_id"] integerValue];
    self.city_name = dic[@"city_name"];
}
@end
