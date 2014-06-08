//
//  PlayingCardView.h
//  Pug Card
//
//  Created by Nathan Hayflick on 6/5/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "CardView.h"

@interface PlayingCardView : CardView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) NSUInteger index;

- (void)flip;

@end
