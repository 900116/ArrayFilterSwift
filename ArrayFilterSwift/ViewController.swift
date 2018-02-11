//
//  ViewController.swift
//  TestArrayFilter2
//
//  Created by 51Talk_zhaoguanghui on 2018/2/11.
//  Copyright © 2018年 ApesStudio. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name  = ""
    var age   = 0
    var otherNames = [String]()
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let zhangsan = Person()
        zhangsan.age = 15
        zhangsan.name = "zs"
        
        let lisi = Person()
        lisi.age = 22
        lisi.name = "ls"
        lisi.otherNames = ["123","456","789"]
        
        let wangwu = Person()
        wangwu.age = 33
        wangwu.name = "wy"
        
        let wangwu2 = Person()
        wangwu2.age = 36
        wangwu2.name = "wwy"
        
        let abc = Person()
        abc.age = 44
        abc.name = "abc123abc"
        
        let array = [zhangsan, lisi, wangwu, wangwu2, abc]
        
        //比较运算符
        //1、equal =
        //2、no_equal !=
        //3、lessThan <
        //4、moreThan >
        //5、lessEqualThan <=
        //6、moreEqualThan >=
        //7、beginswith
        //8、endswith
        //9、contains
        //10、like
        //11、In
        //12、match
        
        //组合运算符
        //1、&&
        //2、||
        
        //前置函数
        //1、All
        //2、Any
        //3、Some
        //4、None
        
        let array2 = array.query(Where("age") > 3 && Where("name").beginswith("w"))
        //通配符
        let array3 = array.query(Where("name") % "w*y")
        let array4 = array.query(Where("name").like("w*y"))
        //正则
        let array5 = array.query(Where("name").matches("[a-z]+[0-9]+[a-z]+"))
        //In
        let array6 = array.query(Where("name").In(["ls","wwy"]))
        //SOME,ANY,All,NONE
        let array7 = array.query(ANY(Where("otherNames").beginswith("1")))
        
        //字符串或基本类型数组where空参数
        let str_arr = ["ab","abef","aab","aba","bba"];
        //正则表达式
        let match = str_arr.query(Where().matches("a*b"))
        //包含ab的字符串
        let likes = str_arr.query(Where() % "*ab*")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

