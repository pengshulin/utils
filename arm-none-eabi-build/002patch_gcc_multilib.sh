TODO:

in gcc/config/arm/t-arm-elf find a section that looks like this (it is probably commented out with #)

MULTILIB_OPTIONS      += march=armv7
MULTILIB_DIRNAMES     += thumb2
MULTILIB_EXCEPTIONS   += march=armv7* marm/*march=armv7*
MULTILIB_MATCHES      += march?armv7=march?armv7-a
MULTILIB_MATCHES      += march?armv7=march?armv7-r
MULTILIB_MATCHES      += march?armv7=march?armv7-m
MULTILIB_MATCHES      += march?armv7=mcpu?cortex-a8
MULTILIB_MATCHES      += march?armv7=mcpu?cortex-r4
MULTILIB_MATCHES      += march?armv7=mcpu?cortex-m3

In gcc/config/arm/elf.h find the #define SUBTARGET_ASM_FLOAT_SPEC and and change it to look like this:

#define SUBTARGET_ASM_FLOAT_SPEC "%{mapcs-float:-mfloat} \
%{mhard-float:-mfpu=fpa} \
%{!mhard-float:-mfpu=softfpa}"
#endif
