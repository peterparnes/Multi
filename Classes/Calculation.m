//
//  Calculation.m
//  Mult
//
//  Created by Peter Parnes on 2/6/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import "Calculation.h"

@implementation Calculation

@synthesize num1, num2, result;
@synthesize operation;

- (NSString *)print {
	return [NSString stringWithFormat:@"%d %@ %d = %d", [ self.num1 intValue] , self.operation, [ self.num2 intValue ], [ self.result intValue ]];
}

- (NSString *)printQuestion {
	return [NSString stringWithFormat:@"%d %@ %d = ", [ self.num1 intValue] , self.operation, [ self.num2 intValue ]];
}

@end
