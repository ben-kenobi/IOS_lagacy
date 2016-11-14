//
// Copyright (c) 2014 Marin Usalj | supermar.in
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ATZSegmentedControl.h"
#import "ATZSegmentedCell.h"

@implementation ATZSegmentedControl

+ (Class)cellClass {
    return [ATZSegmentedCell class];
}

// The custom cellClass will not be loaded properly if the view is init'd from IB.
// https://mikeash.com/pyblog/custom-nscells-done-right.html
- (instancetype)initWithCoder:(NSCoder *)origCoder
{
    NSKeyedUnarchiver *coder = (NSKeyedUnarchiver *)origCoder;

    // gather info about the superclass's cell and save the archiver's old mapping
    Class superCell = [[self superclass] cellClass];
    NSString *oldClassName = NSStringFromClass(superCell);
    Class oldClass = [coder classForClassName:oldClassName];
    if (!oldClass) {
        oldClass = superCell;
    }

    // override what comes out of the unarchiver
    [coder setClass:[[self class] cellClass] forClassName:oldClassName];

    // unarchive
    self = [super initWithCoder:coder];
    if (!self) {
        return nil;
    }

    // set it back
    [coder setClass:oldClass forClassName:oldClassName];


    return self;
}

@end
