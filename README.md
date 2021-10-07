# android-cmake-project

[中文](https://github.com/Ahren-Li/android-cmake-project/blob/automatic/README_zh-CN.md)

## Background
To import C/C++ code for Android Native using Clion, implement code hinting, custom module compilation. 

Currently supports.
* Automatically find the path where `Android.mk`, `Android.bp` of the configuration module is located.
* Automatically parse `Android.mk`, `Android.bp` under the module path.
* Automatically parse the source and header files of the module.
* Automatically parse module dependencies, and dependent header paths.
* Automatically parse some (some syntax complex can't be parsed) C/C++ Flags.
* Generate **rough** CMakeList.txt via `Android.mk`, `Android.bp`.
* Configured global Clang environment to support cross-compilation of custom C/C++ projects on CLion (need to write CMakeList.txt by yourself).

Known issues:
* Complex syntax cannot be parsed.
* Android HIDL module does not parse properly.
* Cross-compilation may not work properly.

The above problem may have to wait for my new project `AndroidCMakeSoong` to be solved.
For now it is still up to the point where it works.
* Most of the modules can parse the source files normally, and the header files can be parsed normally in most cases, so it is helpful for code hinting.
* The dependency part of the header file can also be parsed normally, so the hints for other modules can also be done, the most typical ones are `libutils` and `libcutils`.
* You can add your own C/C++ projects and easily configure dependencies to achieve code hinting accessibility.
* You can use CLion to compile your own C/C++ projects and then PUSH them to your own device for testing, no need to use `mm` anymore.

For pure use the CMake language has been very good, the project I have been using at work for two years and it is still good to use.
Here are two screenshots.
1. code jumping.
![pic](https://www.lili.kim/2018/11/24/android/Use%20CLion%20import%20Android%20code/test.png)
2. Successful compilation of libcutils.so.
![2](https://www.lili.kim/2018/11/24/android/Use%20CLion%20import%20Android%20code/test2.png)

## Install
```shell
git clone https://github.com/Ahren-Li/android-cmake-project.git
```
## Dependency
- Complete compiled Android source code.
- For Linux: ${your source path}/prebuilts/clang/host/linux-x86/clang-xxxxxx, determine which version of Clang you are using
- For Windows: requires Android NDK R21+

## Usage
```shell
cp -r $(path)/android-cmake-project/.idea $(android_source_tree)/
ln -s $(path)/android-cmake-project/CMakeModule $(android_source_tree)/CMakeModule
ln -s $(path)/android-cmake-project/CMakeLists.txt $(android_source_tree)/CMakeLists.txt
```
### .idea Folders
I pre-configured part of the ignore folder for Clion and they are defined in .idea/misc.xml, which improves the loading speed.

### Configure your project environment
Environment configuration path (2 options):
1. android-cmake-project/CMakeModule/android.env.cmake
2. touch $(android_source_tree)/android.env.cmake

|        CMake Property   |   Value   | Description |
| ----------------------- | --------- | ----------- |
|  TARGET_BOARD_HARDWARE  |  string   | Get the value via `get_build_var` |
|  ANDROID_LUNCH          |  string   | Target for `lunch`, no `-user/-userdebug`  |
|  ANDROID_SDK_VERSION    |  string   | 19-29...    |
|  ANDROID_TARGET_ARCH    | arm/arm64 | The output of `TARGET_ARCH` after lunch |
|  ANDROID_ARCH_VARIANT   |  string   | The output of `TARGET_ARCH_VARIANT` after lunch |
|  ANDROID_CPU_VARIANT    |  string   | The output of `TARGET_CPU_VARIANT` after lunch |
|  ANDROID_ABI            | arm64-v8a/armeabi-v7a | Configure CMake to compile 64/32 executables |
|  ANDROID_NDK            | path      | android ndk path |
|  ANDROID_CLANG_VERSION  | string    | clang-4691093(Android p)，You can configure it according to your own source code |

### Configure project modules
Module configuration path
1. android-cmake-project/CMakeModule/android.module.cmake

```cmake
# Load the dynamic library libsurfaceflinger and its dependencies
parseAndroidMK(libsurfaceflinger ${MK_SHARED})
# Load the executable init and its dependencies
parseAndroidMK(init ${MK_EXECAB})
```

Explanation of the second parameter of `parseAndroidMK`
|    CMake Property     | Description |
| --------------- | ----------- |
|    MK_EXECAB    |   Name of dynamic executable module in Android MK/BP |
|    MK_SHARED    |   Name of dynamic library module in Android MK/BP |
|    MK_STATIC    |   Name of static library module in Android MK/BP |

### Configure your custom C/C++ modules
1. android-cmake-project/CMakeLists.txt has pre-written loading code.
```cmake
if(EXISTS ${CMAKE_CURRENT_LIST_DIR}/android-test/CMakeLists.txt)
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/android-test)
endif()
```
2. Create your own `android-test` folder
```shell
mkdir $(android_source_tree)/android-test
```
3. Refer to this [CMakeList.txt](https://github.com/Ahren-Li/android-cmake-project/blob/automatic/android-test/CMakeLists.txt) to write your own module configuration.

### Test Environment
- Android N/O/P/Q source tree
- Ubuntu 16.04/18.04/20.04
- Windows 10 && Android NDK R21
- Clion 2019.3.2

## Related Efforts
[AndroidNativeDebug](https://github.com/Ahren-Li/AndroidNativeDebug)
* Clion plugin: Debugging Native programs with Clion and LLDB.
[AndroidCMakeSoong(ing)]()

## Maintainers
Ahren Li(liliorg@163.com)

## Contributing
Github Push Request.

## License

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