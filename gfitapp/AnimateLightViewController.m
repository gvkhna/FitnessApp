//
//  AnimateLightViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 9/2/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "AnimateLightViewController.h"

@interface AnimateLightViewController () <GLKViewDelegate>

@property (nonatomic) UIImage *sourceImage;
@property (nonatomic) EAGLContext *eaglContext;
@property (nonatomic) CIContext *ciContext;
@property (nonatomic) CIFilter *gammaFilter;
@property (nonatomic) CIImage *originalImage;
@property (nonatomic) CIImage *filteredImage;

@end

@implementation AnimateLightViewController

CGFloat positionFromSinOscillator(CGFloat x) {
    // y(t) = A * sin(2pi * f + phase) + period
    // .83 <-> .97 gamma filter bitches!
    // debug: wolfram 0.07 * sin(2*pi*(1/4)*x + .1372) + .9
    CGFloat amp = 0.18; //0.07;
    CGFloat period = 4;
    CGFloat freq = 1 / period; // T = 1/f
    CGFloat phase = .1372;
    CGFloat offset = .81;
    return amp * sinf(2*M_PI * freq * x + phase) + offset;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sourceImage = [UIImage imageNamed:@"blur_screen"];
    self.originalImage  = [CIImage imageWithCGImage:self.sourceImage.CGImage];

    self.eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.ciContext = [CIContext contextWithEAGLContext:self.eaglContext options:@{kCIContextWorkingColorSpace: [NSNull null]}];
    self.filteredImage = self.originalImage;

    GLKView *view = [[GLKView alloc] initWithFrame:self.view.bounds];
    view.context = self.eaglContext;
    view.delegate = self;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    view.backgroundColor = [UIColor whiteColor];
    CGRect bounds = [UIScreen mainScreen].bounds;
    bounds.size.height = [self backgroundImageHeight]; // half of the background image size to convert to "points"
    view.frame = bounds;
    self.view = view;

    self.preferredFramesPerSecond = 2;

    self.gammaFilter = [CIFilter filterWithName:@"CIGammaAdjust"];
    [self.gammaFilter setValue:self.filteredImage forKeyPath:@"inputImage"];
    [self.gammaFilter setValue:self.angle forKey:@"inputPower"];
    self.filteredImage = [self.gammaFilter outputImage];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.ciContext drawImage:self.filteredImage inRect:self.filteredImage.extent fromRect:self.filteredImage.extent];
}

- (void)update {
    // Rotate a little

    CGFloat value = [self.angle floatValue];
    value += (M_PI * .01);
    if (value > 4) {
        value = - 4;
    }
    self.angle = [NSNumber numberWithFloat:value];
    [self.gammaFilter setValue:[NSNumber numberWithFloat:positionFromSinOscillator(value)] forKey:@"inputPower"];
    NSLog(@"fire angle %d", self.framesPerSecond);

    self.filteredImage = [self.gammaFilter outputImage];
}

- (CGFloat)backgroundImageHeight {
    return self.sourceImage.size.height;
}

@end
