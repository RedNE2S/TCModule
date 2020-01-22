#include <linux/module.h>    // included for all kernel modules
#include <linux/kernel.h>    // included for KERN_INFO
#include <linux/init.h>      // included for __init and __exit macros

MODULE_LICENSE("GPL");
MODULE_AUTHOR("ThinkCyber");
MODULE_DESCRIPTION("A Very Important Module!");
MODULE_VERSION("7.6.2");

static int __init hello_init(void)
{
    printk(KERN_INFO "[TC] SECRET_KEY: 2nv6gf\n");
    return 0;    // Non-zero return means that the module couldn't be loaded.
}

static void __exit hello_cleanup(void)
{
    printk(KERN_INFO "Cleaning up module..\n");
}

module_init(hello_init);
module_exit(hello_cleanup);
