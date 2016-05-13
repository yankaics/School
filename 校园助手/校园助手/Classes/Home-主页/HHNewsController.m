//
//  HHNewsViewController.m
//  校园助手
//
//  Created by hjl on 16/5/13.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHNewsController.h"
#import "HHNewsView.h"
#import "HHNews.h"
@interface HHNewsController ()

@end

@implementation HHNewsController
- (instancetype)init{
    self = [super init];
    if (self) {
        // 隐藏这个页面的tabbar
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewScrollPositionNone;
    [self setupHeaderView];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    self.tableView.backgroundColor = HHBackgroundColor;
}

- (void)setupHeaderView {
    HHNewsView *headerView = [[NSBundle mainBundle] loadNibNamed:@"HHNewsView" owner:nil options:nil].lastObject;
    headerView.news = self.news;
    headerView.frame = CGRectMake(0, 0, HHWidth, self.news.cellHeight);
    headerView.backgroundColor = HHRGBColor(240, 240, 240, 1);
    
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    return cell;
}


@end
