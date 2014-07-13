//
//  SetCard.m
//  Pug Card
//
//  Created by Nathan Hayflick on 4/15/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSString *)contents {
    return nil;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int shapeMatches = 0;
    int foregroundColorMatches = 0;
    int alphaMatches = 0;
    int quantityMatches = 0;
    
    for (SetCard *card in otherCards) {
        if (self.shape == card.shape) {
            shapeMatches++;
        }
        if (self.foregroundColor == card.foregroundColor) {
            foregroundColorMatches++;
        }
        if (self.alpha == card.alpha) {
            alphaMatches++;
        }
        if (self.quantity == card.quantity) {
            quantityMatches++;
        }
    }
    NSLog(@"alpha: %d", alphaMatches);
    NSLog(@"shape: %d", shapeMatches);
    NSLog(@"quanity: %d", quantityMatches);
    NSLog(@"color: %d", foregroundColorMatches);
    

    
    
    if ((shapeMatches == 0 || shapeMatches == otherCards.count) && (foregroundColorMatches == 0 || foregroundColorMatches == otherCards.count) && (alphaMatches == 0 || alphaMatches == otherCards.count) && (quantityMatches == 0 || quantityMatches == otherCards.count)) {
        score ++;
    }
    
    return score;
}


@end
