#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(SprenViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(color, NSString)

+ (BOOL)requiresMainQueueSetup {
  return NO;
}

@end
