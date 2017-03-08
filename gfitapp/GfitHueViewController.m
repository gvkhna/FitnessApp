//
//  GfitHueViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitHueViewController.h"

@interface GfitHueViewController ()

@property (nonatomic, strong) GLKView *view;

@property (nonatomic, strong) CIContext *ciContext;
@property (nonatomic, strong) CIFilter *hueFilter;

@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic, strong) CIImage *originalRecipe;
@property (nonatomic, strong) CIImage *filteredRecipe;

@property (nonatomic, strong) NSNumber *hueAngle;

//@property (nonatomic, assign) GLuint renderBufferStorage;

@end

@implementation GfitHueViewController

#pragma mark - View Setup

/**
 *  Set fully initialized view
 */
- (void)loadView {
	EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
	self.view = [[GLKView alloc] initWithFrame:CGRectZero context:context];
}

/**
 *  Return view size for containment
 *
 *  @return sourceImage size
 */
- (CGSize)preferredContentSize {
	return self.sourceImage.size;
}

- (id<UILayoutSupport>)topLayoutGuide {
    return self;
}

- (CGFloat)length {
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        return 0;
    }
    return -40;
}

#pragma mark - View Controller Setup

/**
 *  Setup assets to display in view
 */
- (void)viewDidLoad {
	[super viewDidLoad];

	@autoreleasepool {

        self.view.layer.opaque = YES;

		self.sourceImage = [UIImage imageNamed:@"main_menu_landscape_bg"];

        NSParameterAssert(self.sourceImage != nil);
		
		// This is a long running process on the main thread at launch,
		// using the `CIImage` backing the `UIImage` doesn't work,
		// alloc/init from an `NSURL` doesn't work either, w.e.
	    self.originalRecipe = [[CIImage alloc] initWithCGImage:self.sourceImage.CGImage];
	
		self.filteredRecipe = self.originalRecipe;

        NSDictionary *options = @{ kCIContextWorkingColorSpace:[NSNull null] };
		self.ciContext = [CIContext contextWithEAGLContext:self.view.context options:options];

        self.paused = YES;
		self.preferredFramesPerSecond = 2;
		self.resumeOnDidBecomeActive = NO;
		self.pauseOnWillResignActive = NO;
	
		self.hueAngle = [[NSNumber alloc] initWithFloat:0.0f];
		self.hueFilter = [CIFilter filterWithName:@"CIHueAdjust"];
		[self.hueFilter setValue:self.filteredRecipe forKeyPath:kCIInputImageKey];
		[self.hueFilter setValue:self.hueAngle forKey:kCIInputAngleKey];
		self.filteredRecipe = self.hueFilter.outputImage;

        // TODO: see about OpenGL fast path from renderbuffer to framebuffer
//		GLuint colorRenderbuffer;
//        glGenRenderbuffers(1, &colorRenderbuffer);
//        glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
//        [self.view.context renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.view.layer];
//
//        self.renderBufferStorage = colorRenderbuffer;
	}
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)appWillResignActive:(NSNotification*)notif {
    self.paused = YES;
}

- (void)appDidBecomeActive:(NSNotification*)notif {
    self.paused = NO;
}

#pragma mark - View Update Methods

/**
 *  Draw the image with hue filter applied
 *
 *  @param view the view object
 *  @param rect area to draw in
 */
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    // Clear the framebuffer
    //glClearColor(0.0f, 0.0f, 0.1f, 1.0f);
    //glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // Clear the depth buffer
    //const GLenum discards[]  = {GL_DEPTH_ATTACHMENT};
    //glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
    //glDiscardFramebufferEXT(GL_FRAMEBUFFER,1,discards);

    @autoreleasepool {

    //glEnable(GL_BLEND);
    //glDisable(GL_BLEND);
    //glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);

//    [self.ciContext drawImage:result inRect:[[UIScreen mainScreen] applicationFrame]
//                     fromRect:[result extent]];



        //glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, self.renderBufferStorage);

        CIImage *image = self.filteredRecipe;
        const CGRect extent = image.extent;
        [self.ciContext drawImage:image inRect:extent fromRect:extent];

        // present the render buffer
        //glBindRenderbuffer(GL_RENDERBUFFER, self.renderBufferStorage);
        //[self.view.context presentRenderbuffer:self.renderBufferStorage];

        }

//    GLuint render_buffer = 0;
//    glBindRenderbuffer(GL_RENDERBUFFER, render_buffer);
//    [self.view.context presentRenderbuffer:GL_RENDERBUFFER];

//    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE) {
//        NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
//    }
}

/**
 *  Rotate the hue color wheel slightly every frame
 */
- (void)update {

    @autoreleasepool {
    
		// Rotate a little
		CGFloat value = self.hueAngle.floatValue;
		value += (M_PI * .01);
		if (value > M_PI * 2.0) {
			value = 0.0;
		}
	
		// update internal state
		self.hueAngle = [[NSNumber alloc] initWithFloat:value];
	
		// update filter state
		[self.hueFilter setValue:self.hueAngle forKey:kCIInputAngleKey];
	
		// set output as current image to draw
		self.filteredRecipe = self.hueFilter.outputImage;
		
	}
}

@end
