//
//  AlertManager.h
//  AlertManagerSample
//
//  Created by raymond on 2017/10/31.
//  Copyright © 2017年 Raymond. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AlertAction;

@interface AlertManager : NSObject

+ (instancetype)sharedManager;

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray<AlertAction *> *)actions;

+ (void)showOKAlertWithTitle:(NSString *)title message:(NSString *)message okHandler:(void (^)(void))handler;

@end


@interface AlertAction : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic, copy) void (^handler)(void);

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(void))handler;

@end
