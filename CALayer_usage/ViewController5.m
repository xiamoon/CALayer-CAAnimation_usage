//
//  ViewController5.m
//  CALayer_usage
//
//  Created by 李乾 on 2017/7/30.
//  Copyright © 2017年 liqian. All rights reserved.
//

#import "ViewController5.h"

#define IMAGE_COUNT 4

@interface ViewController5 (){
    int _currentIndex;
    
    NSArray *_transitionTypes;
    NSString *_type;
    NSArray *_transitionSubTypes;
    NSString *_subType;
}
@property (weak, nonatomic) IBOutlet UIButton *tramsitionButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    _transitionTypes = @[
                         kCATransitionFade,
                         kCATransitionMoveIn,
                         kCATransitionPush,
                         kCATransitionReveal,
                         @"cube",
                         @"oglFlip",
                         @"suckEffect",
                         @"rippleEffect",
                         @"pageCurl",
                         @"pageUnCurl",
                         @"cameraIrisHollowOpen",
                         @"cameraIrisHollowClose"
                         ];
    _transitionSubTypes = @[
                            kCATransitionFromTop,
                            kCATransitionFromLeft,
                            kCATransitionFromBottom,
                            kCATransitionFromRight
                            ];
    
    _imageView.image = [UIImage imageNamed:@"image0.jpg"];
    
    UISwipeGestureRecognizer *leftSwipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwip:)];
    leftSwipGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipGesture];
    
    UISwipeGestureRecognizer *rightSwipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwip:)];
    rightSwipGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipGesture];
    
    [self buttonAction:nil];
    _subType = _transitionSubTypes[0];
}

static NSInteger typeIndex = 0;
- (IBAction)buttonAction:(UIButton *)sender {
    _type = _transitionTypes[typeIndex];
    [_tramsitionButton setTitle:_type forState:UIControlStateNormal];
    
    typeIndex ++;
    if (typeIndex == _transitionTypes.count) {
        typeIndex = 0;
    }
}

- (IBAction)segmentAction:(UISegmentedControl *)sender {
    _subType = _transitionSubTypes[sender.selectedSegmentIndex];
}

- (void)leftSwip:(UISwipeGestureRecognizer *)gesture {
    [self transitionAnimation:YES];
}

- (void)rightSwip:(UISwipeGestureRecognizer *)gesture {
    [self transitionAnimation:NO];
}

- (void)transitionAnimation:(BOOL)isNext {
    CATransition *transition = [[CATransition alloc] init];
    transition.type = _type;
    //transition.subtype = isNext ? kCATransitionFromRight : kCATransitionFromLeft;
    transition.subtype = _subType;
    transition.duration = 1.0f;
    _imageView.image = [self getImage:isNext];
    [_imageView.layer addAnimation:transition forKey:@"anim_transition"];
}

- (UIImage *)getImage:(BOOL)isNext {
    if (isNext) {
        _currentIndex = (_currentIndex + 1) % IMAGE_COUNT;
    }else {
        _currentIndex = (_currentIndex - 1 + IMAGE_COUNT) % IMAGE_COUNT;
    }
    NSString *imageName = [NSString stringWithFormat:@"image%d.jpg", _currentIndex];
    return [UIImage imageNamed:imageName];
}


@end
