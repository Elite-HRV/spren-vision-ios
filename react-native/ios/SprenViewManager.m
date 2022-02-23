#import "React/RCTViewManager.h"
#import <React/RCTUIManager.h>
#import <React/RCTLog.h>

@interface RCT_EXTERN_MODULE(SprenViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(width, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(height, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(onStateChange, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onPrereadingComplianceCheck, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onProgressUpdate, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onReadingDataReady, RCTBubblingEventBlock)

RCT_EXTERN_METHOD(cancelReading:(nonnull NSNumber *)node)
RCT_EXTERN_METHOD(setAutoStart:(nonnull NSNumber *)node autoStart: (BOOL)autoStart)
RCT_EXTERN_METHOD(getReadingData:(nonnull NSNumber *)node)

RCT_EXTERN_METHOD(captureStart:(nonnull NSNumber *)node)
RCT_EXTERN_METHOD(captureStop:(nonnull NSNumber *)node)
RCT_EXTERN_METHOD(captureLock:(nonnull NSNumber *)node)
RCT_EXTERN_METHOD(captureUnlock:(nonnull NSNumber *)node)
RCT_EXTERN_METHOD(dropComplexity:(nonnull NSNumber *)node)

RCT_EXTERN_METHOD(setTorchMode:(nonnull NSNumber *)node torchMode: (nonnull NSNumber *)torchMode)


+ (BOOL)requiresMainQueueSetup {
  return YES;
}

@end
