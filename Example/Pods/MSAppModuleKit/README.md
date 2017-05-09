# MSAppModuleKit

[![Join the chat at https://gitter.im/aelam/MSAppModuleKit](https://badges.gitter.im/aelam/MSAppModuleKit.svg)](https://gitter.im/aelam/MSAppModuleKit?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![CI Status](http://img.shields.io/travis/aelam/MSAppModuleKit.svg?style=flat)](https://travis-ci.org/aelam/MSAppModuleKit)
[![Version](https://img.shields.io/cocoapods/v/MSAppModuleKit.svg?style=flat)](http://cocoapods.org/pods/MSAppModuleKit)
[![License](https://img.shields.io/cocoapods/l/MSAppModuleKit.svg?style=flat)](http://cocoapods.org/pods/MSAppModuleKit)
[![Platform](https://img.shields.io/cocoapods/p/MSAppModuleKit.svg?style=flat)](http://cocoapods.org/pods/MSAppModuleKit)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MSAppModuleKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MSAppModuleKit"
```

## Author

Ryan Wang, wanglun02@gmail.com

## License

MSAppModuleKit is available under the MIT license. See the LICENSE file for more info.

## Module Development

### Module Naming
For example: WebApp

|Column |        Name         |
|----| --------------------|
|Module | MSAppModuleWebApp   |
|Setting | MSAppSettingsWebApp |
|RepoName | MSAppModuleWebApp   |

### Create
Use `pod lib create`
Ref
[Create Module with CocoaPods](http://aelam.github.io/ios%20development/2015/09/22/cocoapods/)

#### Finder, find the current TopViewController

1. Custom your Finder 使用`[MSActiveControllerFinder setFinder:[CustomFinder new]];` Set it when app launch
2. run `[MSActiveControllerFinder finder]`, You can get the a Finder，If you just don't implement it by yourself, `[MSActiveControllerFinder finder]` will give you a TopViewController which is based on a UITabBarController+UINavigationControllers structure
3. Before you route you can execute `[MSActiveControllerFinder finder].resetStatus();` (implement by yourself). Usually You can close your sliderController if needed


#### Development
##### CocoaPods helps you a lot to isolate your module with each other, it make modules hardly to be tainted.
##### Settings can make your same module works in different apps! Or you need to do is implement all Modules' settings in a setting class

```lang=objc
id<OneOfYouModuleSettings> settings = [appModuleManager appModuleWithClass:[YourModuleClass class]].moduleSettings;
NSString *productId = settings.productId;
// ...

```
##


#### Register Routes

```lang=objc
- (void)moduleRegisterRoutes:(JLRoutes *)route {
#if USE_TRADE_FLAG
        [route addRoute:@"trade" priority:0 handler:^BOOL(NSDictionary *parameters) {
            [MSActiveControllerFinder finder].resetStatus();

            NSString *stockCode = parameters[@"stockCode"];
            NSString *tradeType = parameters[@"tradeType"];

            UINavigationController *navController = [MSActiveControllerFinder finder].activeNavigationController();
            [navController pushToTradeStockCode:[stockCode integerValue] withTradeType:[tradeType integerValue]];

            return YES;
        }];
#else
        NSLog(@"模拟器为实现买卖股票");
#endif

}

- (void)moduleUnregisterRoutes:(JLRoutes *)route {
  [route removeRoute:@"trade"]
}
```
## App Architecture
![App Architecture](img/snapshot_1.png)


## Push to Specs
[Create Module with CocoaPods](http://aelam.github.io/ios%20development/2015/09/22/cocoapods/)

## Module Tables on a server



|PageName |ModuleName | App-URL | Web-URL | pageId |
|------ | ---- | ----- |--- | ---- | ----- |
|Community| Community | community |    |  |
|Web|  WebApp    | web |    |      |
