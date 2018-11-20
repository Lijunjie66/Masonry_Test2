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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutSubviews];
    
}


- (void)layoutSubviews {
    
    // 设置内边距
    /**
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
        更新约束
     */
    // 设置greenView的center和size，
    
    
    
    
}


@end
