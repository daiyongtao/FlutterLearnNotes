//
//  FlutterHelp.m
//
//  Created by 戴永涛 on 2019/3/10.
//

#import "FlutterHelp.h"

@implementation FlutterHelp

/**
 * --------------------------------------------------------------------------
 1.小tips
 检查flutter渠道，由于在beta分支下，无法不支持生成Flutter module的。
 >> flutter channel 检查渠道
 >> flutter channel master 切换到master分支
 >> flutter create -t module flutter_module
 
 2.输入完flutter doctor之后，出现两个警告
 需要输入完下面的指令后，在进行检测。
 iOS toolchain - develop for iOS devices
 ✗ Xcode installation is incomplete; a full installation is necessary for iOS development.
 Download at: https://developer.apple.com/xcode/download/
 Or install Xcode via the App Store.
 Once installed, run:
 sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
 
 ✗ Verify that all connected devices have been paired with this computer in Xcode.
 If all devices have been paired, libimobiledevice and ideviceinstaller may require updating.
 To update, run:
 brew uninstall --ignore-dependencies libimobiledevice
 brew install --HEAD libimobiledevice
 brew install ideviceinstaller

 3.关于cocoapods和非cocoapods管理flutter
 一、如果是用cocoaPods管理Flutter，
 1.flutter_application_path = '/Users/DYT/Desktop/demo/Flutter项目/flutter_module/'
 eval(File.read(File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')), binding)
 flutter_application_path 是你用flutter create创建的module的绝对路径。
 
 2.不需要创建xcconfig胶合文件，但是需要在Pods-MyApp.debug.xcconfig和Pods-MyApp.release.xcconfig里添加包含
 #include "/Users/DYT/Desktop/demo/Flutter项目/flutter_module/.ios/Flutter/Generated.xcconfig"
 
 3.添加run script里需要写两行
 "$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" build
 "$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" embed
 
 在修改文件完lib/main.dart时，需要先运行run工程，然后再运行我们MyApp，就可以看到界面上出现对应的修改。
 
 二、如果不用cocoaPods管理
 1.需要创建三个xcconfig胶合文件
 至于在博客http://www.jintiankansha.me/t/UUElfwze78里说要把Flutter.xcconfig和Debug.xcconfig、Release.xcconfig分开路径创建，其实没必要。两种创建方式我都试过了，都没问题。所以就在Xcode项目里把三个都创建好，关键是路径一定要写对。
 Debug.xcconfig ：
 #include "Flutter.xcconfig”
 #include "Pods/Target Support Files/Pods-HaHaIOS/Pods-HaHaIOS.debug.xcconfig" // 如果项目用cocopods管理其他第三方库，需要添加
 Release.xcconfig：就换成对应的release就好。
 Flutter.xcconfig：
 #include "../../../Flutter/flutter_module/.ios/Flutter/Generated.xcconfig"
 
 2.添加run script
 "$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" build
 
 3.在Xcode里操作，点击你的项目 -> 选择PROJECT -> Info -> Configurations栏目下有Debug和Release
 在最上面的选项里选择Debug或者Release，如果用了cocoaPods管理其他第三方库，下面的选项就选择pods-项目名.debug(或者release)。
 
 
 4.一切准备就绪，然后就command + b编译，按照正常来说在项目路径里，会生成一个Flutter文件夹，里面就是所需的framework和资源文件。(非常关键)
 很多人卡在这一步，查找资料看评论，在简书https://www.jianshu.com/p/5f4aaa72d509 评论里提到
 4.1.如果不报错，但是编译后并没有生成Flutter文件夹，需要修改一个配置文件。
 `$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh`，
 需要修改的代码：将三行判断注释掉。
 ```
 local derived_dir="${SOURCE_ROOT}/Flutter"
 # if [[ -e "${project_path}/.ios" ]]; then
 # derived_dir="${project_path}/.ios/Flutter"
 # fi
 RunCommand mkdir -p -- "$derived_dir"
 ```
 4.2.如果报错，那应该是run script的路径问题。一般我们在安装Flutter时，把flutter文件解压后直接扔在资源库目录下：/Users/UserName/Library/。
 然后设置环境变量，设置了路径后，可以直接使用flutter相关指令了。
 打开配置文件：open ~/.bash_profile
 在里面添加一句：export PATH="/Users/DYT/Library/flutter/bin:$PATH"
 然后保存，刷新配置文件：source ~/.bash_profile
 
 //bash_profile只有单一用户有效，文件存储位于~/.bash_profile，该文件是一个用户级的设置，可以理解为某一个用户的profile目录下。这个文件同样也可以用于配置环境变量和启动程序，但只针对单个用户有效。
 
 
 5.如果第4步通过的话，那就大功告成了，之后就是把文件夹里的东西加进去。
 
 flutter_assets资源文件拖进去的时候，需要重新加，需要选择Create folder references。
 
 可在Build Phases里查看是否成功。
 
 
 6.接下来就可以使用了。
 
 在修改文件完lib/main.dart时，直接运行我们MyApp，就可以看到界面上出现对应的修改了。
 
 
 参考博客：
 [Flutter中文网](https://flutterchina.club/setup-macos/)
 [将Flutte添加进旧项目官方wiki文档](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps#under-the-hood)
 [关于路径错误可以在这找到一些答案](https://github.com/flutter/flutter/pull/23387)
 ￼
 推荐看这篇：[Flutter与已有iOS工程混合开发与脚本配置](http://www.jintiankansha.me/t/UUElfwze78)
 [掘金：Flutter-现有iOS工程引入Flutter](https://juejin.im/post/5bda622f6fb9a022523c4da8#comment)
 [简书：iOS Native混编Flutter交互实践](https://www.jianshu.com/p/5f4aaa72d509)

 * --------------------------------------------------------------------------
 
 
 
 */


@end
