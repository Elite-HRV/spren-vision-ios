#import "SprenFlutterPlugin.h"
#if __has_include(<spren_flutter/spren_flutter-Swift.h>)
#import <spren_flutter/spren_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "spren_flutter-Swift.h"
#endif

@implementation SprenFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSprenFlutterPlugin registerWithRegistrar:registrar];
}
@end
