//
//  FrontViewController.h
//  Mult
//
//  Created by Peter Parnes on 2/7/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QViewController.h"
#import "HighScoreViewController.h"

@interface FrontViewController : UIViewController <MultDelegate> {
	IBOutlet UITextView *mainLabel;
	IBOutlet UIButton *startButton;
	QViewController *qvc; 
	HighScoreViewController *hsvc; 
	NSTimeInterval resultTime;
	BOOL addHighScoreLaunched;
	BOOL showAddHighScore;
}


@property (retain) IBOutlet UIButton *startButton;
@property (retain) IBOutlet UITextView *mainLabel;

- (IBAction)startPressed:(UIButton *)sender;

- (void)resultingTime:(NSTimeInterval)time;


@end
