//
//  debug.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/11/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#if DEBUG

#import "gdebug.h"
#import <objc/runtime.h>

@implementation DLog

#pragma mark - Objective C Runtime Data Type Descriptions

+ (id)Selector:(SEL)selector {
    return NSStringFromSelector(selector);
}

+ (id)Protocol:(Protocol*)protocol {
    return NSStringFromProtocol(protocol);
}

+ (id)Class:(Class)class_val {
    return NSStringFromClass(class_val);
}

+ (id)TypeEncoding:(id)value {
    return [DLog cTypeEncoding:(void*)value];
}

+ (id)cTypeEncoding:(void*)value {
    const char *encoding = @encode(typeof(value));
    if (strcmp(encoding, _C_INT)) {
        return @"int";
    } else if (strcmp(encoding, @encode(int *))) {
        return @"int*";
    } else if (strcmp(encoding, _C_FLT)) {
        return @"float";
    } else if (strcmp(encoding, @encode(float *))) {
        return @"float*";
    } else if (strcmp(encoding, _C_CHR)) {
        return @"char";
    } else if (strcmp(encoding, @encode(char *))) {
        return @"char*";
    } else if (strcmp(encoding, _C_BOOL)) {
        return @"BOOL";
    } else if (strcmp(encoding, @encode(BOOL *))) {
        return @"BOOL*";
    } else if (strcmp(encoding, _C_DBL)) {
        return @"double";
    } else if (strcmp(encoding, @encode(double *))) {
        return @"double*";
    } else if (strcmp(encoding, _C_VOID)) {
        return @"void";
    } else if (strcmp(encoding, @encode(void *))) {
        return @"void*";
    } else if (strcmp(encoding, _C_SHT)) {
        return @"short";
    } else if (strcmp(encoding, @encode(short *))) {
        return @"short*";
    } else if (strcmp(encoding, _C_LNG)) {
        return @"long";
    } else if (strcmp(encoding, @encode(long *))) {
        return @"long*";
    } else if (strcmp(encoding, _C_LNG_LNG)) {
        return @"long long";
    } else if (strcmp(encoding, @encode(long long *))) {
        return @"long long*";
    } else if (strcmp(encoding, _C_UCHR)) {
        return @"unsigned char";
    } else if (strcmp(encoding, @encode(unsigned char *))) {
        return @"unsigned char*";
    } else if (strcmp(encoding, _C_UINT)) {
        return @"unsigned int";
    } else if (strcmp(encoding, @encode(unsigned int *))) {
        return @"unsigned int*";
    } else if (strcmp(encoding, _C_USHT)) {
        return @"unsigned short";
    } else if (strcmp(encoding, @encode(unsigned short *))) {
        return @"unsigned short*";
    } else if (strcmp(encoding, _C_ULNG)) {
        return @"unsigned long";
    } else if (strcmp(encoding, @encode(unsigned long *))) {
        return @"unsigned long*";
    } else if (strcmp(encoding, _C_ULNG_LNG)) {
        return @"unsigned long long";
    } else if (strcmp(encoding, @encode(unsigned long long *))) {
        return @"unsigned long long*";
    } else if (strcmp(encoding, _C_CLASS)) {
        return @"Class";
    } else if (strcmp(encoding, _C_SEL)) {
        return @"SEL";
    } else if (strcmp(encoding, _C_ID)) {
        return @"id";
    } else if (strcmp(encoding, @encode(typeof(id*)))) {
        return @"id*";
    } else if (strcmp(encoding, "r^@")) {
        return @"&id";
    } else if (strcmp(encoding, _C_BFLD)) {
        return @"C-BitField-Type=b";
    } else if (strcmp(encoding, _C_UNDEF)) {
        return @"undef";
    } else if (strcmp(encoding, _C_PTR)) {
        return @"C-Pointer-Type=^";
    } else if (strcmp(encoding, _C_CHARPTR)) {
        return @"C-CharPointer-Type=*";
    } else if (strcmp(encoding, _C_ATOM)) {
        return @"atom";
    } else if (strcmp(encoding, _C_VECTOR)) {
        return @"vector";
    } else if (strcmp(encoding, _C_CONST)) {
        return @"const";
    } else if (strcmp(encoding, "n")) { // read objc runtime programming guide
        return @"in"; // protocol method encodings going forward
    } else if (strcmp(encoding, "N")) {
        return @"inout";
    } else if (strcmp(encoding, "o")) {
        return @"out";
    } else if (strcmp(encoding, "O")) {
        return @"bycopy";
    } else if (strcmp(encoding, "R")) {
        return @"byref";
    } else if(strcmp(encoding, "V")) {
        return @"oneway";
    } else { // return the original encoding string
        return [NSString stringWithCString:encoding encoding:NSUTF8StringEncoding];
    }
}

