//
//  CardView.h
//  Pug Card
//
//  Created by Nathan Hayflick on 6/5/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView
@property (nonatomic) NSUInteger index;
@property (nonatomic) BOOL isChosen;
@property (nonatomic) BOOL isMatched;
@property (nonatomic) UIGestureRecognizer *swipeRecognizer;


- (CGFloat)cornerScaleFactor;
- (CGFloat)cornerRadius;
- (CGFloat)cornerOffset;

@end

