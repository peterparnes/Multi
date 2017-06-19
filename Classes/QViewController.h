//
//  QViewController.h
//  Mult
//
//  Created by Peter Parnes on 2/7/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brain.h"
#import "TimeKeeper.h"

@protocol MultDelegate

-(void)resultingTime:(NSTimeInterval)time;

@end


@interface QViewController : UIViewController {
	IBOutlet UILabel *label;
	IBOutlet UIButton *button;
	IBOutlet UIProgressView *progress;
	Brain *brain;
	Calculation *currentQuestion;
	int currentAnswer;
	TimeKeeper *timeKeep;
	BOOL showStartMessage;
}

@property (retain) IBOutlet UILabel *label;
@property (retain) IBOutlet UIButton *button;
@property (retain) IBOutlet UIProgressView *progress;
@property BOOL showStartMessage;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)backPressed:(UIButton *)sender;

- (void)reset;

@property (assign) id <MultDelegate> delegate;

@end

