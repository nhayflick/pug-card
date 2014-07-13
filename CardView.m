//
//  CardView.m
//  Pug Card
//
//  Created by Nathan Hayflick on 6/5/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (void)setIsChosen:(BOOL)isChosen
{
    _isChosen = isChosen;
    [self setNeedsDisplay];
}

- (void)setIsMatched:(BOOL)isMatched
{
    _isMatched = isMatched;
    if (_isMatched) {
        [self removeGestureRecognizer:self.swipeRecognizer];
        self.alpha = .6;
    }

    [self setNeedsDisplay];
}


#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 6.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS / [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    
    if (self.isChosen) {
        [[UIColor grayColor] setFill];
    } else {
        [[UIColor whiteColor] setFill];
    }
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


@end
