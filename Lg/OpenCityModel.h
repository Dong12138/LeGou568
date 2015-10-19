//
//  OpenCityModel.h
//  Lg
//
//  Created by echo21 on 15/9/26.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenCityModel : NSObject
@property (nonatomic,assign) NSInteger city_id;
@property (nonatomic,strong) NSString *city_name;
-(void)setOpenCityModel:(NSDictionary *)dic;
@end
