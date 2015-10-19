//
//  CommentModel.m
//  Lg
//
//  Created by echo21 on 15/9/29.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
-(void)setCommentModelValue:(NSDictionary *)dic{
    self.comment_id = dic[@"comment_id"];
    self.user_id = dic[@"user_id"];
    self.company_id = dic[@"company_id"];
    self.comment_content = dic[@"comment_content"];
    self.comment_addtime = dic[@"comment_addtime"];
    self.user_name = dic[@"user_name"];
}
@end
