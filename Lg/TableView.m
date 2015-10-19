//
//  TableView.m
//  Lg
//
//  Created by echo21 on 15/10/9.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "TableView.h"
@interface TableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation TableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor clearColor];
        
//        //点击
//        //初始化点击手势对象
//            UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabClick:)];
//            //设置点击的次数
//            tapGR.numberOfTapsRequired = 1;
//            //设置点击的手指数(30*_listType.count)
//            tapGR.numberOfTouchesRequired = 1;
//            [self addGestureRecognizer:tapGR];
        
        
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(((frame.size.width-8)/4.0*3), 0, (frame.size.width-4)/4.0,100)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 30;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//设置分割线的样式
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//        self.backgroundColor = [UIColor clearColor];
        [self addSubview:_tableView];
    }
    return self;
}
-(void)tabClick:(UITapGestureRecognizer *)tap{
    //self.center = CGPointMake(self.frame.size.width/2.0, -(self.frame.size.height/2.0-50));
    self.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //tableView.frame =
    return self.listType.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *dic = self.listType[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text =  dic[@"goods_type_name"];
    UILabel *label = [[UILabel alloc]initWithFrame:cell.frame];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidden = YES;
    NSDictionary *dic = self.listType[indexPath.row];
    NSString *url = dic[@"good_type_link"];
    if ([_delegate respondsToSelector:@selector(reloadCollectionView:)]) {
        NSString *roomName = dic[@"good_type_link"];
        [_delegate reloadCollectionView:roomName];
    }
}
@end
