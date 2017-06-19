//
//  FrontViewController.m
//  Mult
//
//  Created by Peter Parnes on 2/7/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import "FrontViewController.h"
#import "HighScoreViewController.h"
#import "HighScoreAddViewController.h"

@interface FrontViewController()

@property (nonatomic, retain) QViewController *qvc; 
@property (nonatomic, retain) HighScoreViewController *hsvc; 

@end

@implementation FrontViewController

@synthesize mainLabel, startButton, qvc, hsvc;

#define APPNAME @"Multi"

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */


-(void)setTitle {
	self.title = APPNAME;
	self.navigationController.navigationBar.backItem.title = APPNAME;
}

-(id)init {
	if(self = [ super init ]) {
		resultTime = -1;
		showAddHighScore = NO;
	}
	return self;
}

-(QViewController *)qvc {
	if(!qvc) {
		qvc = [[ QViewController alloc ] init ];
		qvc.delegate = self;
	}
	return qvc;
}

-(HighScoreViewController *)hsvc {
	if(!hsvc) {
		hsvc = [[ HighScoreViewController alloc ] init ];
		// qvc.delegate = self;
	}
	return hsvc;
}


-(void)showWelcome {
	self.mainLabel.text = [NSString stringWithFormat: 
						   @"Välkommen till %@!\n\nHär kan du öva på multiplikationstabellen!\n\nPassa på och utmana dina vänner!", APPNAME ];
}

- (void)showSecondLabel {
	[self.mainLabel setFont:[UIFont systemFontOfSize:36]];
}

- (void)resultingTime:(NSTimeInterval)time {
	resultTime = time;
	if([[self.hsvc getKeeper] gotIn:time]) {
		addHighScoreLaunched = NO;
		showAddHighScore = YES;
	}
	
}

-(void)launchQView {
	resultTime = -2;
	addHighScoreLaunched = NO;
	[self.qvc reset];
	self.qvc.navigationItem.title = APPNAME;
	[self.navigationController pushViewController:self.qvc animated:YES];
	// self.navigationController.navigationBar.backItem.title = @"Avbryt";
    self.title = @"Avbryt";
}

-(void)launchHighScore {
	self.hsvc.navigationItem.title = @"Topplista";
	[self.navigationController pushViewController:self.hsvc animated:YES];
	// self.navigationController.navigationBar.backItem.title = @"";	
}

-(void)launchAddHighScore {
	if(!addHighScoreLaunched) {
		// self.hsvc.navigationItem.title = @"Topplista";
		
		HighScoreAddViewController *hsavc = [[ HighScoreAddViewController alloc ] init ];
		hsavc.time = resultTime;
		hsavc.keeper = [ self.hsvc getKeeper ];
		hsavc.navigationItem.title = @"Grattis";
		[self.navigationController pushViewController:hsavc animated:YES];
		self.navigationController.navigationBar.backItem.title = @"Avbryt";
		[hsavc release];
		addHighScoreLaunched = YES;
	}
}

- (IBAction)startPressed:(UIButton *)sender {
	[ self launchQView ];
}

- (void)viewWillAppear:(BOOL)animated {
    [ self setTitle ];

	[ super viewWillAppear:animated ];
	
	if(resultTime == -2) {
		[ self showSecondLabel ];
		self.mainLabel.text = @"Åhh nej!\nDu avslutade inte!\nFörsök igen!";
	} else if (resultTime > -1) {
		[ self showSecondLabel ];
		self.mainLabel.text = [ NSString stringWithFormat:@"Grattis!\n\nDin tid blev\n%.2fs.", resultTime];
	}
}


- (void)viewDidAppear:(BOOL)animated {
	[ super viewDidAppear:animated ];
	
	if (showAddHighScore) {
		showAddHighScore = NO;
		[ self launchAddHighScore ];
	}
}

- (void)addHighScoreButton {
	// Add our custom add button as the nav bar's custom right view
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithTitle:@"Topplista"
																   style:UIBarButtonItemStylePlain
																  target:self
																  action:@selector(launchHighScore)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle];
	[self addHighScoreButton ];
	[self showWelcome];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
