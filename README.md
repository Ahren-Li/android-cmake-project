# android-cmake-project
We can use it to edit the native source code of Android.
It can compile c/c++ code and run in your android devices, but the compilation may fail.

### .idea
I ignored some folders by default. They defined in .idea/misc.xml.
Because most files are ignored. So CLion is working perfectly.

### Cmake
Place some Android modules of Cmake files under this folder.  
For example:[libcutil.cmake](https://github.com/Ahren-Li/android-cmake-project/blob/master/Cmake/libcutils.cmake)

### env_android.cmake
Define your own Android environment.

### How to use it
Copy all file  to your `[Android Source Code]`,  and configure your own environment
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



### Why do you need it

It can help clion complete function relation jump mapping.

![pic](https://www.lili.kim/2018/11/24/android/Use%20CLion%20import%20Android%20code/test.png)
Can help clion compile android native module, but currently only libcutil can be compiled, because we need to configure the dependencies of each module.
![2](https://www.lili.kim/2018/11/24/android/Use%20CLion%20import%20Android%20code/test2.png)

### Bugs

### Future support
- Simpler dependency definition
- More module definitions
- More module compilation support

### Anyway
If you have any suggestion or solution, welcome to discuss.