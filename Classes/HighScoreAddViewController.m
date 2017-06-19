//
//  HighScoreAddViewController.m
//  Mult
//
//  Created by Peter Parnes on 2/10/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import "HighScoreAddViewController.h"


@implementation HighScoreAddViewController

@synthesize textView, nameLabel, textField, button, time, keeper;

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

#define USERNAMEKEY @"username"

-(NSString *)getName {
	NSUserDefaults *prefs = [ NSUserDefaults standardUserDefaults ];
	NSString *name = [ prefs objectForKey:USERNAMEKEY ];
	if(!name || [ name length ] == 0) {
		name = @"Multi"; // "NSFullUserName();
		NSArray *parts = [ name componentsSeparatedByString:@" "];
		if([parts count] > 0) { 
			name = [ parts objectAtIndex:0 ];
		}
	}
	return name;
}

-(void)saveUserName:(NSString *)name {
	NSUserDefaults *prefs = [ NSUserDefaults standardUserDefaults ];
	[ prefs setObject:name forKey:USERNAMEKEY ];
	[ prefs synchronize ];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.textView.text = [ NSString stringWithFormat:@"Grattis!\nDu kom in på topplistan med tiden %.2fs.", self.time ];
	self.textField.text = [ self getName ];
}

- (IBAction)addPressed:(UIButton *)sender {
	NSString *name = self.textField.text;
    if([name length] == 0 || [ name isEqualToString:@"Mobile"]) {
		name = @"Multi";
	}
	[ self saveUserName:name ];
	
	[ self.keeper addScore:time withName:name ];
	
	[ self.navigationController popViewControllerAnimated:YES ];
	// [ self.navigationController popToRootViewControllerAnimated:YES ];

}

- (IBAction)editingDidEnd:(id)sender {
    [ self addPressed:NULL ];
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
