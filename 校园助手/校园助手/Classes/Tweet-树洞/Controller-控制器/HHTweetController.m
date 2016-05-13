//
//  HHTweetController.m
//  图书馆
//
//  Created by hjl on 16/4/30.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHTweetController.h"
#import "HHTweet.h"
#import "HHTweetCell.h"
#import <MJRefresh.h>

@interface HHTweetController ()
/** infoMutableArray */
@property (nonatomic, strong) NSMutableArray *infoMutableArray;
/** 页码 */
@property (nonatomic, assign) NSInteger page;
@end

@implementation HHTweetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
    
    [self setupRefresh];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupTable {
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HHTweetCell" bundle:nil] forCellReuseIdentifier:@"HHTweetCell"];
    self.view.backgroundColor = HHBackgroundColor;
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 55, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupRefresh {
    // 创建下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewTweet)];
    
    // 开始下拉刷新
    [self.tableView.mj_header beginRefreshing];
    
    // 创建上拉加载更多控件
    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTweet)];
}

- (void) getNewTweet{
    self.page = 0;
    if (self.type == 1) {
        // 全部页面
        _infoMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
        BmobQuery *query = [BmobQuery queryWithClassName:@"tweets"];
        [query orderByDescending:@"updatedAt"];
        query.limit = 10;
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array) {
                //NSLog(@"---> %@", obj);
                HHTweet *tweet    = [[HHTweet alloc] init];
                if ([obj objectForKey:@"name"]) {
                    tweet.name    = [obj objectForKey:@"name"];
                }
                if ([obj objectForKey:@"username"]) {
                    tweet.username  = [obj objectForKey:@"username"];
                }
                if ([obj objectForKey:@"text"]) {
                    tweet.text = [obj objectForKey:@"text"];
                }
                if ([obj objectForKey:@"iconUrl"]) {
                    tweet.iconUrl = [obj objectForKey:@"iconUrl"];
                }
                if ([obj objectForKey:@"noName"]) {
                    tweet.noName = [obj objectForKey:@"noName"];
                }
                if ([obj objectForKey:@"createdAt"]) {
                    tweet.time    = [obj objectForKey:@"createdAt"];
                }
                //NSLog(@"---> %@", tweet);
                [self.infoMutableArray addObject:tweet];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }];
    }else{// 个人页面
        _infoMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
        BmobUser *bUser = [BmobUser getCurrentUser];
        if (!bUser) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        BmobQuery *query = [BmobQuery queryWithClassName:@"tweets"];
        [query orderByDescending:@"updatedAt"];
        query.limit = 10;
        [query whereObjectKey:@"tweets" relatedTo:bUser];
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array) {
                //NSLog(@"---> %@", obj);
                HHTweet *tweet    = [[HHTweet alloc] init];
                if ([obj objectForKey:@"name"]) {
                    tweet.name    = [obj objectForKey:@"name"];
                }
                if ([obj objectForKey:@"username"]) {
                    tweet.username  = [obj objectForKey:@"username"];
                }
                if ([obj objectForKey:@"text"]) {
                    tweet.text = [obj objectForKey:@"text"];
                }
                if ([obj objectForKey:@"iconUrl"]) {
                    tweet.iconUrl = [obj objectForKey:@"iconUrl"];
                }
                if ([obj objectForKey:@"noName"]) {
                    tweet.noName = [obj objectForKey:@"noName"];
                }
                if ([obj objectForKey:@"createdAt"]) {
                    tweet.time    = [obj objectForKey:@"createdAt"];
                }
                //NSLog(@"---> %@", tweet);
                [self.infoMutableArray addObject:tweet];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }];
    }
}

- (void) loadMoreTweet{
    self.page ++;
    if (self.type == 1) {
        // 全部页面
        //_infoMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
        BmobQuery *query = [BmobQuery queryWithClassName:@"tweets"];
        [query orderByDescending:@"updatedAt"];
        query.limit = 10;
        query.skip = 10 * (self.page);//跳过20条数据
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array) {
                //NSLog(@"---> %@", obj);
                HHTweet *tweet    = [[HHTweet alloc] init];
                if ([obj objectForKey:@"name"]) {
                    tweet.name    = [obj objectForKey:@"name"];
                }
                if ([obj objectForKey:@"username"]) {
                    tweet.username  = [obj objectForKey:@"username"];
                }
                if ([obj objectForKey:@"text"]) {
                    tweet.text = [obj objectForKey:@"text"];
                }
                if ([obj objectForKey:@"iconUrl"]) {
                    tweet.iconUrl = [obj objectForKey:@"iconUrl"];
                }
                if ([obj objectForKey:@"noName"]) {
                    tweet.noName = [obj objectForKey:@"noName"];
                }
                if ([obj objectForKey:@"createdAt"]) {
                    tweet.time    = [obj objectForKey:@"createdAt"];
                }
                //NSLog(@"---> %@", tweet);
                [self.infoMutableArray addObject:tweet];
            }
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }];
    }else{// 个人页面
        //_infoMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
        BmobUser *bUser = [BmobUser getCurrentUser];
        BmobQuery *query = [BmobQuery queryWithClassName:@"tweets"];
        [query orderByDescending:@"updatedAt"];
        query.limit = 10;
        query.skip = 10 * (self.page);//跳过20条数据
        [query whereObjectKey:@"tweets" relatedTo:bUser];
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array) {
                //NSLog(@"---> %@", obj);
                HHTweet *tweet    = [[HHTweet alloc] init];
                if ([obj objectForKey:@"name"]) {
                    tweet.name    = [obj objectForKey:@"name"];
                }
                if ([obj objectForKey:@"username"]) {
                    tweet.username  = [obj objectForKey:@"username"];
                }
                if ([obj objectForKey:@"text"]) {
                    tweet.text = [obj objectForKey:@"text"];
                }
                if ([obj objectForKey:@"iconUrl"]) {
                    tweet.iconUrl = [obj objectForKey:@"iconUrl"];
                }
                if ([obj objectForKey:@"noName"]) {
                    tweet.noName = [obj objectForKey:@"noName"];
                }
                if ([obj objectForKey:@"createdAt"]) {
                    tweet.time    = [obj objectForKey:@"createdAt"];
                }
                //NSLog(@"---> %@", tweet);
                [self.infoMutableArray addObject:tweet];
            }
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }];
    }
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHTweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHTweetCell"];
    
    HHTweet *tweet = self.infoMutableArray[indexPath.row];
    cell.tweet = tweet;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HHTweet *tweet = self.infoMutableArray[indexPath.row];
    return tweet.cellHeight;
}

@end
