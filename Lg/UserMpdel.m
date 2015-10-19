//
//  UserMpdel.m
//  Lg
//
//  Created by echo21 on 15/10/6.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "UserMpdel.h"

@implementation UserMpdel
-(void)setUserValue:(NSDictionary *)dic{
    self.status = dic[@""];
    self.userinfo = dic[@"userinfo"];
    self.content = dic[@"content"];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.userinfo = [aDecoder decodeObjectForKey:@"userinfo"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.userinfo forKey:@"userinfo"];
    [aCoder encodeObject:self.content forKey:@"content"];
}

@end
