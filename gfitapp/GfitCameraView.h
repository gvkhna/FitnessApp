//
//  GfitCameraView.h
//  gfitapp
//
//  Created by Gaurav Khanna on 12/21/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

extern const CGFloat kGfitCameraViewFocusAnimationMultiplier;

@interface GfitCameraView : UIView

/**
 *  Required to set reference after setting up `AVCaptureSession`
 */
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *previewLayer;

/**
 *  Required to call after setting self.previewLayer to finish setup
 */
- (void)didSetPreviewLayer;

- (void)startFocusAnimation;

@end
