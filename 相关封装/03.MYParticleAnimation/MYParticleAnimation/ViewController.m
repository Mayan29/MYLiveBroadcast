//
//  ViewController.m
//  MYParticleAnimation
//
//  Created by mayan on 2017/6/2.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "ViewController.h"
#import "CALayer+ParticleAnimation.h"

@implementation ViewController



- (IBAction)star:(UIButton *)sender {
    
    CGPoint point = CGPointMake(sender.center.x, sender.frame.origin.y);
    
    if (sender.isSelected) {
        [self.view.layer stopRarticleAnimation];
    } else {
        [self.view.layer startParticleAnimationWithPoint:point];
    }
    
    sender.selected = !sender.isSelected;
}

@end
