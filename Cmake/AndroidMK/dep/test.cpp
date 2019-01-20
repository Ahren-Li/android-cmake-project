//
// Created by lili on 19-1-15.
//

#include <ext4_crypt.h>
#include <fs_mgr.h>
#include <cstdio>
#include "test.h"

int main(int argc, char** argv){
#ifdef SF_RK3399
    printf("hello word SF_RK3399\n");
#endif
#ifdef SF_RK3288
    printf("hello word SF_RK3288\n");
#endif

#ifdef NO_FUNC
    printf("hello word NO_FUNC\n");
#endif

#ifdef HAVE_FUNC
    printf("hello word NO_FUNC\n");
#endif
}
