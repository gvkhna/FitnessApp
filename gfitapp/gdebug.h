//
//  gdebug.h
//  gdebug
//
//  Created by Gaurav Khanna on 11/18/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#ifndef gdebug_h
#define gdebug_h

#ifdef __OBJC__

    #ifdef __DEBUG__
        #ifndef DEBUG
            #define DEBUG
        #endif
    #endif

    #if DEBUG
        #ifndef DEBUG
            #define DEBUG
        #endif
    #endif

    #ifdef DEBUG
        #ifndef DLOG
            #define DLOG
        #endif
    #endif

    #ifdef DLOG
        #import <Foundation/Foundation.h>
        #import <GLKit/GLKit.h>
        #if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR
            #import <UIKit/UIKit.h>
        #endif

#pragma mark - Debugger Helper Class

@interface DLog : NSObject

+ (id)Selector:(SEL)selector;
+ (id)Protocol:(Protocol*)protocol;
+ (id)Class:(Class)class_val;
+ (id)TypeEncoding:(id)value;
+ (id)cTypeEncoding:(void*)value;

+ (id)NSRange:(NSRange)range;
+ (id)CGPoint:(CGPoint)point;
+ (id)CGSize:(CGSize)size;
+ (id)CGRect:(CGRect)rect;

#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR

+ (id)UIView:(UIView*)view;
+ (id)UIImage:(UIImage*)image;
+ (id)UIOffset:(UIOffset)offset;
+ (id)UIEdgeInsets:(UIEdgeInsets)edgeinsets;
+ (id)CGAffineTransform:(CGAffineTransform)cgaffinetransform;

+ (void)performLowMemoryWarning;

#else 

+ (id)NSPoint:(NSPoint)point;
+ (id)NSSize:(NSSize)size;
+ (id)NSRect:(NSRect)rect;
+ (id)NSHashTable:(NSHashTable*)hashtable;
+ (id)NSMapTable:(NSMapTable*)maptable;

#endif

+ (id)GLKMatrix2:(GLKMatrix2)matrix;
+ (id)GLKMatrix3:(GLKMatrix3)matrix;
+ (id)GLKMatrix4:(GLKMatrix4)matrix;
+ (id)GLKVector2:(GLKVector2)vector;
+ (id)GLKVector3:(GLKVector3)vector;
+ (id)GLKVector4:(GLKVector4)vector;
+ (id)GLKQuaternion:(GLKQuaternion)quaternion;

@end

        #ifndef DLOG_PREFIX
            #define DLOG_PREFIX DL
        #endif

        #define Q_(x) #x
        #define Q(x) Q_(x)
        #define PRE Q(DLOG_PREFIX)

#pragma mark - Logging Methods

        #define DLog(format, ...)           NSLog(@"%s:%@; ", PRE, [NSString stringWithFormat:format, ## __VA_ARGS__ ])
        #define DLogFunctionLine()          NSLog(@"%s:%s;%d;", PRE, __PRETTY_FUNCTION__, __LINE__)

        #define DLogObject(obj)             NSLog(@"%s:%s;%@;", PRE, #obj , obj)
        #define DLogNSObject(obj)           DLogObject(obj)
        #define DLogClass(val)              NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromClass(val))
        #define DLogSEL(val)                NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromSelector(val))
        #define DLogProtocol(val)           NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromProtocol(val))
        #define DLogPointer(val)            NSLog(@"%s:%s;%p;", PRE, #val, val)
        #define DLogTypeEncoding(val)       NSLog(@"%s:%s;%s;", PRE, #val, @encode(typeof(val)))
        #define DLogBytes(val)              NSLog(@"%s:%s;%@;", PRE, #val, [NSData dataWithBytes:&val length:sizeof(val)])
        #define DLogByteOrder()             NSLog(@"%s:%s;", PRE, ( NSHostByteOrder() ? "LittleEndian" : "BigEndian" ))

        #define DLogBOOL(val)               NSLog(@"%s:%s;%s;", PRE, #val, (val ? "YES" : "NO"))
        #define DLogNSRange(val)            NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromRange(val))
        #define DLogunichar(val)            NSLog(@"%s:%s;%C;", PRE, #val, val)

        #define DLogid(obj)                 DLogObject(obj)
        #define DLogCGFloat(val)            DLogfloat(val)

        #define DLogchar(val)               NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithChar:val])
        #define DLogdouble(val)             NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithDouble:val])
        #define DLogfloat(val)              NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithFloat:val])
        #define DLogint(val)                NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithInt:val])
        #define DLogNSInteger(val)          NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithInteger:val])
        #define DLoglong(val)               NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithLong:val])
        #define DLoglonglong(val)           NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithLongLong:val])
        #define DLogshort(val)              NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithShort:val])
        #define DLogunsignedchar(val)       NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithUnsignedChar:val])
        #define DLogunsignedint(val)        NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithUnsignedInt:val])
        #define DLogNSUInteger(val)         NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithUnsignedInteger:val])
        #define DLogunsignedlong(val)       NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithUnsignedLong:val])
        #define DLogunsignedlonglong(val)   NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithUnsignedLongLong:val])
        #define DLogunsignedshort(val)      NSLog(@"%s:%s;%@;", PRE, #val, [NSNumber numberWithUnsignedShort:val])

        #define DLogGLKMatrix2(val)         NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromGLKMatrix2(val))
        #define DLogGLKMatrix3(val)         NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromGLKMatrix3(val))
        #define DLogGLKMatrix4(val)         NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromGLKMatrix4(val))
        #define DLogGLKVector2(val)         NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromGLKVector2(val))
        #define DLogGLKVector3(val)         NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromGLKVector3(val))
        #define DLogGLKVector4(val)         NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromGLKVector4(val))
        #define DLogGLKQuaternion(val)      NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromGLKQuaternion(val))

        #if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR

            #define DLogUIView(obj)             NSLog(@"%s:%s;%@;", PRE, #obj, [obj performSelector:@selector(recursiveDescription) withObject:nil])
            #define DLogCGPoint(val)            NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromCGPoint(val))
            #define DLogCGSize(val)             NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromCGSize(val))
            #define DLogCGRect(val)             NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromCGRect(val))
            #define DLogNSPoint(val)            NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromCGPoint((CGPoint)val))
            #define DLogNSSize(val)             NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromCGSize((CGSize)val))
            #define DLogNSRect(val)             NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromCGRect((CGRect)val))
            #define DLogUIOffset(val)           NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromUIOffset(val))
            #define DLogUIEdgeInsets(val)       NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromUIEdgeInsets(val))
            #define DLogCGAffineTransform(val)  NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromCGAffineTransform(val))

        #elif TARGET_OS_MAC

            #define DLogCGPoint(val)            NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromPoint(NSPointFromCGPoint(val)))
            #define DLogCGSize(val)             NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromSize(NSSizeFromCGSize(val)))
            #define DLogCGRect(val)             NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromRect(NSRectFromCGRect(val)))
            #define DLogNSPoint(val)            NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromPoint(val))
            #define DLogNSSize(val)             NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromSize(val))
            #define DLogNSRect(val)             NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromRect(val))
            #define DLogNSHashTable(obj)        NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromHashTable(val))
            #define DLogNSMapTable(obj)         NSLog(@"%s:%s;%@;", PRE, #val, NSStringFromMapTable(val))

        #endif

