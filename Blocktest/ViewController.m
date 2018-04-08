//
//  ViewController.m
//  Blocktest
//
//  Created by lbe on 2018/4/8.
//  Copyright © 2018年 liwuyang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)testBlock {
    //1，****** block是带有自动变量值得匿名函数
    /*block形式
     ^ 返回值类型 (参数列表) 表达式
     */
    ^int (int count){
        return 1;
    };
    
    //block变量
    int (^blk)(int count) = ^int (int count){
        return 1;
    };
    
    //C语言函数指针
    void (*funPtr) (void) = &func;
    (*funPtr)();
    
    
    //*******block本质是oc对象
    
    //*********block截获自动变量值即变量被保存到block的结构体实例中(作为结构体实例变量)
    
    /* ***********在block中修改自动变量有两种方式，一种是静态全局变量、全局变量、静态变量。全局变量使用方式同c语言类似，今天变量是将其指针传入block结构体实例(作为结构体实例变量)；
     第二种是_block变量,_block类型变量实质同block变量一样，是个结构体
     */
    
    //Block存储域。Block即栈上的Block结构体，_block变量即栈上的_block结构体。block的存储区域分三种: _NSConcreteStackBlock,_NSConcreteGlobalBlock,_NSConcreteMallocBlock. 不截获自动变量或者在block中使用了全局变量时，block使用的是_NSConcreteGloabalBlock，位于数据区域。除此之外Block位于stack。位于stack的block当变量作用域结束时，block也被废弃了。要将Block移到maolloc区域，使用Copy方法。GCD的API默认在堆上；
    
    //当Block被从栈复制到堆时，其所使用的_block变量也从栈复制到堆，block持有_block的引用，block被废弃是时，_block也被废弃。同引用计数
    
    //不管_block变量配置在栈上还是堆上，都能够正确的访问栈上或者堆上的_block变量。因为_block变量本质是_block结构体，有一个指向自身的fowarding指针，当_block变量从栈复制到堆时，栈上的_block结构体中的fowarding指针指向堆上的_block结构体。
    
    //下列情况Block从栈复制到堆：1，调用Block的copy方法。2，Block作为函数返回值返回时，3，将Block复制给_strong修饰符修饰的Blcok类型成员变量或者id类型。4，在方法名中含有usingBlock或者GCD的API中传递block时。从stack复制到malloc其实质是调用_Block_Copy方法。废弃时调用_block_dispose方法
    
    //避免Block循环引用：1，使用weak修饰符；2，使用_block修饰符(在block表达式中设置_block变量为nil，必须显示调用block，否则会引起循环引用)
    
    //在MRC中，需要手动将Block从栈复制到堆，Copy复制，release释放；只要Block有一次复制并配置到堆上，就可通过retain实例持有，否则retain方法对Block无效
}

void func() {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
