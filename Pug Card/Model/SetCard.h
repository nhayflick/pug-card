//
//  SetCard.h
//  Pug Card
//
//  Created by Nathan Hayflick on 4/15/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) UIColor *foregroundColor;
@property (strong, nonatomic) NSNumber *alpha;

+ (NSArray *)validShapes;
+ (NSArray *)validAlphas;
+ (NSArray *)validUIForegroundColors;

@end