#pragma mark - Time Logging Methods

        #define DLogStart(key)             NSDate *__dTime ## key = [NSDate date]
        #define DLogEnd(key)               NSLog(@"%s:%s;%f;", PRE, #key, -([__dTime ## key timeIntervalSinceNow]))

#pragma mark - Thread Logging Methods

        #define DLogMainThread()        NSLog(@"%s:%s;%d:MainThread=%s;", PRE, __PRETTY_FUNCTION__, __LINE__,([NSThread isMainThread]?"YES":"NO"))

    #else

        #define DLog(format, ...)                   do{}while(0)
        #define DLogFunctionLine()                  do{}while(0)

        #define DLogObject(obj)                     do{}while(0)
        #define DLogNSObject(obj)                   do{}while(0)
        #define DLogClass(val)                      do{}while(0)
        #define DLogSEL(val)                        do{}while(0)
        #define DLogProtocol(val)                   do{}while(0)
        #define DLogPointer(val)                    do{}while(0)
        #define DLogTypeEncoding(val)               do{}while(0)
        #define DLogBytes(val)                      do{}while(0)
        #define DLogByteOrder()                     do{}while(0)

        #define DLogBOOL(val)                       do{}while(0)
        #define DLogNSRange(val)                    do{}while(0)
        #define DLogunichar(val)                    do{}while(0)

        #define DLogid(obj)                         do{}while(0)
        #define DLogCGFloat(val)                    do{}while(0)

        #define DLogchar(val)                       do{}while(0)
        #define DLogdouble(val)                     do{}while(0)
        #define DLogfloat(val)                      do{}while(0)
        #define DLogint(val)                        do{}while(0)
        #define DLogNSInteger(val)                  do{}while(0)
        #define DLoglong(val)                       do{}while(0)
        #define DLoglonglong(val)                   do{}while(0)
        #define DLogshort(val)                      do{}while(0)
        #define DLogunsignedchar(val)               do{}while(0)
        #define DLogunsignedint(val)                do{}while(0)
        #define DLogNSUInteger(val)                 do{}while(0)
        #define DLogunsignedlong(val)               do{}while(0)
        #define DLogunsignedlonglong(val)           do{}while(0)
        #define DLogunsignedshort(val)              do{}while(0)

        #define DLogGLKMatrix2(val)                 do{}while(0)
        #define DLogGLKMatrix3(val)                 do{}while(0)
        #define DLogGLKMatrix4(val)                 do{}while(0)
        #define DLogGLKVector2(val)                 do{}while(0)
        #define DLogGLKVector3(val)                 do{}while(0)
        #define DLogGLKVector4(val)                 do{}while(0)
        #define DLogGLKQuaternion(val)              do{}while(0)

        #define DLogUIView(obj)                     do{}while(0)
        #define DLogCGPoint(val)                    do{}while(0)
        #define DLogCGSize(val)                     do{}while(0)
        #define DLogCGRect(val)                     do{}while(0)
        #define DLogUIOffset(val)                   do{}while(0)
        #define DLogUIEdgeInsets(val)               do{}while(0)
        #define DLogCGAffineTransform(val)          do{}while(0)

        #define DLogNSPoint(val)                    do{}while(0)
        #define DLogNSSize(val)                     do{}while(0)
        #define DLogNSRect(val)                     do{}while(0)
        #define DLogNSHashTable(obj)                do{}while(0)
        #define DLogNSMapTable(obj)                 do{}while(0)

        #define DLogStart(key)                      do{}while(0)
        #define DLogEnd(key)                        do{}while(0)

        #define DLogMainThread()                    do{}while(0)

    #endif
#endif

#endif