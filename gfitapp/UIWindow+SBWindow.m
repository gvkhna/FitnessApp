//
//  UIWindow+SBWindow.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/14/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "UIWindow+SBWindow.h"
#import <objc/runtime.h>

UIWindow * __weak GfitSBWindow = nil;

@implementation UIWindow (SBWindow)

- (id)swap_initWithFrame:(CGRect)frame {

    id result = nil;

    // This is because of the way swapping works,
    // self is actually super at runtime and
    // this calls the super method
    result = [self swap_initWithFrame:frame];

    if (result) {

        char *sbWindowClassName = strdup("ARandomTypeWindow");

        // a little obfuscation never hurt
        strcpy(sbWindowClassName, "U");
        strcat(sbWindowClassName, "I");
        strcat(sbWindowClassName, "S");
        strcat(sbWindowClassName, "t");
        strcat(sbWindowClassName, "a");
        strcat(sbWindowClassName, "t");
        strcat(sbWindowClassName, "u");
        strcat(sbWindowClassName, "s");
        strcat(sbWindowClassName, "B");
        strcat(sbWindowClassName, "a");
        strcat(sbWindowClassName, "r");
        strcat(sbWindowClassName, "W");
        strcat(sbWindowClassName, "i");
        strcat(sbWindowClassName, "n");
        strcat(sbWindowClassName, "d");
        strcat(sbWindowClassName, "o");
        strcat(sbWindowClassName, "w");

        Class sbWindowClass = NULL;

        sbWindowClass = objc_lookUpClass(sbWindowClassName);

        if (sbWindowClass) {
            const char *n1 = object_getClassName(result);
            const char *n2 = class_getName(sbWindowClass);

            if (n1 && n2 && strcmp(n1, n2) == 0) {
                GfitSBWindow = result;
            }
        }

        free(sbWindowClassName);

    }

    return result;
}

+ (void)load
{
    // The "+ load" method is called once, very early in the application life-cycle.
    // It's called even before the "main" function is called. Beware: there's no
    // autorelease pool at this point, so avoid Objective-C calls.
    SEL originalSEL = NULL;
    SEL swapSEL = NULL;
    Method originalMethod = NULL;
    Method swapMethod = NULL;

    originalSEL = sel_registerName("initWithFrame:");
    swapSEL = sel_registerName("swap_initWithFrame:");

    if (self && originalSEL && swapSEL) {

        originalMethod = class_getInstanceMethod(self, originalSEL);
        swapMethod = class_getInstanceMethod(self, swapSEL);

        if (originalMethod && swapMethod) {
            method_exchangeImplementations(originalMethod, swapMethod);
        }
    }

}

+ (void)unloadSwapMethodsAtRuntime {

    SEL originalSEL = NULL;
    SEL swapSEL = NULL;
    Method originalMethod = NULL;
    Method swapMethod = NULL;

    originalSEL = sel_registerName("initWithFrame:");
    swapSEL = sel_registerName("swap_initWithFrame:");

    if (self && originalSEL && swapSEL) {
        originalMethod = class_getInstanceMethod(self, originalSEL);
        swapMethod = class_getInstanceMethod(self, swapSEL);

        if (originalMethod && swapMethod) {
            method_exchangeImplementations(swapMethod, originalMethod);
        }
    }
}

@end
