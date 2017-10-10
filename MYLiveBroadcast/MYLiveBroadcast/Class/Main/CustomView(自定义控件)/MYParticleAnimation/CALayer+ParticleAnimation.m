//
//  CALayer+ParticleAnimation.m
//  MYParticleAnimation
//
//  Created by mayan on 2017/6/2.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "CALayer+ParticleAnimation.h"
#import <UIKit/UIKit.h>

@implementation CALayer (ParticleAnimation)


- (void)startParticleAnimationWithPoint:(CGPoint)point
{
    // 1.创建发射器
    CAEmitterLayer *emitter = [[CAEmitterLayer alloc] init];
    
    // 2.设置发射器的位置
    emitter.emitterPosition = point;
    
    // 3.开启三维效果
    emitter.preservesDepth = YES;
    
    // 4.创建粒子，并且设置粒子相关的属性
    NSMutableArray *cells = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        // 4.1.创建粒子cell
        CAEmitterCell *cell = [[CAEmitterCell alloc] init];
        // 4.2.设置粒子的速度
        cell.velocity = 150;
        cell.velocityRange = 100;  // 波动范围（50 ~ 250）
        // 4.3.设置粒子的大小
        cell.scale = 0.7;
        cell.scaleRange = 0.3;
        // 4.4.设置粒子方向
        cell.emissionLongitude = -M_PI_2;
        cell.emissionRange = M_PI_2 / 6;
        // 4.5.设置粒子旋转
        cell.spin = M_PI_2;
        cell.spinRange = M_PI_2 / 2;
        // 4.6.设置粒子的存活时间
        cell.lifetime = 3;
        cell.lifetimeRange = 1.5;
        // 4.7.设置粒子每秒弹出的个数
        cell.birthRate = 2;
        // 4.8.设置粒子展示的图片
        NSString *imgName = [NSString stringWithFormat:@"good%d_30x30_", i];
        cell.contents = (__bridge id _Nullable)([UIImage imageNamed:imgName].CGImage);
        
        [cells addObject:cell];
    }
    
    // 5.将粒子设置到发射器中
    emitter.emitterCells = cells;
    
    // 6.将发射器的layer添加到父layer中
    [self addSublayer:emitter];
}

- (void)stopRarticleAnimation
{
    for (CALayer *layer in self.sublayers) {
        if ([layer isKindOfClass:[CAEmitterLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
}

@end
