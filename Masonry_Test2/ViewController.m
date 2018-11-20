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
@property (nonatomic, strong) UIView *redView;

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
    
    
    /*
      4、 如果想使用基础数据类型当做参数，Masonry为我们提供了“mas_XXX”格式的宏定义
          这些宏定义会将传入的基础数据类型转换为NSNumber类型，这个过程叫做封箱。
     
          “mas_XXX”开头的宏定义，内部都是通过MASBoxValue()函数实现的
          这样的宏定义主要有四个：mas_equalTo()、mas_offset()、大于等于、小于等于
     **/
    self.redView = [[UIView alloc] init];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    
    /*
        5、 设置约束优先级
     Masonry为我们提供了三个默认的方法，priorityLow()、priorityMedium()、priorityHigh(),这三个方法内部对应着不同的默认优先级
     除了这三个方法，我们还可以自己设置优先级的值，可以通过priority()方法来设置
     **/
//    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.width.equalTo(self.view).priorityLow();
//        make.width.mas_equalTo(20).priorityHigh();
//        make.height.equalTo(self.view).priority(200);
//        make.height.mas_equalTo(100).priority(1000);
//    }];

    // 设置约束比例
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(30);
#pragma mark --☆☆☆  设置当前的约束乘以多少，例如下面这份例子： redView的宽度是self.view宽度的0.2倍
        make.width.equalTo(self.view).multipliedBy(0.2); // ☆☆☆ redView的宽度是self.view宽度的0.2倍 ☆☆☆
    }];
    
}


@end
