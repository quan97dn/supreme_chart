#import "SupremeChartPlugin.h"
#if __has_include(<supreme_chart/supreme_chart-Swift.h>)
#import <supreme_chart/supreme_chart-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "supreme_chart-Swift.h"
#endif

@implementation SupremeChartPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSupremeChartPlugin registerWithRegistrar:registrar];
}
@end
