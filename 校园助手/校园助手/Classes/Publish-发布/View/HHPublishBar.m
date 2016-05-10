//
//  HHPublishBar.m
//  校园助手
//
//  Created by hjl on 16/5/10.
//  Copyright © 2016年 hjl. All rights reserved.
//

#import "HHPublishBar.h"

@interface HHPublishBar ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation HHPublishBar


- (IBAction)btnClick:(id)sender {
    
    if ([self.isSelectButton isEqualToString:@"0"]) {
        self.button.backgroundColor = [UIColor redColor];
        self.isSelectButton = @"1";
    }else{
         self.button.backgroundColor = [UIColor whiteColor];
        self.isSelectButton = @"0";
    }
    //HHLog(@"%@", self.isSelectButton);
}


@end
