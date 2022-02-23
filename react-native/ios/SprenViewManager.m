#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(SprenViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(width, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(height, NSNumber)

+ (BOOL)requiresMainQueueSetup {
  return YES;
}

@end
