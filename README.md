# STM32CubeF4

### 闹心的几个问题 ###
* 启动文件中：
/* Call static constructors */
/*    bl __libc_init_array  */
要去掉，GCC说他找不到定义，人家也把这句话注掉了，行啊。
* 编译Demonstrations项目：
老说找不到 'malloc','free'的定义，因为没有libc，libm，libg的库，还没解决......
* 添加.a库：
gcc命令参数 -L 指定库路径, -l 指定库名字，然后，找不到文件，呐，未解决......
* 忙活的方向好像有点问题，有空解决.
* 岁月不饶人.
###### 2017/4/12 ######
