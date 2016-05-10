//
//  HHActivityController.m
//  校园助手
//
//  Created by hjl on 16/5/8.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHActivityController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "HHActivityCell.h"
#import "HHActivity.h"
@interface HHActivityController ()

@end

@implementation HHActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupFooterView];
}

- (void)setupTableView {
    self.view.backgroundColor = HHBackgroundColor;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HHActivityCell" bundle:nil] forCellReuseIdentifier:@"HHActivityCell"];
    self.tableView.rowHeight = 180;
}

- (void)setupFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, HHWidth, self.activity.cellHeight + 20)];
    footerView.backgroundColor = HHRGBColor(250, 250, 250, 1);
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, HHWidth - 20, self.activity.cellHeight)];
    bottomView.backgroundColor = HHRGBColor(240, 240, 240, 1);
    [footerView addSubview:bottomView];
    
    UILabel *contnetLabel = [[UILabel alloc] init];
    contnetLabel.frame = CGRectMake(10, 0, HHWidth - 40, self.activity.cellHeight);
    contnetLabel.font = [UIFont systemFontOfSize:14];
    contnetLabel.text = self.activity.content;
    contnetLabel.numberOfLines = 0;
    //contnetLabel.backgroundColor = HHBackgroundColor;
    [bottomView addSubview:contnetLabel];
    self.tableView.tableFooterView = footerView;
    //self.tableView.tableFooterView.backgroundColor = [UIColor redColor];
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHActivityCell"];
    cell.activity = self.activity;
    return cell;
}

@end
