//
//  SetCardGameViewController.m
//  Pug Card
//
//  Created by Nathan Hayflick on 4/24/14.
//  Copyright (c) 2014 Nathan Hayflick. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"


@interface SetCardGameViewController ()
@property (strong, nonatomic) NSMutableArray *setCards; //of SetCards
@property (strong, nonatomic) NSMutableArray *setCardViews; //of SetCardViews
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation SetCardGameViewController

- (SetCardDeck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (NSMutableArray *)cards
{
    NSMutableArray *cardsCollection = [super cards];
    if (!cardsCollection) {
        cardsCollection = [self setCards];
    }
    return cardsCollection;
}

- (NSMutableArray *)setCardViews
{
    if (!_setCardViews) _setCardViews = [[NSMutableArray alloc] init];
    return _setCardViews;
}

- (NSUInteger) startingCardCount
{
    return 12;
}


- (void)touchCardButton:(NSUInteger)index {
    [super touchCardButton:index];
}

- (IBAction)resetGame:(id)sender {
    // Clear Cards
    for (SetCardView *setCardView in self.setCardViews) {
        [self removeCard:setCardView];
    }
    [self.setCardViews removeAllObjects];
    [super resetGame];
    [self.game setNumberOfMatchCards:2];
    [self updateUI];
}

- (void) swipeCard:(UIGestureRecognizer *)target {
    if ([target.view isKindOfClass:[SetCardView class]]) {
        NSLog(@"heyy");
        SetCardView *setCardView = (SetCardView *)target.view;
        [self touchCardButton:setCardView.index];
        SetCard *setCard = (SetCard *)[self.game.cards objectAtIndex:setCardView.index];
        setCardView.isMatched = [setCard isMatched];
        setCardView.isChosen = [setCard isChosen];
        if (setCardView.isMatched) {
            NSLog(@"matched");
        } else {
            [setCardView pick];
        }
        [self updateUI];
    }
}

- (IBAction)deal:(id)sender {
    [self.game drawCards];
    [self updateUI];
}


- (void)updateUI
{
//    // Clear Cards
//    [self.setCardViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //    Render Cards
    NSUInteger i = 0;
    
    
    for (SetCard *card in self.game.cards){
        int index = [self.game.cards indexOfObject:card];
        __block SetCardView *setCardView;
        if (index < [self.setCardViews count]) {
            NSLog(@"if");
            setCardView = [self.setCardViews objectAtIndex:index];
            
            setCardView.quantity = card.quantity;
            setCardView.shape = card.shape;
            setCardView.alpha = card.alpha;
            setCardView.foregroundColor = card.foregroundColor;
            setCardView.index = index;
            if (card.isMatched) {
                [self removeCard:setCardView];
            }
            setCardView.isMatched = card.isMatched;
            [setCardView setIsChosen:card.isChosen];
        } else {
            NSLog(@"else");
            setCardView = [[SetCardView alloc] init];
            
            setCardView.quantity = card.quantity;
            setCardView.shape = card.shape;
            setCardView.alpha = card.alpha;
            setCardView.foregroundColor = card.foregroundColor;
            setCardView.index = index;
            if (card.isMatched) {
                [self removeCard:setCardView];
            }
            setCardView.isMatched = card.isMatched;
            [setCardView setIsChosen:card.isChosen];
            
            [self.containerView addSubview:setCardView];
            [self.setCardViews addObject:setCardView];
            
            setCardView.swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCard:)];
            [setCardView addGestureRecognizer:setCardView.swipeRecognizer];
        }
        
        __block CGRect frame = [self cardPosition:setCardView.index];
        
        if (!CGRectEqualToRect(frame, setCardView.frame)) {
            [UIView animateWithDuration:1 animations:^{
                setCardView.frame = frame;
            } completion:NULL];
        }

        i++;
    }
}

-(void)drawCards
{

    //    Render Cards
    NSUInteger i = 0;
    
    
    for (SetCard *card in self.game.cards){
        if (card.isMatched) continue;
        int index = [self.game.cards indexOfObject:card];
        
        SetCardView *setCardView = [[SetCardView alloc] initWithFrame:[self cardPosition:index]];
        
        setCardView.quantity = card.quantity;
        setCardView.shape = card.shape;
        setCardView.alpha = card.alpha;
        setCardView.foregroundColor = card.foregroundColor;
        setCardView.index = index;
        setCardView.isMatched = card.isMatched;
        [setCardView setIsChosen:card.isChosen];
        
        [self.containerView addSubview:setCardView];
        [self.setCardViews addObject:setCardView];
        
        setCardView.swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCard:)];
        [setCardView addGestureRecognizer:setCardView.swipeRecognizer];
        
        i++;
    }

}

- (void)removeCard:(SetCardView *)setCardView
{
    [UIView animateWithDuration:1.0 animations:^{
        setCardView.frame = CGRectMake(0.0, self.containerView.bounds.size.height, 80.0, 100.0);
    } completion:^(BOOL finished) {
        [setCardView removeFromSuperview];
    }];
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
    // Do any additional setup after loading the view.
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    
    [self.game setNumberOfMatchCards:2];
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
