# android-cmake-project
We can use it to edit the native source code of Android.
I want complie C/C++ code on CLion, but it still unable to compile stably

### .idea
I ignored some folders by default. They defined in .idea/misc.xml.
Because most files are ignored, So CLion is working perfectly.

### How to used it
Copy `.idea`、`Cmake`、`CMakeLists.txt` to you `[Android Source Code ]`

### Cmake
Place some Android modules of Cmake files under this folder.
For example:[libutil.cmake](https://github.com/Ahren-Li/android-cmake-project/blob/master/Cmake/libcutils.cmake):
  It defined source files, C / C ++ Flag, dependent

### Why do you need it
![pic](https://github.com/Ahren-Li/image/blob/master/android-cmake-project/test.png)

### Bugs
Here are some strange errors.
![error](https://github.com/Ahren-Li/image/blob/master/android-cmake-project/error.png)

But, It defined in
![error1](https://github.com/Ahren-Li/image/blob/master/android-cmake-project/error1.png)

### Anyway
If you have any suggestion or solution, welcome to discuss.