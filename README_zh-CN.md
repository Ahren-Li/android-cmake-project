# android-cmake-project

## 项目背景
为了使用Clion导入Android Native的C/C++代码，实现代码提示，自定义模块编译。 

目前支持：
* 自动寻找配置模块的`Android.mk`，`Android.bp`所在路径。
* 自动解析模块路径下的`Android.mk`，`Android.bp`。
* 自动解析模块的源文件和头文件。
* 自动解析模块的依赖，以及依赖的头文件路径。
* 自动解析部分（有些语法复杂的无法解析）C/C++ Flags。
* 通过`Android.mk`，`Android.bp`生成**粗略**的CMakeList.txt。
* 配置了全局的Clang环境，支持在CLion上对自定义C/C++项目进行交叉编译（需要自行编写CMakeList.txt）。

已知问题:
* 复杂语法无法解析。
* Android HIDL模块无法正常解析。
* 交叉编译可能无法正常工作。

上面的问题可能需要等待我的新项目`AndroidCMakeSoong`才能解决。
目前还是达到了可以使用的程度：
* 大部分模块能正常解析源文件，头文件大概率也能正常解析，所以对于代码提示很有帮助。
* 依赖部分的头文件也能正常解析，所以对于其他模块的提示也是能做到，最典型的比如`libutils`，`libcutils`。
* 可以自己添加自己C/C++项目，并且可以很容易的配置依赖，达到代码提示无障碍的效果。
* 可以使用CLion编译自己的C/C++项目，再PUSH到自己的设备测试，无需再使用`mm`。

对于纯粹的使用CMake语言已经非常不错了，该项目我已经在工作中使用了两年，使用起来还是不错的。
下面是两个截图：
1. 代码跳转。
![pic](https://www.lili.kim/2018/11/24/android/Use%20CLion%20import%20Android%20code/test.png)
2. libcutils.so 的成功编译。
![2](https://www.lili.kim/2018/11/24/android/Use%20CLion%20import%20Android%20code/test2.png)

## 安装
```shell
git clone https://github.com/Ahren-Li/android-cmake-project.git
```
## 依赖
- 完整编译完成的Android源码
- 对于Linux: ${你的源码路径}/prebuilts/clang/host/linux-x86/clang-xxxxxx，确定你使用Clang的版本
- 对于Windows: 需要Android NDK R12+

## 使用
```shell
cp -r $(path)/android-cmake-project/.idea $(android_source_tree)/
ln -s $(path)/android-cmake-project/CMakeModule $(android_source_tree)/CMakeModule
ln -s $(path)/android-cmake-project/CMakeLists.txt $(android_source_tree)/CMakeLists.txt
```
### .idea文件夹
我预先为Clion配置好了一部分忽略文件夹，它们定义在.idea/misc.xml，这样可以提高加载速度。

### 配置你的项目环境
环境配置路径（2选1）：
1. android-cmake-project/CMakeModule/android.env.cmake
2. 新建$(android_source_tree)/android.env.cmake

|        CMake变量         |   值      | description |
| ----------------------- | --------- | ----------- |
|  TARGET_BOARD_HARDWARE  |  字符串    | 通过`get_build_var`获取值 |
|  ANDROID_LUNCH          |  字符串    | `lunch`的target，不需要-user/-userdebug    |
|  ANDROID_SDK_VERSION    |  字符串    | 19-29...    |
|  ANDROID_TARGET_ARCH    | arm/arm64 | lunch后输出的`TARGET_ARCH` |
|  ANDROID_ARCH_VARIANT   |  字符串    | lunch后输出的`TARGET_ARCH_VARIANT` |
|  ANDROID_CPU_VARIANT    |  字符串    | lunch后输出的`TARGET_CPU_VARIANT` |
|  ANDROID_ABI            | arm64-v8a/armeabi-v7a | 配置CMake编译64/32可执行程序 |
|  ANDROID_NDK            | 路径       | android ndk path |
|  ANDROID_CLANG_VERSION  | 字符串     | clang-4691093(Android p)，具体可以根据自己的源码配置 |

### 配置项目模块
模块配置路径
1. android-cmake-project/CMakeModule/android.module.cmake

```cmake
# 加载动态库libsurfaceflinger及其依赖
parseAndroidMK(libsurfaceflinger ${MK_SHARED})
# 加载可执行程序init及其依赖
parseAndroidMK(init ${MK_EXECAB})
```

`parseAndroidMK`第二个参数的解释
|    CMake变量     | 解释 |
| --------------- | ----------- |
|    MK_EXECAB    |   Android MK/BP 中可执行模块的名字 |
|    MK_SHARED    |   Android MK/BP 中动态库模块的名字 |
|    MK_STATIC    |   Android MK/BP 中静态库模块的名字 |

### 配置你自定义C/C++ 模块
1. android-cmake-project/CMakeLists.txt 已经预先写好了加载代码。
```cmake
if(EXISTS ${CMAKE_CURRENT_LIST_DIR}/android-test/CMakeLists.txt)
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/android-test)
endif()
```
2. 新建自己的`android-test`文件夹
```shell
mkdir $(android_source_tree)/android-test
```
3. 参考这个[CMakeList.txt](https://github.com/Ahren-Li/android-cmake-project/blob/automatic/android-test/CMakeLists.txt)写自己的模块配置。

### 测试环境
- Android N/O/P/Q source tree
- Ubuntu 16.04/18.04/20.04
- Windows 10 && Android NDK R21
- Clion 2019.3.2

## 相关项目
[AndroidNativeDebug](https://github.com/Ahren-Li/AndroidNativeDebug)
* 使用Clion和LLDB调试Native程序
[AndroidCMakeSoong(进行中)]()

## 主要项目负责人
Ahren Li(liliorg@163.com)

## 参与贡献方式
github push request.

## 开源协议

   Copyright [2021] [liliorg@163.com]

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.