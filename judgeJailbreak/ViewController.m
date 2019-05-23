//
//  ViewController.m
//  judgeJailbreak
//
//  Created by delims on 2019/5/23.
//  Copyright © 2019 delims. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    判断一个设备有没有越狱有下面几种方法
    
    

    [self isJailBreak1];
    [self isJailBreak2];
    [self isJailBreak3];
    [self isJailBreak4];
    // Do any additional setup after loading the view.
}


#define ARRAY_SIZE(a) (sizeof(a)/sizeof(a[0]))
//    判断越狱文件，如果有存在说明已经越狱

- (void)isJailBreak1
{
    const char *jailBreak_tool_paths[] = {
        "/Applications/Cydia.app",
        "/Library/MobileSubstrate/MobileSubstrate.dylib",
        "/bin/bash",
        "/usr/sbin/sshd",
        "/etc/apt"
    };
    
    for (int i = 0; i < ARRAY_SIZE(jailBreak_tool_paths); i++) {
        NSString *path = [NSString stringWithUTF8String:jailBreak_tool_paths[i]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSLog(@"%@", [path stringByAppendingString:@"  exist"]);
        }
    }

}

//通过URL scheme打开Cydia ，如果能打开说明已经越狱
- (void)isJailBreak2
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        NSLog(@"You can open cydia by cydia://");
    } else {
        NSLog(@"You can not open cydia by cydia://");
    }
}

//读取应用列表
- (void)isJailBreak3
{
    NSString *USER_APPLICATION_PATH = @"/Applications/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:USER_APPLICATION_PATH]) {
        NSLog(@"access Applications directory successfully");
        NSError *error = nil;
        NSArray *appList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:USER_APPLICATION_PATH error:&error];
        NSLog(@"%@",appList);
        if (error) {
            NSLog(@"%@",error.localizedFailureReason);
        }
    }
    
    
}

//读取环境变量
//DYLD_INSERT_LIBRARIES环境变量，在非越狱的机器上都是空，在越狱机器上基本都会有Library/MobileSubstrate/MobileSubstrate.dylib

- (void)isJailBreak4
{
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    NSLog(@"%s",env);
}

@end
