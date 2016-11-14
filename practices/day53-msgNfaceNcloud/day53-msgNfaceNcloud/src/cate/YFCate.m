

#import <Foundation/Foundation.h>
BOOL emptyStr(NSString *str){
    return !str||!str.length;
}


NSTimer * iTimer(CGFloat inteval,id tar,SEL sel,id userinfo){
    NSTimer *timer=[NSTimer timerWithTimeInterval:inteval target:tar selector:sel userInfo:userinfo repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

CADisplayLink *iDLink(id tar,SEL sel){
    CADisplayLink *link= [CADisplayLink displayLinkWithTarget:tar selector:sel];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return link;
}