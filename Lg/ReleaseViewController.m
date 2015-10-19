//
//  ReleaseViewController.m
//  Lg
//
//  Created by echo21 on 15/10/12.
//  Copyright © 2015年 echo21. All rights reserved.
//

#import "ReleaseViewController.h"
#import "ReleaseView.h"
#import "FuLiViewController.h"
@interface ReleaseViewController ()<ReleaseViewDelegate,FuliDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) ReleaseView *releaseView;
@property (nonatomic,strong) NSDictionary *paramDic;
//福利数组
@property (nonatomic,strong) NSArray *fuliArr;
//分类字符串
@property (nonatomic,strong) NSString *fenleiStr;
//图片数组
@property (nonatomic,strong) NSMutableArray *picArr;
@end

@implementation ReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _picArr = [NSMutableArray array];
    _tableview.tableFooterView = [[UIView alloc]init];
    _arr = @[@"分类",@"标题",@"职位",@"招聘人数",@"薪资",@"福利",@"公司名称",@"公司地址",@"公司简介",@"联系人",@"手机号"];
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dicc = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes=dicc;
    
    self.title = @"招聘信息发布";
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton setFont:[UIFont systemFontOfSize:15.0]];
    [okButton addTarget:self action:@selector(okButClick:) forControlEvents:UIControlEventTouchUpInside];
    okButton.frame = CGRectMake(0, 0, 40, 30);
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:okButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    // Do any additional setup after loading the view.
}
//提交发布信息 点击事件
-(void)okButClick:(UIButton *)but{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//选择照片点击事件
- (IBAction)selecetedButClick:(UIButton *)sender {
    UIActionSheet *sheet = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet = [[UIActionSheet alloc]initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"选择照片" otherButtonTitles:@"拍照", nil];
    }else{
        sheet = [[UIActionSheet alloc]initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"选择照片" otherButtonTitles:nil, nil];
    }
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc]init];
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"选择照片"]) {
        imgPicker.sourceType = 0;
        imgPicker.delegate = self;
        [self presentViewController:imgPicker animated:YES completion:^{
            
            
        }];
    }else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"拍照"]){
        imgPicker.sourceType = 1;
        imgPicker.delegate = self;
        [self presentViewController:imgPicker animated:YES completion:^{
            
            
        }];
    }else{
        return;
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    [_picArr addObject:img];
    [self dismissViewControllerAnimated:YES completion:^{
        [_tableview reloadData];
    }];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark TableView_代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        UILabel *label = (UILabel *)[cell viewWithTag:2000];
        if (_fenleiStr.length!=0) {
            label.text = _fenleiStr;
        }else{
            label.text = _arr[indexPath.row];
        }
        
        UIButton *button = (UIButton *)[cell viewWithTag:2001];
        [button addTarget:self action:@selector(fenleiButClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell ;
    }
    if (indexPath.row == 1||indexPath.row == 2||indexPath.row == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secCell" forIndexPath:indexPath];
        UITextField *tf = (UITextField *)[cell viewWithTag:2000];
        tf.placeholder = _arr[indexPath.row];
        return cell;
    }
    if (indexPath.row == 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thirdCell" forIndexPath:indexPath];
        UITextField *tf = (UITextField *)[cell viewWithTag:2000];
        tf.placeholder = _arr[indexPath.row];
        return cell;
        
    }
    if (indexPath.row == 5) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        UILabel *label = (UILabel *)[cell viewWithTag:2000];
        label.text = _arr[indexPath.row];
        UIButton *button = (UIButton *)[cell viewWithTag:2001];
        [button addTarget:self action:@selector(fuliButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        for(UIView *vv in cell.subviews){
            if (vv.tag == 4000) {
                [vv removeFromSuperview];
            }
        }
        if (_fuliArr.count>0) {
            //NSArray *arr = _content.info_job_weal_new;
            NSInteger i = _fuliArr.count%3 == 0 ? _fuliArr.count/3 : _fuliArr.count/3+1;
            for (int j = 0; j < i; j++) {
                NSInteger m = 3;
                if (j == i-1) {
                    m = _fuliArr.count%3 == 0 ? 3:_fuliArr.count%3;
                }
                for (int n = 0; n<m; n++) {
                    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(10+n*(WIDTH-20)/3, j*30+50, (WIDTH-20)/3, 30)];
                    v.tag = 4000;
                    // v.backgroundColor = [UIColor purpleColor];
                    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,10,10,10)];
                    imgView.image = [UIImage imageNamed:@"star.png"];
                    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 30)];
                    // NSDictionary *dic = _fuliArr[j*3+n];
                    label.numberOfLines = 0;
                    label.text = _fuliArr[j*3+n];
                    label.font = [UIFont systemFontOfSize:14.0];
                    [v addSubview:imgView];
                    [v addSubview:label];
                    [cell addSubview:v];
                }
            }
            
        }
        return cell ;
    }if (indexPath.row == 6||indexPath.row == 7||indexPath.row == 8||indexPath.row == 9||indexPath.row == 10) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secCell" forIndexPath:indexPath];
        UITextField *tf = (UITextField *)[cell viewWithTag:2000];
        tf.placeholder = _arr[indexPath.row];
        if (indexPath.row == 10) {
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picCell" forIndexPath:indexPath];
        for(UIImageView *vv in cell.subviews){
            if (vv.tag == 5000) {
                [vv removeFromSuperview];
            }
        }
        if (_picArr.count!=0) {
            
            
            
            NSInteger i = _picArr.count%3 == 0 ? _picArr.count/3 : _picArr.count/3+1;
            for (int j = 0; j < i; j++) {
                NSInteger m = 3;
                if (j == i-1) {
                    m = _picArr.count%3 == 0 ? 3:_picArr.count%3;
                }
                for (int n = 0; n<m; n++) {
                    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10+n*(WIDTH-40)/3+(10*n), j*70+60, (WIDTH-40)/3, 60)];
                    imgView.image = _picArr[j*3+n];
                    imgView.tag = 5000;
                    [cell addSubview:imgView];
                }
            }
        }
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 11) {
        if (_picArr.count>0) {
            NSInteger i = _picArr.count%3 == 0 ? _picArr.count/3 : _picArr.count/3+1;
            //return CGSizeMake(WIDTH, i*30+20);
            return i*60+70;
        }

        return 70;
    }
    if (indexPath.row == 5) {
        if (_fuliArr.count>0) {
            NSInteger i = _fuliArr.count%3 == 0 ? _fuliArr.count/3 : _fuliArr.count/3+1;
            //return CGSizeMake(WIDTH, i*30+20);
            return i*30+50;
        }
        return 40;
    }
    else{
        return 40;
    }
}
-(void)fenleiButClick:(UIButton *)but{
    if (!_releaseView) {
        //        UIWindow *window = [[UIApplication sharedApplication]keyWindow];
        _releaseView = [[ReleaseView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT):_flag];
        _releaseView.delegate = self;
        [_releaseView.tableview reloadData];
        [self.view addSubview:_releaseView];
    }
    if (_releaseView.hidden) {
        _releaseView.hidden = NO;
    }
}
-(void)fuliButtonClick:(UIButton *)but{
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];;
    UILabel *label = (UILabel *)[cell viewWithTag:2000];
    if ([label.text isEqualToString:@"分类"]) {
        [FVCustomAlertView showDefaultWarningAlertOnView:self.view withTitle:@"请先选择分类"];
    }else{
        FuLiViewController *fuliVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FuLiViewController"];
        fuliVC.dic = _paramDic;
        fuliVC.delegete = self;
        [self.navigationController pushViewController:fuliVC animated:YES];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _releaseView.hidden = YES;
}
//分类 代理
-(void)callBack:(NSString *)str : (NSDictionary *)dic{
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];;
    UILabel *label = (UILabel *)[cell viewWithTag:2000];
    _fenleiStr = str;
    label.text = str;
    _paramDic = dic;
}
//福利  代理
-(void)callBack:(NSArray *)arr{
    _fuliArr = arr;
    [_tableview reloadData];
}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"sssssss");
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        if (!_releaseView) {
//            _releaseView = [[ReleaseView alloc]initWithFrame:self.view.frame :_flag];
//            [self.view addSubview:_releaseView];
//        }
//        if (_releaseView.hidden) {
//            _releaseView.hidden = NO;
//        }
//
//
//    }
//}
@end
