//
//  PlateNumEnteringController.m
//  CarltSAS
//
//  Created by Neely on 2019/4/12.
//  Copyright © 2019 万匿里. All rights reserved.
//

#import "PlateNumEnteringController.h"
#import "RZCarPlateNoTextField.h"
#import "UIView+cornerBorder.h"
#import <Masonry/Masonry.h>
#import "UIColor+Extend.h"
#import "MyControl.h"

@interface PlateNumEnteringController ()
{
    UIView *bgView;
    RZCarPlateNoTextField *yjtextfield;
}
@property(nonatomic,assign)NSInteger length;
@property(nonatomic,strong)UILabel *currentLab;
@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)UIButton *downBtn;
@property(nonatomic,strong)UIButton *swichBtn;


@end

@implementation PlateNumEnteringController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"车牌号";

    UILabel *leftTitleLab = [[UILabel alloc]init];
    leftTitleLab.text = @"车牌号";
    leftTitleLab.textColor = [UIColor ColorWithHexString:@"#666666"];
    leftTitleLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:leftTitleLab];
    [leftTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(70);
    }];
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setImage:[UIImage imageNamed:@"cirlcle_select"] forState:UIControlStateSelected];
    [selectBtn setImage:[UIImage imageNamed:@"circle_normal"] forState:UIControlStateNormal];
    [selectBtn setTitleColor:[UIColor ColorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [selectBtn setTitle:@"新能源" forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(setOnClick:) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.swichBtn = selectBtn;
    [self.view addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view).offset(60);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    self.length = 7;
    self.index = 0;
    yjtextfield.rz_maxLength = self.length;
    [self makeUI];

    [self updataUI];
    [self configData];
}


- (void)makeUI {
    
    yjtextfield = [[RZCarPlateNoTextField alloc] initWithFrame:CGRectMake(10, 100, 300, 50)];
    yjtextfield.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    yjtextfield.hidden = YES;
    yjtextfield.rz_maxLength = self.length;  // 最大输入长度 （0 不限制）
    yjtextfield.rz_checkCarPlateNoValue = YES;  // 是否需要校验车牌号输入规则
    
    __weak typeof(self)weakSelf = self;
    yjtextfield.rz_regexPlateNoIfYouNeed = ^NSString * _Nonnull(NSString * _Nonnull text) {
        // 你的校验方法,
        NSLog(@"-----%@",text);
        if([weakSelf regText:text]){
            return text;
        }else{
            NSLog(@"输入不合法");
            return [text substringToIndex:text.length-1];
        }
    };
    yjtextfield.rz_textFieldEditingValueChanged = ^(RZCarPlateNoTextField * _Nonnull textField) {
        NSLog(@"输入变化回调：%@", textField.text);
        if(textField.text.length==0){
            [textField rz_changeKeyBoard:YES];
        }else{
            [textField rz_changeKeyBoard:NO];
        }
        
        [weakSelf configData];
        if(textField.text.length==weakSelf.length){
            [weakSelf fullPlateNumber:textField.text];
//            [weakSelf.view endEditing:YES];
        }
    };
    [yjtextfield rz_changeKeyBoard:YES]; // 代码控制显示字母 （YES：省份）
    [self.view addSubview:yjtextfield];
//    [yjtextfield becomeFirstResponder];
    
    
    UIButton *btn = [MyControl createButtonWithFrame:CGRectZero ImageName:nil Target:self Action:@selector(pressDown) Title:@"保存"];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(20);
        make.right.equalTo(self.view).mas_offset(-20);
        make.top.equalTo(self.view).mas_offset(200);
        make.height.mas_equalTo(45);
    }];
    BorderRadius(btn, 5, 0, [UIColor clearColor]);
    self.downBtn = btn;
    
}

- (void)pressDown{
    
   
}

#pragma mark-------------------输入完成-----------------------
-(void)fullPlateNumber:(NSString *)plateNumber{
    NSLog(@"%@",plateNumber);
}


-(void)setOnClick:(UIButton *)sender {
    
    if (yjtextfield.text.length) {
        NSLog(@"删除当前车牌号，方可切换");
        return;
    }
    
    sender.selected = !sender.selected;
    self.length = sender.selected ? 8:7;

    for(UIView *subView in bgView.subviews){
        [subView removeFromSuperview];
    }
    yjtextfield.rz_maxLength = self.length;
    [self updataUI];
}


#pragma mark --- InputViewDelegate

- (void)configData{
    //清楚数据
    for(int i=0;i<self.length;i++){
        UIButton *btn = [bgView viewWithTag:100+i];
        if(i<yjtextfield.text.length){
            NSString *txt = [yjtextfield.text substringWithRange:NSMakeRange(i, 1)];
            [btn setTitle:txt forState:UIControlStateNormal];
        }else{
            [btn setTitle:@"" forState:UIControlStateNormal];
        }
    }
    
    //重新赋值
    for(int i=0;i<yjtextfield.text.length;i++){
        UIButton *btn = [bgView viewWithTag:100+i];
        NSString *txt = [yjtextfield.text substringWithRange:NSMakeRange(i, 1)];
        [btn setTitle:txt forState:UIControlStateNormal];
    }
    
    //改变蓝色位置
    if(yjtextfield.text.length==self.length){
        UIButton *btn = [bgView viewWithTag:100+self.length-1];
        [self pressItem:btn];
    }else{
        UIButton *btn = [bgView viewWithTag:100+yjtextfield.text.length];
        [self pressItem:btn];
    }
}

