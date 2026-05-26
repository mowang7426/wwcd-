#import <Foundation/Foundation.h>

// 声明我们要 Hook 的类
@interface WKWallpaperBundle : NSObject
- (instancetype)initWithURL:(NSURL *)url;
@end

@interface WKWallpaperBundleManager : NSObject
- (NSArray *)defaultWallpaperBundles;
@end

%hook WKWallpaperBundleManager

// Hook 默认壁纸加载方法
- (NSArray *)defaultWallpaperBundles {
    // 获取系统原本的壁纸列表
    NSArray *originalBundles = %orig;
    NSMutableArray *modifiedBundles = [originalBundles mutableCopy];
    
    // 定义我们越狱插件存放 WWDC 壁纸包的路径
    // Rootless 越狱路径通常在 /var/jb/Library/Wallpapers/WWDC2022.wallpaper
    NSString *customWallpaperPath = @"/var/jb/Library/Wallpapers/WWDC2022.wallpaper";
    
    // 检查文件是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:customWallpaperPath]) {
        NSURL *customURL = [NSURL fileURLWithPath:customWallpaperPath];
        
        // 尝试初始化自定义的壁纸 Bundle
        WKWallpaperBundle *wwdcBundle = [[%c(WKWallpaperBundle) alloc] initWithURL:customURL];
        
        if (wwdcBundle) {
            // 将我们的壁纸插入到列表最前面
            [modifiedBundles insertObject:wwdcBundle atIndex:0];
            NSLog(@"[WWDC22PosterEnabler] 成功注入 WWDC 2022 壁纸！");
        }
    }
    
    return [modifiedBundles copy];
}

%end
