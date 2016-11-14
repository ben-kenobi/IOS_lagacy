//
//  MenuUtil.swift
//  am
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
public enum NavMenu : Int {
    case Done
    case Cancel
    case Edit
    case Save
    case Add
    case FlexibleSpace
    case FixedSpace
    case Compose
    case Reply
    case Action
    case Organize
    case Bookmarks
    case Search
    case Refresh
    case Stop
    case Camera
    case Trash
    case Play
    case Pause
    case Rewind
    case FastForward
    case Undo
    case Redo
    case PageCurl
    case More
}
class ComUI{

   
    static func moreItem(target:AnyObject,sel:Selector)->UIBarButtonItem{
        let item = UIBarButtonItem(image: iimg("ic_menu_moreoverflow_normal_holo_light"), style: UIBarButtonItemStyle.Plain, target: target, action:sel)
        item.tag=NavMenu.More.rawValue
        return item
    }
    static func comBtn1(tar:AnyObject,sel:Selector,title:String)->UIButton{
        return UIButton(frame: nil,  title: title, font: ibFont(17), titleColor: iColor(0xffffffff), titleHlColor: iColor(0xffeeeeee), bgimg: iimg("blue_noselect.9"), hlbgimg: iimg("gray_noselect.9"),corner: 7, bordercolor: iConst.khakiBg, borderW: 1, tar: tar, action: sel, tag: 0)
       
        
    }
    static func comTitleLab(title:String)->UILabel{
        return   UILabel(frame: nil, txt: "\(title)", color:iConst.orgTitCol, font: ibFont(17), align: NSTextAlignment.Left, line: 1, bgColor: UIColor.whiteColor())
        
    }
    static func dropBtn(title:String,tar:AnyObject?,sel:Selector,tag:Int,font:UIFont=ibFont(18))->UIButton{
        let b = DropBtn( img: iimg("triangle_down_blue"), title: title, font: font, titleColor: iColor(0xff5555aa), bgimg: iimg("lightblue_noselect.9"), hlbgimg: iimg("button_select.9"),  corner: 4, bordercolor: iColor(0xffdddddd), borderW: 1, tar: tar, action: sel, tag: tag)
        b.setBackgroundImage(iimg("button_select.9"), forState: UIControlState.Selected)
        return b
        
    }
    static func comTitleView(title:String)->UIView{
        let view = UIView()
        let lab = comTitleLab(title)
        view.addSubview(lab)
        let divider = UIView()
        divider.backgroundColor=iColor(0xff33ff33)
        view.addSubview(divider)
        divider.snp_makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(2)
        }
        lab.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(divider.snp_top)
        }
        return view
    }
    static func comDropTitleView(title:String,dropTitle:String,tar:AnyObject?,sel:Selector,labtag:Int,droptag:Int)->UIButton{
        let view = UIButton()
        view.setBackgroundImage(iimg(iColor(0xffffffff)), forState: UIControlState.Normal)
        view.setBackgroundImage(iimg(iConst.khakiBg), forState: UIControlState.Highlighted)
        let lab = comTitleLab(title)
        lab.backgroundColor=UIColor.clearColor()
        view.addSubview(lab)
        lab.tag=labtag
        let divider = UIView()
        divider.backgroundColor=iColor(0xff33ff33)
        view.addSubview(divider)
        let drop = dropBtn(dropTitle, tar: tar, sel: sel, tag: droptag)
        view.addSubview(drop)
        divider.snp_makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(2)
        }
        drop.snp_makeConstraints { (make) in
            make.right.equalTo(-5)
            make.top.equalTo(4)
            make.bottom.equalTo(-7)
            make.width.equalTo(150)
        }
        lab.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(10)
            make.right.equalTo(drop.snp_left).offset(-8)
            make.bottom.equalTo(divider.snp_top)
        }
        return view
    }
    
    static func comTF1(indica:String)->ClearableTF{
       let tf = ClearableTF()
        tf.placeholder=indica
        tf.disabledBackground=iimg(iColor(0x00ffffff))
        return tf
    }
    
   

}



class DropBtn:UIButton{
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.r=self.w-10
        titleLabel?.x=10
    }
}

class ClearableTF:UITextField{
    
    var onTxtChangeCB:((tf:ClearableTF)->())?
    
    lazy var btn:UIButton={
        let btn=UIButton(frame: CGRectMake(0, 0, 20, 20), title: "X", font: iFont(17), titleColor: iColor(0xffffffff), titleHlColor: iColor(0xffffffff), bgimg: iimg("button_select.9"), hlbgimg: iimg("lightblue_noselect.9"),corner: 10, bordercolor: iColor(0xffffffff), borderW: 1, tar: self, action:#selector(self.onClear), tag: 0)
        btn.hidden=true
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tf = self
        tf.background=iimg("editbox_background_normal.9")
        tf.disabledBackground=nil
        tf.leftView=UIView(frame: CGRectMake(0, 0, 9, 0))
        tf.leftViewMode = .Always
        tf.rightViewMode = .WhileEditing
        let rv=UIView(frame: CGRectMake(0, 0, 27, 20))
        tf.rightView = rv
        
        rv.addSubview(btn)
        iNotiCenter.addObserver(self, selector: #selector(self.onTextChanged(_:)), name: UITextFieldTextDidChangeNotification, object: self)
        addObserver(self, forKeyPath: "enabled", options: NSKeyValueObservingOptions.Old, context: nil)
        addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions.Old, context: nil)
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath! == "enabled"{
            let ph = valueForKeyPath("_placeholderLabel") as? View
            ph?.hidden = !enabled
        }else if keyPath! == "text"{
            onTextChanged(nil)
        }
        
    }
    
   func  onClear(){
        text=""
    }
   
    func onTextChanged(noti:NSNotification?){
        btn.hidden = isBlank(text)
        onTxtChangeCB?(tf: self)
    }
    
    deinit{
        iNotiCenter.removeObserver(self)
        removeObserver(self, forKeyPath: "enabled")
        removeObserver(self, forKeyPath: "text")

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
