#import <Foundation/Foundation.h>

@interface Spelling : NSObject{
  NSDictionary *table;
}

- (Spelling*) initWithBuiltinTable;
- (NSString*) britishize:(NSString*)string;
@end