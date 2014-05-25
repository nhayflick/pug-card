//
//  SetCardDeck.m
//  Pug Card
//
//  Created by Nathan Hayflick on 4/20/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype) init {
    self = [super init];
    
    if (self) {
        for (NSString *validShape in [SetCard validShapes]) {
            for (UIColor *validUIForegroundColor in [SetCard validUIForegroundColors]) {
                for (NSNumber *validAlpha in [SetCard validAlphas]) {
                    SetCard *setCard = [[SetCard alloc] init];
                    setCard.shape = validShape;
                    setCard.foregroundColor = validUIForegroundColor;
                    setCard.alpha = validAlpha;
                    [self addCard:setCard];
                }
            }
        }
    }
    
    return self;
}

@end
