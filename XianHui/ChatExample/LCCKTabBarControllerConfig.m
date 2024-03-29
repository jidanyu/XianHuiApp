//
//  LCCKTabBarControllerConfig.m
//  CYLTabBarController
//
//  Created by 微博@iOS程序犭袁 ( http://weibo.com/luohanchenyilong/ ) on 10/20/15.
//  Copyright © 2015 https://github.com/ChenYilong . All rights reserved.
//

#import "LCCKTabBarControllerConfig.h"
#import <AVOSCloud/AVOSCloud.h>
#import "LCChatKitExample.h"
#import "LCCKContactManager.h"
#import "NSObject+LCCKHUD.h"
#import "FTPopOverMenu.h"
#import "LCCKExampleConstants.h"

#if __has_include(<ChatKit/LCChatKit.h>)
#import <ChatKit/LCChatKit.h>
#else
#import "LCChatKit.h"
#endif

#import "XianHui-Swift.h"

@interface LCCKTabBarControllerConfig ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;
@property (nonatomic, strong) LCCKConversationListViewController *firstViewController;
@property (nonatomic, strong) LCCKContactListViewController *secondViewController;

@end

@implementation LCCKTabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)allPersonIds {
    NSArray *allPersonIds = [[LCCKContactManager defaultManager] fetchContactPeerIds];
    return allPersonIds;
}

- (NSArray *)viewControllers {
    
    MessageListVC *firstViewController = [[MessageListVC alloc] init];
    
    firstViewController.navigationItem.rightBarButtonItem = ({
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [addButton addTarget:self action:@selector(showPopOverMenu:event:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
        rightBarButtonItem;
    });
    
    self.firstViewController = firstViewController;
    BaseNavigationController *firstNavigationController = [[BaseNavigationController alloc]
                                                       initWithRootViewController:firstViewController];
    
    //联系人
    NSArray *userIds = [ChatKitExample getAllUserIds];
    
    NSLog(@"-----------------%@",userIds);
    
    
    NSArray *users = [[LCChatKit sharedInstance] getProfilesForUserIds:userIds error:nil];
    
    NSString *currentClientID = [[LCChatKit sharedInstance] clientId];
    
    
    ContactListVC *secondViewController = [[ContactListVC alloc] initWithContacts:[NSSet setWithArray:users] userIds:[NSSet setWithArray:userIds] excludedUserIds:[NSSet setWithArray:@[currentClientID]] mode:LCCKContactListModeNormal];
    
    self.secondViewController = secondViewController;
    [secondViewController setSelectedContactCallback:^(UIViewController *viewController, NSString *peerId) {
        [ChatKitExample exampleOpenConversationViewControllerWithPeerId:peerId fromNavigationController:self.tabBarController.navigationController];
    }];
//    [secondViewController setDeleteContactCallback:^BOOL(UIViewController *viewController, NSString *peerId) {
//        return [[LCCKContactManager defaultManager] removeContactForPeerId:peerId];
//    }];
    BaseNavigationController *secondNavigationController = [[BaseNavigationController alloc]
                                                        initWithRootViewController:secondViewController];
    
    //Mine VC
    UserCentreVC *thirdVC = [[UserCentreVC alloc] init];
    BaseNavigationController *thirdNavigationController = [[BaseNavigationController alloc]
                                                       initWithRootViewController:thirdVC];
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController
                                 ];
    return viewControllers;
    
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"消息",
                            CYLTabBarItemImage : @"tabbar_chat_normal",
                            CYLTabBarItemSelectedImage : @"tabbar_chat_active",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"联系人",
                            CYLTabBarItemImage : @"tabbar_contacts_normal",
                            CYLTabBarItemSelectedImage : @"tabbar_contacts_active",
                            };
    
    
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"设置",
                            CYLTabBarItemImage : @"tabbar_settings_normal",
                            CYLTabBarItemSelectedImage : @"tabbar_settings_active",
                            };
    
    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2,
                                       dict3
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    tabBarController.tabBarHeight = 49.f;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:187.0/255 green:198.0/255 blue:210.0/255 alpha:1.0];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:211.0/255 green:184.0/255 blue:141.0/255 alpha:1.0];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    UITabBarController *tabBarController = [self cyl_tabBarController] ?: [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor redColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)createGroupConversation:(id)sender {
    [LCChatKitExample exampleCreateGroupConversationFromViewController:self.firstViewController];
}

-(void)openReadQRCodeVC{
    [ChatKitExample openQRCodeVCForm:self.firstViewController];
}

- (NSString *)arc4randomString {
    int a = arc4random_uniform(100000000);
    NSString *arc4randomString = [NSString stringWithFormat:@"%@", @(a)];
    return arc4randomString;
}

- (void)addFriend {
    NSString *additionUserId = self.arc4randomString;
    NSMutableSet *addedUserIds = [NSMutableSet setWithSet:self.secondViewController.userIds];
    [addedUserIds addObject:additionUserId];
    self.secondViewController.userIds = [addedUserIds copy];
}

- (void)showPopOverMenu:(UIBarButtonItem *)sender event:(UIEvent *)event {
    [FTPopOverMenu showFromEvent:event
                        withMenu:@[ @"扫一扫" ]
                       doneBlock:^(NSInteger selectedIndex) {
                           if (selectedIndex == 0) {
                               //[self createGroupConversation:sender];
                               [self openReadQRCodeVC];
                               
                           }
                       } dismissBlock:nil];
}


- (void)changeGroupAvatar {
    [LCChatKitExample exampleChangeGroupAvatarURLsForConversationId:@"570da6a9daeb3a63ca5b07b0"];
}

@end
