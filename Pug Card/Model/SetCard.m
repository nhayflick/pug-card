//
//  SetCard.m
//  Pug Card
//
//  Created by Nathan Hayflick on 4/15/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validShapes {
    return @[@"▲", @"●", @"◼︎"];
}

+ (NSArray *) validAlphas {
    return @[@0.3, @0.6, @1];
}

+ (NSArray *) validUIForegroundColors {
     return @[[UIColor greenColor], [UIColor redColor], [UIColor blueColor]];
}

- (NSString *)contents {
    return nil;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int shapeMatches = 0;
    int foregroundColorMatches = 0;
    int alphaMatches = 0;
    
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
    }
    
    if ((shapeMatches == 0 || shapeMatches == otherCards.count + 1) && (foregroundColorMatches == 0 || foregroundColorMatches == otherCards.count + 1) && (alphaMatches == 0 || alphaMatches == otherCards.count + 1)) {
        score ++;
    }
    
    return score;
}


@end
