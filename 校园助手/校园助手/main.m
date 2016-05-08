//
//  main.m
//  校园助手
//
//  Created by hjl on 16/5/8.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        [Bmob registerWithAppKey:@"cf8a93416ffa83406532cef0c4545ae2"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
