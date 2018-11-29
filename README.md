# android-cmake-project
We can use it to edit the native source code of Android.
It can compile c/c++ code and run in your android devices.

### .idea
I ignored some folders by default. They defined in .idea/misc.xml.
Because most files are ignored, So CLion is working perfectly.

### How to used it
Copy all file  to your `[Android Source Code ]`, and configure your environment
```makefile
#env_android.cmake
set(ANDROID_LUNCH rk3399_box)
set(ANDROID_TARGET_ARCH arm64)
set(ANDROID_ABI "arm64-v8a")
set(ANDROID_TOOLCHAIN_NAME "clang")
set(ANDROID_STL c++_static)
```
### Cmake
Place some Android modules of Cmake files under this folder.
For example:[libcutil.cmake](https://github.com/Ahren-Li/android-cmake-project/blob/master/Cmake/libcutils.cmake):
  It defined source files, C / C ++ Flag, dependent

### Why do you need it
![pic](https://www.lili.kim/2018/11/24/android/Use%20CLion%20import%20Android%20code/test.png)
![2](https://www.lili.kim/2018/11/24/android/Use%20CLion%20import%20Android%20code/test2.png)

### Bugs

### Anyway
If you have any suggestion or solution, welcome to discuss.