#pragma mark - Foundation Data Type Descriptions

+ (id)NSRange:(NSRange)range {
    return NSStringFromRange(range);
}

#pragma mark - Core Geometry Data Type Descriptions

+ (id)CGPoint:(CGPoint)point {
#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR
    return NSStringFromCGPoint(point);
#else
    return NSStringFromPoint(NSPointFromCGPoint(point));
#endif
}

+ (id)CGSize:(CGSize)size {
#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR
    return NSStringFromCGSize(size);
#else
    return NSStringFromSize(NSSizeFromCGSize(size));
#endif
}

+ (id)CGRect:(CGRect)rect {
#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR
    return NSStringFromCGRect(rect);
#else
    return NSStringFromRect(NSRectFromCGRect(rect)));
#endif
}

#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR

#pragma mark - iOS Data Type Descriptions

+ (id)UIView:(UIView*)view {
    return [view performSelector:@selector(recursiveDescription)];
}

+ (id)UIImage:(UIImage*)image {
    return UIImagePNGRepresentation(image);
}

+ (id)UIOffset:(UIOffset)offset {
    return NSStringFromUIOffset(offset);
}

+ (id)UIEdgeInsets:(UIEdgeInsets)edgeinsets {
    return NSStringFromUIEdgeInsets(edgeinsets);
}

+ (id)CGAffineTransform:(CGAffineTransform)affinetransform {
    return NSStringFromCGAffineTransform(affinetransform);
}

+ (void)performLowMemoryWarning {
    [[UIApplication sharedApplication] performSelector:@selector(_performMemoryWarning)];
}

#else

#pragma mark - Mac Data Type Descriptions

+ (id)NSPoint:(NSPoint)point {
    return NSStringFromPoint(point);
}

+ (id)NSSize:(NSSize)size {
    return NSStringFromSize(size);
}

+ (id)NSRect:(NSRect)rect {
    return NSStringFromRect(rect);
}

+ (id)NSHashTable:(NSHashTable*)hashtable {
    return NSStringFromHashTable(hashtable);
}

+ (id)NSMapTable:(NSMapTable*)maptable {
    return NSStringFromMapTable(maptable);
}

#endif

#pragma mark - GLKit Data Type Descriptions

+ (id)GLKMatrix2:(GLKMatrix2)matrix {
    return NSStringFromGLKMatrix2(matrix);
}

+ (id)GLKMatrix3:(GLKMatrix3)matrix {
    return NSStringFromGLKMatrix3(matrix);
}

+ (id)GLKMatrix4:(GLKMatrix4)matrix {
    return NSStringFromGLKMatrix4(matrix);
}

+ (id)GLKVector2:(GLKVector2)vector {
    return NSStringFromGLKVector2(vector);
}

+ (id)GLKVector3:(GLKVector3)vector {
    return NSStringFromGLKVector3(vector);
}

+ (id)GLKVector4:(GLKVector4)vector {
    return NSStringFromGLKVector4(vector);
}

+ (id)GLKQuaternion:(GLKQuaternion)quaternion {
    return NSStringFromGLKQuaternion(quaternion);
}

@end

#endif