- (void)updataUI {
    
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    float itemWidth = (screenWidth-40)/self.length;
    if(bgView==nil){
        bgView = [[UIView alloc]initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, itemWidth)];
        bgView.layer.borderWidth = 1;
        bgView.layer.borderColor = [UIColor ColorWithHexString:@"#e1e4e6"].CGColor;
        bgView.layer.cornerRadius = 10;
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
    }
    bgView.frame = CGRectMake(20, 100, self.view.frame.size.width-40, itemWidth);
   
    for(int i=0;i<self.length;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(itemWidth * i, 0, itemWidth, itemWidth);
        [btn addTarget:self action:@selector(pressItemT) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [bgView addSubview:btn];
        
        UILabel *LineLab = [[UILabel alloc]initWithFrame:CGRectMake(itemWidth-1, 15, 1, itemWidth-30)];
        LineLab.backgroundColor = [UIColor ColorWithHexString:@"e1e4e6"];
        [btn addSubview:LineLab];
        
        if(i==1){
            LineLab.frame = CGRectMake(itemWidth-4, itemWidth/2-2, 4, 4);
            LineLab.layer.cornerRadius = 2;
            LineLab.layer.masksToBounds = YES;
        }
    }
    
    if(_currentLab==nil){
        self.currentLab = [[UILabel alloc]init];
        self.currentLab.layer.borderWidth = 2;
        self.currentLab.layer.borderColor = [UIColor ColorWithHexString:@"#3f9bf6"].CGColor;
        self.currentLab.layer.cornerRadius = 5;
        self.currentLab.layer.masksToBounds = YES;
    }
    self.currentLab.frame = CGRectMake(self.index * itemWidth + 2, 2, itemWidth-4, itemWidth-4);
    [bgView addSubview:self.currentLab];
    
}
- (void)pressItem:(UIButton *)btn {
    [yjtextfield becomeFirstResponder];
    if(btn.tag-100 > yjtextfield.text.length){
        return;
    }
    
    self.currentLab.frame = CGRectMake(btn.frame.origin.x + 2, 2, self.currentLab.frame.size.width, self.currentLab.frame.size.height);
    self.index = btn.tag-100;
}
-(void)pressItemT{
    [yjtextfield becomeFirstResponder];
}


-(BOOL)regText:(NSString *)text {
    // //普通汽车，7位字符，不包含I和O，避免与数字1和0混淆
    // NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[a-hj-np-zA-HJ-NP-Z0-9]{4}[a-hj-np-zA-HJ-NP-Z0-9\u4e00-\u9fa5]$";
    BOOL resbool = YES;
    NSString *carRegex=@"";
    if(self.length==7){
        switch (text.length) {
            case 1:
                carRegex = @"^[\u4e00-\u9fa5]{1}$";
                break;
            case 2:
                carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}$";
                break;
            case 3:
                carRegex = @"[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[a-hj-np-zA-HJ-NP-Z0-9]{1}$";
                
                break;
            case 4:
                carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[a-hj-np-zA-HJ-NP-Z0-9]{2}$";
                break;
            case 5:
                carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[a-hj-np-zA-HJ-NP-Z0-9]{3}$";
                break;
            case 6:
                carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[a-hj-np-zA-HJ-NP-Z0-9]{4}$";
                break;
            case 7:
                carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[a-hj-np-zA-HJ-NP-Z0-9]{4}[a-hj-np-zA-HJ-NP-Z0-9\u4e00-\u9fa5]$";
                break;
                
            default:
                break;
        }
    }else if(self.length==8){
        //新能源车,8位字符，第一位：省份简称（1位汉字），第二位：发牌机关代号（1位字母）;
        //小型车，第三位：只能用字母D或字母F，第四位：字母或者数字，后四位：必须使用数字;([DF][A-HJ-NP-Z0-9][0-9]{4})
        //大型车3-7位：必须使用数字，后一位：只能用字母D或字母F。([0-9]{5}[DF])
        //        NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}([0-9]{5}[d|f|D|F]|[d|f|D|F][a-hj-np-zA-HJ-NP-Z0-9][0-9]{4})$";
        switch (text.length) {
            case 1:
                carRegex = @"^[\u4e00-\u9fa5]{1}$";
                break;
            case 2:
                carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}$";
                break;
            case 3:
                carRegex = @"[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[DF]{1}$";
                
                break;
            case 4:
                carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[DF]{1}[A-HJ-NP-Z0-9]{1}$";
                break;
            case 5:
                carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[DF]{1}[A-HJ-NP-Z0-9]{2}$";
                break;
            case 6:
                carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[DF]{1}[A-HJ-NP-Z0-9]{3}$";
                break;
            case 7:
                carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[DF]{1}[A-HJ-NP-Z0-9]{4}$";
                break;
            case 8:
                carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[DF]{1}[A-HJ-NP-Z0-9]{5}$";
                break;
            default:
                break;
        }
    }
    
    
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    resbool = [carTest evaluateWithObject:text];
    
    if(resbool==NO){
        NSLog(@"请输入合法的车牌信息");
    }
    
    return resbool;
}


@end
