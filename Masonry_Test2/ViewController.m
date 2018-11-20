//
//  ViewController.m
//  Masonry_Test2
//
//  Created by Geraint on 2018/11/20.
//  Copyright © 2018 kilolumen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *yellowView;
@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIView *greenView;

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutSubviews];
    
}


- (void)layoutSubviews {
    
    // 设置内边距
    /** 1、
        设置yellow视图和self.view等大，并且有10的内边距
        注意，根据UIView的坐标系，下面的right和bottom进行了取反，
     */
    self.yellowView = [[UIView alloc] init];
    self.yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.yellowView];        // 先事先添加到view，再布局
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-10);
    }];
    
    
    // 也可以简化，通过使用insert，区别在于使用inserts()方法中的下、右不需要写负号，inserts方法中已经为我们做了取反非操作了
    self.blueView = [[UIView alloc] init];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.yellowView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
    
    /*
        2、 更新约束
     */
    // 设置greenView的center和size，
    self.greenView = [[UIView alloc] init];
    self.greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.greenView];
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));     // 这里通过mas_equalTo给size设置了基础数据类型的参数，参数为CGSize的结构体
    }];
    
    
    // 为了更清楚的看出约束变化的效果，在显示两秒后更新结束
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 指定更新size，其他约束不变
        [self.greenView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    });
    
    /**
        3、 大小等于 和 小于等于 某个值的约束
     */
    self.textLabel = [[UILabel alloc] init];
//    self.textLabel.text = @"哈哈😆";
//    self.textLable.textColor = [UIColor blackColor];    // 默认黑色
//    self.textLable.font = [UIFont systemFontOfSize:15]; // 默认有高度
    [self.view addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        // 设置宽度小于等于200
        make.width.lessThanOrEqualTo(@200);
        // 设置高度大于等于10
        make.height.greaterThanOrEqualTo(@10);
    }];
    
    self.textLabel.text = @"蓝光的能量较高，会对眼睛的视网膜色素上皮细胞造成伤害，包括细胞的衰老，死亡，严重的会导致失明。\n并且,\r随着年龄增加对蓝光损伤更加敏感，也会导致老年性黄斑病变。";
    self.textLabel.numberOfLines = 0; // 行数 自适应（默认为1单行，设置为0，自适应）
    
    
}


@end
