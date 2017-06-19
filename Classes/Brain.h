//
//  Brain.h
//  Mult
//
//  Created by Peter Parnes on 2/6/11.
//  Copyright 2011, 2017 Peter Parnes, Parnes Labs AB, peter@parnes.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculation.h"

@interface Brain : NSObject {
	NSMutableArray *calculations;
	NSUInteger totalCalculations;
}

- (NSUInteger)calculationsLeft;
- (NSUInteger)totalCalculations;

- (Calculation *)getCalculation;

@end
