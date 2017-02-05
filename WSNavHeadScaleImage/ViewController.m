//
//  ViewController.m
//  WSNavHeadScaleImage
//
//  Created by SongLan on 2017/2/5.
//  Copyright © 2017年 SongLan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) UIImageView * headerImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self configUI];
}

- (void)configUI{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:_tableView];
   
    UIView *titleView = [[UIView alloc] init];
    self.navigationItem.titleView = titleView;
    _headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.jpg"]];
    _headerImageView.frame = CGRectMake(0, 0, 70, 70);
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = 35;
    _headerImageView.center = CGPointMake(titleView.center.x, 0);
    [titleView addSubview:_headerImageView];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.tableView]) {
        CGFloat offsetY = self.tableView.contentOffset.y + self.tableView.contentInset.top;
        CGFloat scale = 1.0;
        if (offsetY < 0) {// 放大
            // 允许下拉放大的最大距离为250
            scale = MIN(1.5, 1 - offsetY / 250);
        } else if (offsetY > 0) { // 缩小
            // 允许向上超过导航条缩小的最大距离为250
            scale = MAX(0.4, 1 - offsetY / 250);
        }
        self.headerImageView.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Asong教你如何缩放头像"];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
