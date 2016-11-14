//: Playground - noun: a place where people can play

import UIKit

class IV : UIView{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("123123")
    }
}

var str = "Hello, playground"
let btn = IV(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

btn.backgroundColor=UIColor.red
btn.frame=CGRect(x: 100, y: 200, width: 200, height: 200)

