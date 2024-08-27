//
//  ViewController.m
//  test
//
//  Created by 琅锐 on 2024/8/26.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) CGPoint buttonOldPoint;
@property (nonatomic, assign) CGPoint buttonNewPoint;

@property (nonatomic, assign) CGFloat buttonLastPointX;
@property (nonatomic, assign) CGFloat buttonLastPointY;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic, strong) UIView *leftOnView;
@property (nonatomic, strong) UIView *rightOnView;
@property (nonatomic, strong) UIView *leftDownView;
@property (nonatomic, strong) UIView *rightDownView;

@property (nonatomic, strong) UIButton *touchButton;

@end

#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUserInterFace];
}

- (void)creatUserInterFace {
    CGFloat viewWidth = KScreenWidth/2;
    CGFloat viewHeight = KScreenHeight/2;
    CGFloat buttonSize = 40;
    //右上
    self.leftOnView = [[UIView alloc] initWithFrame:CGRectMake(-viewWidth/2, -viewHeight/2, viewWidth, viewHeight)];
    self.leftOnView.backgroundColor = [UIColor greenColor];
    self.leftOnView.layer.anchorPoint = CGPointMake(0, 0);
    [self.view addSubview:self.leftOnView];
    //左上
    self.rightOnView = [[UIView alloc] initWithFrame:CGRectMake(viewWidth*3/2, -viewHeight/2, viewWidth, viewHeight)];
    self.rightOnView.backgroundColor = [UIColor purpleColor];
    self.rightOnView.layer.anchorPoint = CGPointMake(1, 0);
    [self.view addSubview:self.rightOnView];
    //左下
    self.leftDownView = [[UIView alloc] initWithFrame:CGRectMake(-viewWidth/2, viewHeight*3/2, viewWidth, viewHeight)];
    self.leftDownView.backgroundColor = [UIColor blueColor];
    self.leftDownView.layer.anchorPoint = CGPointMake(0, 1);
    [self.view addSubview:self.leftDownView];
    //右下
    self.rightDownView = [[UIView alloc] initWithFrame:CGRectMake(viewWidth*3/2, viewHeight*3/2, viewWidth, viewHeight)];
    self.rightDownView.backgroundColor = [UIColor yellowColor];
    self.rightDownView.layer.anchorPoint = CGPointMake(1, 1);
    [self.view addSubview:self.rightDownView];
    
    self.touchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonSize, buttonSize)];
    self.touchButton.backgroundColor = [UIColor blackColor];
    self.touchButton.center = self.view.center;
    [self.view addSubview:self.touchButton];
    self.touchButton.layer.cornerRadius = buttonSize/2;
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    [self.touchButton addGestureRecognizer:self.panGestureRecognizer];
}

- (void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    CGPoint touchPoint = [panGestureRecognizer locationInView:self.view];
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.buttonLastPointX = self.touchButton.center.x;
        self.buttonLastPointY = self.touchButton.center.y;
    }
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat moveX = touchPoint.x - self.buttonLastPointX;
        CGFloat moveY = touchPoint.y - self.buttonLastPointY;
        
        self.buttonLastPointX = touchPoint.x;
        self.buttonLastPointY = touchPoint.y;
        //view位移的倍率
        CGFloat leftOnScaleX = (self.leftOnView.frame.size.width + moveX) / self.leftOnView.frame.size.width;
        CGFloat leftOnScaleY = (self.leftOnView.frame.size.height + moveY) / self.leftOnView.frame.size.height;
        self.leftOnView.transform = CGAffineTransformScale(self.leftOnView.transform, leftOnScaleX, leftOnScaleY);
        
        CGFloat rightOnScaleX = (self.rightOnView.frame.size.width - moveX) / self.rightOnView.frame.size.width;
        CGFloat rightOnScaleY = (self.rightOnView.frame.size.height + moveY) / self.rightOnView.frame.size.height;
        self.rightOnView.transform = CGAffineTransformScale(self.rightOnView.transform, rightOnScaleX, rightOnScaleY);
        
        CGFloat leftDownScaleX = (self.leftDownView.frame.size.width + moveX) / self.leftDownView.frame.size.width;
        CGFloat leftDownScaleY = (self.leftDownView.frame.size.height - moveY) / self.leftDownView.frame.size.height;
        self.leftDownView.transform = CGAffineTransformScale(self.leftDownView.transform, leftDownScaleX, leftDownScaleY);
        
        CGFloat rightDownScaleX = (self.rightDownView.frame.size.width - moveX) / self.rightDownView.frame.size.width;
        CGFloat rightDownScaleY = (self.rightDownView.frame.size.height - moveY) / self.rightDownView.frame.size.height;
        self.rightDownView.transform = CGAffineTransformScale(self.rightDownView.transform, rightDownScaleX, rightDownScaleY);
        
    }
    
    self.touchButton.center = touchPoint;
}




@end
