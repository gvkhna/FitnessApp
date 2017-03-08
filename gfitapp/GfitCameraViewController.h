//
//  GfitCameraViewController.h
//  gfitapp
//
//  Created by Gaurav Khanna on 12/21/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface GfitCameraViewController : UIViewController

/**
 *  The internal `AVCaptureSession` object
 */
@property (nonatomic, readonly) AVCaptureSession *captureSession;

@property (nonatomic, assign) BOOL loadsAsync;

/**
 *  Starts running the capture session
 */
- (void)startRunningCaptureSession;

/**
 *  Stops running the capture session
 */
- (void)stopRunningCaptureSession;

- (void)cameraViewDidAppearOnscreen;

@end
