//
//  GfitCameraViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/21/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitCameraViewController.h"
#import "GfitCameraView.h"

@interface GfitCameraViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) GfitCameraView *view;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *captureDeviceInput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureMetadataOutput *metadataOutput;
@property (nonatomic, strong) NSBlockOperation *setupBlock;
@property (nonatomic, strong) NSBlockOperation *viewUpdateBlock;

@end

@implementation GfitCameraViewController

- (void)loadView {
    @autoreleasepool {
        self.view = [[GfitCameraView alloc] initWithFrame:CGRectZero];
    }
}

- (CGSize)preferredContentSize {
    return self.view.bounds.size;
}

- (void)viewDidLoad {
    @autoreleasepool {
        [super viewDidLoad];

        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        GfitCameraViewController * __weak weakSelf = self;
        self.setupBlock = [NSBlockOperation blockOperationWithBlock:^{
            [weakSelf setup];
        }];
        self.viewUpdateBlock = [NSBlockOperation blockOperationWithBlock:^{
            GfitCameraViewController *strongSelf = weakSelf;

            strongSelf.view.previewLayer = strongSelf.previewLayer;
            [strongSelf.view didSetPreviewLayer];
            [strongSelf.view setNeedsLayout];
            [strongSelf.view layoutIfNeeded];
        }];

        if (self.loadsAsync) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

                [weakSelf.setupBlock start];

                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.viewUpdateBlock start];
                });
            });
        } else {
            [self.setupBlock start];
            [self.viewUpdateBlock start];
        }
    }
}

- (void)cameraViewDidAppearOnscreen {
    [self.view startFocusAnimation];
    [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        
    } completion:^(BOOL finished) {

    }];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//
//    [self startRunningCaptureSession];
//    [self.view startFocusAnimation];
//}

- (void)setup {

    self.captureSession = [[AVCaptureSession alloc] init];

    NSParameterAssert(self.captureSession != nil);
    if (self.captureSession == nil) {

        NSLog(@"FATAL ERROR: Could not init a new AVCaptureSession");

        return;
    }

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(captureSessionError:) name:AVCaptureSessionRuntimeErrorNotification object:self.captureSession];
    [nc addObserver:self selector:@selector(captureSessionEvent:) name:AVCaptureSessionDidStartRunningNotification object:self.captureSession];
    [nc addObserver:self selector:@selector(captureSessionEvent:) name:AVCaptureSessionDidStopRunningNotification object:self.captureSession];
    [nc addObserver:self selector:@selector(captureSessionEvent:) name:AVCaptureSessionWasInterruptedNotification object:self.captureSession];
    [nc addObserver:self selector:@selector(captureSessionEvent:) name:AVCaptureSessionInterruptionEndedNotification object:self.captureSession];


    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetMedium]) {

        self.captureSession.sessionPreset = AVCaptureSessionPresetMedium;

    } else {

        NSLog(@"Error: Could not set AVCaptureSessionPresetMedium on AVCaptureSession:%@", self.captureSession);
    }

    if ([[AVCaptureDevice devices] count] == 0) {

        NSLog(@"FATAL ERROR: Could not get any AVCaptureDevices");

        return;
    }

    self.captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    NSParameterAssert(self.captureDevice != nil);
    if (self.captureDevice == nil) {

        NSLog(@"FATAL ERROR: Could not get default video AVCaptureDevice");

        return;
    }

    NSError * __autoreleasing deviceInputError;
    self.captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.captureDevice error:&deviceInputError];

    NSParameterAssert(self.captureDeviceInput != nil);
    if (self.captureDeviceInput == nil) {

        NSLog(@"FATAL ERROR: (could not get AVCaptureDeviceInput from device:%@) %@", self.captureDevice, deviceInputError);

        return;
    }

    if ([self.captureSession canAddInput:self.captureDeviceInput]) {

        [self.captureSession addInput:self.captureDeviceInput];

    } else {

        NSLog(@"FATAL ERROR: Cannot add AVCaptureSession input: %@", self.captureDeviceInput);

        return;
    }

    //Turn on point autofocus for middle of view
    NSError * __autoreleasing lockConfigError;
    if (![self.captureDevice lockForConfiguration:&lockConfigError]) {

        NSLog(@"Error: (could not lock AVCaptureDevice for config: %@) %@", self.captureDevice, lockConfigError);

    } else {

        [self.captureDevice setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [self.captureDevice unlockForConfiguration];

    }

    //Add the metadata output device
    self.metadataOutput = [[AVCaptureMetadataOutput alloc] init];

    NSParameterAssert(self.metadataOutput != nil);
    if (self.metadataOutput == nil) {

        NSLog(@"FATAL ERROR: Could not init new AVCaptureMetadataOutput");

        return;
    }

    [self.metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];

    if ([self.captureSession canAddOutput:self.metadataOutput]) {

        [self.captureSession addOutput:self.metadataOutput];

    } else {

        NSLog(@"FATAL ERROR: Cannot add AVCaptureSession output: %@", self.metadataOutput);

        return;
    }

    if ([self.metadataOutput.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {

        self.metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];

    } else {

        NSLog(@"FATAL ERROR: QRCode metadata type not available on AVCaptureMetadataOutput: %@", self.metadataOutput);

        return;
    }
    //output.rectOfInterest = self.bounds;

    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];

    NSParameterAssert(self.previewLayer != nil);
    if (self.previewLayer == nil) {

        NSLog(@"FATAL ERROR: Could not init new AVCaptureVideoPreviewLayer with session: %@", self.captureSession);

        return;
    }

    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
}


#pragma mark - Session event methods

/**
 *  Starts running the capture session
 */
- (void)startRunningCaptureSession {
    [self.captureSession startRunning];
}

/**
 *  Stops running the capture session
 */
- (void)stopRunningCaptureSession {
    [self.captureSession stopRunning];
}

- (void)captureSessionError:(NSNotification*)notif {
    @autoreleasepool {
        NSError * __autoreleasing err = [notif.userInfo objectForKey:AVCaptureSessionErrorKey];

        NSLog(@"FATAL ERROR: (AVCaptureSessionRuntimeError: %@) %@", self.captureSession, err);
    }
}

- (void)captureSessionEvent:(NSNotification*)notif {

    NSLog(@"AVCaptureSessionEvent: %@", notif);
}

#pragma mark - Delegate methods

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    for (AVMetadataObject *metadata in metadataObjects) {
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            NSString *code = [(AVMetadataMachineReadableCodeObject*)metadata stringValue];
            NSLog(@"Read QR Code: %@", code);
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Barcode Found!"
                                                              message:code
                                                             delegate:self
                                                    cancelButtonTitle:@"Done"
                                                    otherButtonTitles:@"Scan again",nil];

            dispatch_async(dispatch_get_main_queue(), ^{
                // Code to update the UI/send notifications based on the results of the background processing
                [message show];
                
            });
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        //Code for Done button
        // TODO: Create a finished view
    }
    if (buttonIndex == 1){
        //Code for Scan more button
        [self.captureSession startRunning];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
