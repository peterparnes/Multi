//
//  QViewController.m
//  Mult
//
//  Created by Peter Parnes on 2/7/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import "QViewController.h"
#import "Brain.h"

@interface QViewController() 
@property (nonatomic, retain) Brain *brain;
@property int currentAnswer;
@property (retain) Calculation *currentQuestion;
@property (nonatomic, retain) TimeKeeper *timeKeep;
@end

@implementation QViewController

@synthesize label, button, brain, progress, currentAnswer, currentQuestion, timeKeep, delegate, showStartMessage;

#define STARTTEXT @"Tryck siffra för start."

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSLog(@"initWithNibName");
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	NSLog(@"loadView");
	
}
*/

-(TimeKeeper *)timeKeep {
	if(!timeKeep) {
		timeKeep = [[ TimeKeeper alloc ] init ];
	}
	return timeKeep;
}

-(Brain*)brain {
	if(!brain) {
		brain = [[ Brain alloc ] init ];
	}
	return brain;
}

- (void)updateLabel {
	if(self.currentAnswer > -1) {
		self.label.text = [NSString stringWithFormat:@"%@%d", [self.currentQuestion printQuestion ], self.currentAnswer];
	} else {
		self.label.text = [NSString stringWithFormat:@"%@", [self.currentQuestion printQuestion ]];
	}
}

- (void)finished {
	// NSLog(@"Finished: %@", self.timeKeep);
	// self.label.text = [NSString stringWithFormat:@"Tid: %@", [ TimeKeeper formatTime:[ self.timeKeep elapsed ]]]; 
	self.currentAnswer = 9999;
	
	[self.delegate resultingTime:self.timeKeep.elapsed ];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)showNext {
	float prog; 
	if([ self.brain calculationsLeft] == 0) {
		prog = 1.0;
		[ self finished ];
	} else {
		self.currentQuestion = [ self.brain getCalculation ];
		self.label.text = [ self.currentQuestion printQuestion ];
		self.currentAnswer = -1;
		prog = 1.0-(float)([self.brain calculationsLeft]+1) / (float)[self.brain totalCalculations];
	}
	self.progress.progress = prog;
}

- (void)showNextDelayed {
	// XXX gör något snyggare. Sätter man bara t.ex. 0.1 så ser det konstigt ut.... 
	[self performSelector:@selector(showNext) withObject:nil
			   afterDelay:0.1];
}

- (void)showFirst {
	[ self showNext ];
	[ self.timeKeep reset ];
}

-(void)start {
	self.progress.progress = 0.0;
	self.currentAnswer = -1;
	
	[ brain release ];
	brain = nil;
	brain = self.brain;
	
	if(self.showStartMessage) {
		self.label.text = STARTTEXT;
	} else {
		[self showFirst ];
	}
}

- (void)reset {
	[ self start ];
}

- (IBAction)backPressed:(UIButton *)button {
	if(self.currentAnswer == 9999) {
		[ self start ];
	} else if([self.label.text isEqual:STARTTEXT] || self.currentAnswer == -1) {
		// do nothing
	} else {
		if(self.currentAnswer > 9) {
			self.currentAnswer = self.currentAnswer / 10;
		} else {
			self.currentAnswer = -1;
		}
		[ self updateLabel ];
	}
}

- (IBAction)digitPressed:(UIButton *)sender {	
	if(self.currentAnswer == 9999) {
		// do nothing 
	} else if([self.label.text isEqual:STARTTEXT]) {
		[ self showFirst ];
	} else {
		NSUInteger digit = [ sender.titleLabel.text intValue ];
		if(self.currentAnswer == -1) {
			self.currentAnswer = (int)digit;
		} else if(self.currentAnswer < 100) {
			self.currentAnswer = self.currentAnswer*10 + (int)digit;
		}
		[ self updateLabel ];
		if([ currentQuestion.result intValue] == self.currentAnswer) {
			[self showNextDelayed ];
		} else {
			[ self updateLabel ];
		}
	}
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.backItem.title = @"Avbryt";
    
    [self start];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
