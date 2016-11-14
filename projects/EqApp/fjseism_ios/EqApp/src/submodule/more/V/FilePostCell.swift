
//
//  FilePostCell.swift
//  EqApp
//
//  Created by apple on 16/9/15.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class FilePostCell: UITableViewCell {
    static let celliden = "celliden"
    var df:DocFile?{
        didSet{
          updateUI()
        }
    }
    var cb:((sender:UIButton)->())?
    
    
    class func cellWith(tv:UITableView,df:DocFile,cb:((sender:UIButton)->()))->FilePostCell{
        
        var cell = tv.dequeueReusableCellWithIdentifier(celliden) as? FilePostCell
        if cell == nil{
           cell = FilePostCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: celliden)
            cell?.selectionStyle = .None
        }
        cell?.cb=cb
        cell?.df=df
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var icon:UIImageView=UIImageView(image: iimg("disk_zyztsb"))
    lazy var title:UILabel=UILabel(frame: nil, txt: "评估报告.doc", color: iColor(0xff333333), font: iFont(17), align: NSTextAlignment.Left, line: 2)
    lazy var subtitle:UILabel=UILabel(frame: nil, txt: "121.1 k", color: iColor(0xff888888), font: iFont(14), align: NSTextAlignment.Left, line: 1)
    lazy var detail:UILabel=UILabel(frame: nil, txt: "20155-5-5 :00:12:12", color: iColor(0xff888888), font: iFont(14), align: .Left, line: 1)
    lazy var btn1:UIButton=UIButton(frame: nil, title: "下载", font: iFont(19), titleColor: iColor(0xff2299ff),bgcolor: iColor(0xffffffff), corner: 5, bordercolor: iColor(0xaa2299ff), borderW: 1, tar: self, action: #selector(self.onClick(_:)), tag: 1)
    lazy var btn2:UIButton=UIButton(frame: nil, title: "删除", font: iFont(19), titleColor: iColor(0xffff5555),bgcolor: iColor(0xffffffff), corner: 5, bordercolor: iColor(0xaa2299ff), borderW: 1, tar: self, action: #selector(self.onClick(_:)), tag: 2)
}


extension FilePostCell{
    func updateUI(){
        guard let df = df else{
            return
        }
        title.text = df.showname
        subtitle.text = FileUtil.formatedFileSize(Int64(df.size))
        if let gentm = df.genTime{
            detail.text=iConst.TIMESDF.stringFromDate(gentm)
            btn2.hidden = !iFm.fileExistsAtPath(df.path!)
        }else{
            detail.text=""
            btn2.hidden = true
        }
        btn1.setTitle(!iFm.fileExistsAtPath(df.path!) ? "下载" : "查看", forState: .Normal)
        if let url = df.url where df.size<=0 {
            dispatch_async(dispatch_get_global_queue(0, 0), { 
                df.size = INet.contentLenBy(url)
                dispatch_async(dispatch_get_main_queue(), { 
                    self.subtitle.text = FileUtil.formatedFileSize(Int64(df.size))
                })
            })
        }
    }
    
    func initUI(){
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        contentView.addSubview(detail)
        contentView.addSubview(btn1)
        contentView.addSubview(btn2)
        
        icon.snp_makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalTo(-15)
            make.width.equalTo(icon.snp_height)
        }
        title.snp_makeConstraints { (make) in
            make.top.equalTo(icon)
            make.left.equalTo(icon.snp_right).offset(15)
            make.right.equalTo(-2)
        }
        subtitle.snp_makeConstraints { (make) in
            make.top.equalTo(title.snp_bottom).offset(5)
            make.left.equalTo(title)
        }
        detail.snp_makeConstraints { (make) in
            make.bottom.equalTo(icon)
            make.left.equalTo(title)
        }
        btn2.snp_makeConstraints { (make) in
            make.height.equalTo(35)
            make.width.equalTo(55)
            make.bottom.equalTo(-5)
            make.right.equalTo(-8)
        }
        btn1.snp_makeConstraints { (make) in
            make.height.width.bottom.equalTo(btn2)
            make.right.equalTo(btn2.snp_left).offset(-8)
        }
    }
    
    func onClick(sender:UIButton){
        
        cb?(sender:sender)
        
    }
}


