
#import "MTLogging.h"

#if defined(LOGING_TO_FILE) && LOGING_TO_FILE

void redirectConsoleLogToDocumentFolder()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *logPath = [documentsDirectory 
                         stringByAppendingPathComponent:@"console.log"];
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
}

#endif // defined(LOGING_TO_FILE) && LOGING_TO_FILE