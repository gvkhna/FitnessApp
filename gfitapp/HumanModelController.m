//
//  HumanModelController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 7/15/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "HumanModelController.h"

#import "genesis.h"
//#import "human-maleOBJ.h"
//#import "human-maleMTL.h"

#define kModelScale 5

@interface HumanModelController {
    GLuint vertexArray;
    GLuint vertexBuffer;
    float rotation;
}

@property (nonatomic, strong) EAGLContext *context;
@property (nonatomic, strong) GLKBaseEffect *effect;

@end

@implementation HumanModelController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }

    GLKView *view = [[GLKView alloc] initWithFrame:self.view.bounds];
    view.context = self.context;
    view.delegate = self;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    //view.drawableMultisample = GLKViewDrawableMultisample4X;
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;

    self.preferredFramesPerSecond = 60;

    [self setupGL];
}

- (void)setupGL {
    [EAGLContext setCurrentContext:self.context];

    self.effect = [[GLKBaseEffect alloc] init];
    self.effect.lightingType = GLKLightingTypePerPixel;

    // Turn on the first light
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(1.0f, 0.4f, 0.4f, 1.0f);
    self.effect.light0.position = GLKVector4Make(-5.f, -5.f, 10.f, 1.0f);
    self.effect.light0.specularColor = GLKVector4Make(1.0f, 0.0f, 0.0f, 1.0f);

    // Turn on the second light
//    self.effect.light1.enabled = GL_TRUE;
//    self.effect.light1.diffuseColor = GLKVector4Make(1.0f, 0.4f, 0.4f, 1.0f);
//    self.effect.light1.position = GLKVector4Make(15.f, 15.f, 10.f, 1.0f);
//    self.effect.light1.specularColor = GLKVector4Make(1.0f, 0.0f, 0.0f, 1.0f);

    // Set material
    self.effect.material.diffuseColor = GLKVector4Make(0.f, 0.5f, 1.0f, 1.0f);
    self.effect.material.ambientColor = GLKVector4Make(0.6f, 0.5f, 0.5f, 1.0f);
    self.effect.material.specularColor = GLKVector4Make(1.0f, 0.0f, 0.0f, 1.0f);
    self.effect.material.shininess = 20.0f;
    self.effect.material.emissiveColor = GLKVector4Make(0.2f, 0.f, 0.2f, 1.0f);

    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);

    glGenVertexArraysOES(1, &vertexArray);
    glBindVertexArrayOES(vertexArray);

    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(genesisVerts), genesisVerts, GL_STATIC_DRAW);
//    glBindBuffer(GL_ARRAY_BUFFER, 0);

    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GL_FLOAT) * 3, NULL);
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(GL_FLOAT) * 3, genesisNormals);
//    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
//    glVertexAttribPointer(GLKVertexAttribTexCoord0, 3, GL_FLOAT, GL_FALSE, sizeof(GL_FLOAT), genesisTexCoords);


    glBindVertexArrayOES(0);
}

#pragma mark - GLKView Memory Management methods

- (void)viewDidUnload
{
    [super viewDidUnload];

    [self tearDownGL];

    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    self.context = nil;
    self.effect = nil;
}

- (void)tearDownGL {

    [EAGLContext setCurrentContext:self.context];

    glDeleteBuffers(1, &vertexBuffer);
    glDeleteVertexArraysOES(1, &vertexArray);

    self.effect = nil;

}

#pragma mark - GLKView and GLKViewController delegate methods
//
//- (void)update
//{
//    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
//    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
//
//    self.effect.transform.projectionMatrix = projectionMatrix;
//
//    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -3.5f);
//    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, rotation, 1.0f, 1.0f, 1.0f);
//
//    self.effect.transform.modelviewMatrix = modelViewMatrix;
//
//
//    rotation += self.timeSinceLastUpdate * 0.5f;
//}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glBindVertexArrayOES(vertexArray);

    // Render the object with GLKit
    [self.effect prepareToDraw];

    glDrawArrays(GL_TRIANGLES, 0, genesisNumVerts);
    
}

//    GLKMatrix4 scale = GLKMatrix4MakeScale(kModelScale, kModelScale, kModelScale);
//    GLKMatrix4 translate = GLKMatrix4MakeTranslation(0, 0, 0);
//
//    GLKMatrix4 modelMatrix = GLKMatrix4Multiply(translate,GLKMatrix4Multiply(scale,GLKMatrix4Multiply(xRotation, yRotation)));
//    GLKMatrix4 viewMatrix = GLKMatrix4MakeLookAt(0, 0, 3, 0, 0, 0, 0, 1, 0);
//    self.effect.transform.modelviewMatrix = GLKMatrix4Multiply(viewMatrix, modelMatrix);
//
//    self.effect.transform.projectionMatrix = GLKMatrix4MakePerspective(0.125*(2*M_PI), 1.0, 2, -1);


- (void)update {
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 3.0f, 10.0f);
    self.effect.transform.projectionMatrix = projectionMatrix;

    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 1.0f, -6.0f);
    rotation += 90 * self.timeSinceLastUpdate;
    //modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(25), 1, 0, 0);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(rotation), 0, 1, 0);
    GLKMatrix4 scale = GLKMatrix4MakeScale(kModelScale, kModelScale, kModelScale);
    self.effect.transform.modelviewMatrix = GLKMatrix4Multiply(modelViewMatrix, scale);
}

@end
