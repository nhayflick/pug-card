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

- (instancetype) initWithShapes:(NSArray *)validShapes validForegroundColors:(NSArray *)validForegroundColors validAlphas:(NSArray *)validAlphas {
    self = [super init];
    
    if (self) {
        for (NSString *validShape in validShapes) {
            for (UIColor *validUIForegroundColor in validForegroundColors) {
                for (NSNumber *validAlpha in validAlphas) {
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
