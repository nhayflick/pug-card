//
//  PlayingCardGameViewController.m
//  Pug Card
//
//  Created by Nathan Hayflick on 4/14/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "CardGameHistoryViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"


@interface PlayingCardGameViewController ()
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *playingCardButtons;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) NSMutableArray *playingCardViews; //of playingCardViews


@end



@implementation PlayingCardGameViewController

- (NSUInteger) startingCardCount
{
    return 12;
}


- (PlayingCardDeck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}

- (NSMutableArray *)playingCardViews
{
    if (!_playingCardViews) _playingCardViews = [[NSMutableArray alloc] init];
    return _playingCardViews;
}

#pragma mark - Gestures

- (void)swipeCard:(UIGestureRecognizer *)target
{
    if ([target.view isKindOfClass:[PlayingCardView class]]) {
        __block PlayingCardView *playingCardView = (PlayingCardView *)target.view;
        [UIView transitionWithView:playingCardView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [playingCardView flip];
        } completion:^(BOOL finished) {
            [self touchCardButton:playingCardView.index];
            [self updateUI];
        }];
    }
}

#pragma mark - Game Logic

- (void)updateUI
{
    for (PlayingCardView *playingCardView in self.playingCardViews){
        __block PlayingCard *playingCard = [self.game cardAtIndex:playingCardView.index];
        playingCardView.rank = playingCard.rank;
        playingCardView.faceUp = playingCard.isChosen;
        playingCardView.isMatched = playingCard.isMatched;
        playingCardView.suit = playingCard.suit;
        __block CGRect frame = [self cardPosition:playingCardView.index];
        if (!CGRectEqualToRect(frame, playingCardView.frame)) {
            [UIView animateWithDuration:1 animations:^{
                playingCardView.frame = frame;
            } completion:NULL];
        }
    }

    
//    Update Label
    if (self.game.lastSelectedCards.count > 1) {
//        For correct matches
        if (self.game.score > self.lastScore) {
            self.resultsString = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
            for (Card *card in self.game.lastSelectedCards) {
                [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", card.contents]]];
            }
            [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"for %d points.", self.game.score - self.lastScore]]];
//        For incorrect matches
        } else {
            self.resultsString = [[NSMutableAttributedString alloc] init];
            for (Card *card in self.game.lastSelectedCards) {
                [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", card.contents]]];
            }
            [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:@"don't match."]];
        }
    } else {
        self.resultsString = [[NSMutableAttributedString alloc] initWithString:@"Picked "];
        for (Card *card in self.game.lastSelectedCards) {
            [self.resultsString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", card.contents]]];
        }
    }
    self.resultsLabel.attributedText = self.resultsString;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    [self.gameHistory appendAttributedString:self.resultsString];
    [self.gameHistory appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
}

- (void) drawCards
{
    NSLog(@"%@", self.game.cards);
    NSLog(@"here");
    //    Update Cards
    NSUInteger i = 0;
    for (PlayingCard *card in self.game.cards){
        PlayingCardView *playingCardView = [[PlayingCardView alloc] initWithFrame:[self cardPosition:[self.game.cards indexOfObject:card]]];
        playingCardView.rank = card.rank;
        playingCardView.faceUp = card.chosen;
        playingCardView.suit = card.suit;
        playingCardView.index = [self.game.cards indexOfObject:card];
        [playingCardView addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCard:)]];
        [self.containerView addSubview:playingCardView];
        
        [self.playingCardViews addObject:playingCardView];

        playingCardView.swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCard:)];
        [playingCardView addGestureRecognizer:playingCardView.swipeRecognizer];
        
        i++;
    }
    [self updateUI];

}

- (IBAction)resetGame:(id)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck]];
    [self drawCards];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    UIImage *image = [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
    return card.isMatched ?  [UIImage imageNamed:@"CardDisabled"] : image;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];

    NSLog(@"did load");
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"did layout");
    [self drawCards];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
