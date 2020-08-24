# android-cmake-project

We can read and modify android native C/C++ code through this project.
We can compile our own Android C/C++ code to run on Android devices.
Of course, all of this is based on CLion, thanks to the CLion team.

* Automatically finds the path to the module.
* Automatically parses the module's android.mk or android.bp file.
* Automatic resolution of module dependencies.
* Automatically adds the module and its dependent module's C/C++ source files.
* So you can use CLion's auto-jump feature. This is a great help for us to read the code.
* I configured toolchian to compile our own C/C++ programs and to rely on Android's native libraries.

For Android.mk:
* Only simple built-in functions for makefiles are supported

For Android.bp:
* Some bp file styles are not supported.

May later use `soong` to solve these problems.

## Test Environment
- Android N/O/P/Q source tree
- Ubuntu 16.04
- Windows 10 && Android NDK R21
- Clion 2019.3.2

## Depend
- Fully compiled android source tree
- Linux: ${your android source path}/prebuilts/clang/host/linux-x86/clang-xxxxxx
- Windows: Android NDK

## Description
* .idea  
I ignored some folders by default. They defined in .idea/misc.xml.

## How to use it
### 
```bash
cp -r $(path)/android-cmake-project/.idea $(android_source_tree)/
ln -s $(path)/android-cmake-project/CMakeModule $(android_source_tree)/CMakeModule
ln -s $(path)/android-cmake-project/CMakeLists.txt $(android_source_tree)/CMakeLists.txt
```
### Configure your own environment
android-cmake-project/CMakeModule/android.env.cmake

|        Property         |   value   | description |
| ----------------------- | --------- | ----------- |
|  TARGET_BOARD_HARDWARE  |  string   | Fill in the string you got through `get_build_var` |
|  ANDROID_LUNCH          |  string   | Your own android `lunch` target    |
|  ANDROID_SDK_VERSION    |  string   | 19-29...    |
|  ANDROID_TARGET_ARCH    | arm/arm64 | lunch target `arch`, form `TARGET_ARCH` |
|  ANDROID_ARCH_VARIANT   |  string   | armv7-a,armv8-a,... form `TARGET_ARCH_VARIANT` |
|  ANDROID_CPU_VARIANT    |  string   | cortex-a53,... form `TARGET_CPU_VARIANT` |
|  ANDROID_ABI            | arm64-v8a/armeabi-v7a | Compile to generate binary abi |
|  ANDROID_NDK            | path      | android ndk path |
|  ANDROID_CLANG_VERSION  | string    | clang-4691093(Android p) |

android-cmake-project/CMakeModule/android.module.cmake
```cmake
# load libsurfaceflinger(SHARED LIB) and its dependencies
parseAndroidMK(libsurfaceflinger ${MK_SHARED})
# load init(EXECABLE) and its dependencies
parseAndroidMK(init ${MK_EXECAB})
```
|    Property     | description |
| --------------- | ----------- |
|    MK_EXECAB    |   module of execable target    |
|    MK_SHARED    |   string of shared libs target |
|    MK_STATIC    |   string of static libs target |

## Why do you need it
It can help CLion to generate the file map correctly.
![pic](https://www.lili.kim/2018/11/24/android/Use%20CLion%20import%20Android%20code/test.png)
It can conveniently help us develop our own Android Native Service.
![2](https://www.lili.kim/2018/11/24/android/Use%20CLion%20import%20Android%20code/test2.png)