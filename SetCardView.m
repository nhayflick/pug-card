//
//  SetCardView.m
//  Pug Card
//
//  Created by Nathan Hayflick on 6/7/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#pragma mark - Properties

@synthesize isMatched = _isMatched;


- (void)setShape:(NSUInteger)shape
{
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setForegroundColor:(NSUInteger)foregroundColor
{
    _foregroundColor = foregroundColor;
    [self setNeedsDisplay];
}

- (void)setAlpha:(NSUInteger)alpha
{
    _alpha = alpha;
    [self setNeedsDisplay];
}

- (void)setQuantity:(NSUInteger)quantity
{
    _quantity = quantity;
    [self setNeedsDisplay];
}

- (void)setIsMatched:(BOOL)isMatched
{
    _isMatched = isMatched;
    if (_isMatched) {
        [self removeGestureRecognizer:self.swipeRecognizer];
//        [self removeFromSuperview];
    }
    [self setNeedsDisplay];
}


#pragma mark - Gesture

- (void)pick
{}

#pragma mark - Drawing

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawShapes];
}

const int SHAPE_PADDING = 12.0;

- (void) drawShapes
{
    CGFloat shapeHeight = self.bounds.size.height / 3;
    CGFloat startingPoint = (self.bounds.size.height - self.quantity * shapeHeight) / 2;
    CGFloat shapeWidth = shapeHeight - SHAPE_PADDING * 2;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];

    for (int i = 0; i < self.quantity; i++) {
        
        switch (self.shape) {
            case 1:
        //        Left Corner
                [path moveToPoint:CGPointMake(SHAPE_PADDING, (shapeHeight / 2) + startingPoint)];
        //        Top Corner
                [path addLineToPoint:CGPointMake((self.bounds.size.width / 2), startingPoint + SHAPE_PADDING)];
        //        Right Corner
                [path addLineToPoint:CGPointMake(self.bounds.size.width - SHAPE_PADDING, (shapeHeight / 2) + startingPoint)];
        //        Bottom Corner
                startingPoint+= shapeHeight;
                [path addLineToPoint:CGPointMake((self.bounds.size.width / 2), startingPoint - SHAPE_PADDING)];
                [path closePath];
                break;
                
            case 2:
                //        Top Right
                [path moveToPoint:CGPointMake(self.bounds.size.width - SHAPE_PADDING - shapeWidth / 2, startingPoint + SHAPE_PADDING)];
                //        Right Curve
                [path addArcWithCenter:CGPointMake(self.bounds.size.width - SHAPE_PADDING - shapeWidth / 2, startingPoint + SHAPE_PADDING + shapeWidth / 2) radius:shapeWidth / 2 startAngle:M_PI * 1.5 endAngle:M_PI * .5 clockwise:YES];
                //        Bottom Right
                startingPoint+= shapeHeight;
                //        [path addLineToPoint:CGPointMake(self.bounds.size.width - SHAPE_PADDING - shapeWidth / 2, startingPoint - SHAPE_PADDING)];
                //        Bottom Left
                [path addLineToPoint:CGPointMake(SHAPE_PADDING + shapeWidth / 2, startingPoint - SHAPE_PADDING)];
                //        Left Curve
                [path addArcWithCenter:CGPointMake(SHAPE_PADDING + shapeWidth / 2, startingPoint - SHAPE_PADDING - shapeWidth / 2) radius:shapeWidth / 2 startAngle:M_PI * .5 endAngle:M_PI * 1.5 clockwise:YES];
                //        Top Left
                [path closePath];

                break;
                
            case 3:
                //       Top Right
                [path moveToPoint:CGPointMake(self.bounds.size.width - SHAPE_PADDING - shapeWidth / 2, startingPoint + SHAPE_PADDING)];
                
                //      Bottom Left
                startingPoint+= shapeHeight;
                [path addCurveToPoint:CGPointMake(SHAPE_PADDING + shapeWidth / 2, startingPoint - SHAPE_PADDING) controlPoint1:CGPointMake(self.bounds.size.width, startingPoint - shapeHeight / 2 + SHAPE_PADDING) controlPoint2:CGPointMake(self.bounds.size.width / 2, startingPoint - shapeHeight / 2)];
                
                //        Back to Right
                [path addCurveToPoint:CGPointMake(self.bounds.size.width - SHAPE_PADDING - shapeWidth / 2, startingPoint - shapeHeight + SHAPE_PADDING) controlPoint1:CGPointMake(0, startingPoint - shapeHeight / 2 - SHAPE_PADDING) controlPoint2:CGPointMake(self.bounds.size.width / 2, startingPoint - shapeHeight / 2)];
                break;

        }
    }
    switch (self.foregroundColor) {
        case 1:
            [[UIColor redColor] setStroke];
            [[UIColor redColor] setFill];
            break;
            
        case 2:
            [[UIColor greenColor] setStroke];
            [[UIColor greenColor] setFill];
            break;
            
        case 3:
            [[UIColor blueColor] setStroke];
            [[UIColor blueColor] setFill];
            break;
            
    }
    
    [path stroke];
    [path addClip];
    
    if (self.alpha == 1) {
        [path fill];
    } else if (self.alpha == 2) {
        NSUInteger numberOfStripes = self.bounds.size.width / 3;
        for (int i = 0; i < numberOfStripes; i++) {
            int currentX = i * 5;
            [path moveToPoint:CGPointMake(currentX, 0)];
            [path addLineToPoint:CGPointMake(currentX, self.bounds.size.height)];
        }
        [path stroke];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


@end
