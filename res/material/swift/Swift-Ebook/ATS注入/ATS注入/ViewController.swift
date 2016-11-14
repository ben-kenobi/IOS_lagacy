//
//  ViewController.swift
//  ATS注入
//
//  Created by EnjoySR on 15/11/28.
//  Copyright © 2015年 EnjoySR. All rights reserved.
//

import Cocoa

// 模版文件路径
private let path = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates/iOS/Application/Cocoa Touch Application Base.xctemplate/TemplateInfo.plist"

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func insertButtonClick(sender: NSButton) {
        
        let tempDict = NSDictionary(contentsOfFile: path)
        
        guard var dict = tempDict as? [String: AnyObject] else {
            return
        }
        
        // 准备 ATS 字典
        let definAts = [
            "Beginning": "<key>NSAppTransportSecurity</key>\n<dict>",
            "End": "</dict>",
            "Indent": 1
        ]
        
        // 设置 Definitions 节点数据
        let definAtsBase = "<key>NSAllowsArbitraryLoads</key><true/>"
        let definotions = dict["Definitions"]
        if var defi = definotions as? [String: AnyObject] {
            defi["Info.plist:NSAppTransportSecurity"] = definAts
            defi["Info.plist:NSAppTransportSecurity:base"] = definAtsBase
            dict["Definitions"] = defi
        }
        
        // 设置 Nodes 节点数据
        let nodes = dict["Nodes"];
        if var nod = nodes as? [String] {
            let index = nod.indexOf("Info.plist:NSAppTransportSecurity:base")
            // 如果不存在
            if index == nil {
                nod.append("Info.plist:NSAppTransportSecurity:base")
                dict["Nodes"] = nod
            }
        }
        // atomically 一定要写 false，不然写入失败
        // 推测原因是由于 atomically 会生成一个备份文件，而更改的文件存在于系统目录，建立文件需要输入密码，所以直接在当前文件上改
        let result = (dict as NSDictionary).writeToFile(path, atomically: false)
        let alert = NSAlert()
        alert.addButtonWithTitle("Enter")
        if result {
            alert.messageText = "Successful!"
        }else{
            alert.messageText = "Oh no!"
        }
        alert.runModal()
    }
    
    
    @IBAction func removeButtonClick(sender: NSButton) {
        let tempDict = NSDictionary(contentsOfFile: path)
        
        guard var dict = tempDict as? [String: AnyObject] else {
            return
        }
        
        // 设置 Definitions 节点数据
        let definotions = dict["Definitions"]
        if var defi = definotions as? [String: AnyObject] {
            defi["Info.plist:NSAppTransportSecurity"] = nil
            defi["Info.plist:NSAppTransportSecurity:base"] = nil
            dict["Definitions"] = defi
        }
        
        // 设置 Nodes 节点数据
        let nodes = dict["Nodes"];
        if var nod = nodes as? [String] {
            let index = nod.indexOf("Info.plist:NSAppTransportSecurity:base")
            if index != nil {
                nod.removeAtIndex(index!)
            }
            dict["Nodes"] = nod
        }
        
        let result = (dict as NSDictionary).writeToFile(path, atomically: false)
        let alert = NSAlert()
        alert.addButtonWithTitle("Enter")
        if result {
            alert.messageText = "Successful!"
        }else{
            alert.messageText = "Oh no!"
        }
        alert.runModal()
        
    }
    @IBAction func toWeiBo(sender: NSClickGestureRecognizer) {
        let url = NSURL(string: "http://weibo.com/EnjoySR")
        NSWorkspace.sharedWorkspace().openURL(url!)
    }
}

