# android-cmake-project
We can use it to edit the native source code of Android. 
It can compile c/c++ code and run in your android devices, but the compilation may fail. 
You just need to provide the name of the module. 

- Automatically find the module path
- Support `if`、`ifeq`、`ifneq`、`strip`、`filter`
- **Automatically parse Android.mk conversion to cmake configuration**
- **Automatically parse module's dependencies**
- **Automatically parse module's include dirs**
- **Automatically parse module's definitions**

### Test environment
- Android N source tree
- Ubuntu 16.04

### Depend
- Fully compiled android source tree
- ${your android source path}/prebuilts/clang/host/linux-x86/clang-2690385

### .idea
I ignored some folders by default. They defined in .idea/misc.xml.
Because most files are ignored. So CLion is working perfectly.

### env_android.cmake
Define your own Android environment.

### How to use it
Copy or link all file  to your `[Android Source Code]`,  and configure your own environment
for example:
```makefile
#env_android.cmake
set(ANDROID_LUNCH rk3399_box)
set(ANDROID_TARGET_ARCH arm64)
set(ANDROID_ABI "arm64-v8a")
set(ANDROID_TOOLCHAIN_NAME "clang")
set(ANDROID_STL c++_static)
```

|        Property         |   value   | description |
| ----------------------- | --------- | ----------- |
|  ANDROID_LUNCH          | string |your own android lunch target    |
|  ANDROID_TARGET_ARCH    | arm/arm64 |lunch target arch    |
|  ANDROID_ABI            | arm64-v8a/armeabi-v7a | clion complie abi |
|  ANDROID_TOOLCHAIN_NAME | clang | toolchan, currently only supports clang |
|  ANDROID_STL            | N/A | future support content |

In CMakeLists.txt
```Makefile
# init all module
loadMoudle()
# load adbd(EXECABLE) and its dependencies
parseAndroidMK(adbd ${MK_EXECAB})
# load init(EXECABLE) and its dependencies
parseAndroidMK(init ${MK_EXECAB})
```
|    Property     | description |
| --------------- | ----------- |
|    MK_EXECAB    |   module of execable target    |
|    MK_SHARED    |   string of shared libs target |
|    MK_STATIC    |   string of static libs target |

### Why do you need it

It can help clion complete function relation jump mapping.

![pic](https://www.lili.kim/2018/11/24/android/Use%20CLion%20import%20Android%20code/test.png)
Can help clion compile android native module, but currently only libcutil can be compiled, because we need to configure the dependencies of each module.
![2](https://www.lili.kim/2018/11/24/android/Use%20CLion%20import%20Android%20code/test2.png)

### Bugs
- not support windows
- not support `include xxx.mk` in Android.mk
- not support make function:`all-makefiles-under` ......
- not support Android.bp

### Future support
- used on Windows
- support make function
- Android.bp

### Anyway
If you have any suggestion or solution, welcome to discuss.