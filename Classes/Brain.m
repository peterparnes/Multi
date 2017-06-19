//
//  Brain.m
//  Mult
//
//  Created by Peter Parnes on 2/6/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import "Brain.h"
#import "Calculation.h"

@interface Brain() 
@property (nonatomic, retain) NSMutableArray* calculations;
@end

@implementation Brain

@synthesize calculations;

- (NSUInteger)totalCalculations {
	return totalCalculations;
}

- (NSMutableArray *)calculations {
	if(!calculations) {
		calculations = [ [ NSMutableArray arrayWithCapacity:36 ] retain ];
	}
	return calculations;
}

#define UPTO 9

- (void)setup {
	int max = 2;
	int min = 2;
	int start = 2; 
	for (int y = min; y <= UPTO; y++) {
		for(int x = start; x <= max; x++ ) {
			Calculation *calc = [[ Calculation alloc ] init ];
			if(arc4random()%2 == 1) {
				calc.num1 = [NSNumber numberWithInt:x];
				calc.num2 = [NSNumber numberWithInt:y];
			} else {
				calc.num1 = [NSNumber numberWithInt:y];
				calc.num2 = [NSNumber numberWithInt:x];
			}
			calc.operation = @"*";
			calc.result = [NSNumber numberWithInt:(x * y)];
			[ self.calculations addObject:calc ];	
			// [ calc release ]; // How should memory be handled here?? 
		}
		max++;
	}
	totalCalculations = [self.calculations count ];
	// NSLog(@"Number of calculations: %d", totalCalculations );
}

-(void)dumpNumbers {
	for(int i = 0; i < [self.calculations count]; i++ ) {
		NSLog(@"%@", [[self.calculations objectAtIndex:i] print ]);
	}
}

-(id)init {
	self = [ super init];
	if(self) {
		[self setup];
		// [self dumpNumbers];
	}
	return self;
}

- (NSUInteger)calculationsLeft {
	
	return [ self.calculations count ];
}

- (Calculation*)getCalculation {
	// NSLog(@"getCalculation");
	int index = arc4random() % [ self.calculations count ];
	Calculation *result = [ self.calculations objectAtIndex:index ];
	[ self.calculations removeObjectAtIndex:index ];
	return result;
}

@end
