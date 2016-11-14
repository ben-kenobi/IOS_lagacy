//
//  EditSceneUI.swift
//  EqApp
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit


extension EditSceneVC{
    
    func updateUI(){
        
        let editable = (curscene!.flag == 0)
        navigationItem.rightBarButtonItem?.customView?.hidden = !editable
        levelbtn?.enabled=editable
        descbtn?.enabled=editable
        detailTv?.editable=editable
        
        view.viewWithTag(1)?.snp_updateConstraints(closure: { (make) in
            make.width.equalTo(!editable ? 0 : 65)
        })
        view.viewWithTag(3)?.snp_updateConstraints(closure: { (make) in
            make.height.equalTo(!editable ? 0 : 38)
        })
   
        view.viewWithTag(2)?.hidden = !editable

        gv.userInteractionEnabled = editable
        usesrc?.enabled=editable
        usesrc?.on = "1"==curscene!.remark

    }
    
    
    func initUI(){
        navigationItem.rightBarButtonItem=UIBarButtonItem(title:"完成 " , titleColor:iColor(0xff55aaff),tar: self, action: #selector(self.onClick(_:)))
        let h:CGFloat = 44
        let usesrctv=UITextView(frame:nil, bg: iColor(0xffffffff))
        usesrctv.editable=false
        view.addSubview(usesrctv)
        usesrctv.textAlignment = .Left
        usesrctv.text="  使用原图:"
        usesrctv.font=iFont(18)
        usesrc=UISwitch(frame:CGRectMake(100, 5, 80, 34))
        usesrctv.addSubview(usesrc!)
        usesrctv.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(h)
        }
        
        //----- 1-
        let sv = EndScrollV()
        view.addSubview(sv)
        sv.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(usesrctv.snp_top)
        }
//        sv.showsHorizontalScrollIndicator=false
        sv.bounces=false
        
        let contentv = UIView()
        sv.addSubview(contentv)
    
        contentv.snp_makeConstraints { (make) in
            make.width.equalTo(sv.snp_width).offset(-16)
            make.edges.equalTo(UIEdgeInsetsMake(12, 8, -10, -8))
        }
    
        
        let titleW:CGFloat=80
        let iconw:CGFloat = 28
        let titlepad:CGFloat = iconw+4
        let linepad:CGFloat=8
        let linew = iScrW-linepad*2-16
        let h0:CGFloat=44
        let linecolor = iColor(0xffcccccc)
        let fontsize = iFont(15)
        
        let timeicon = UIImageView(frame: nil, img: iimg("time"), radi: 0, borderColor: nil, borderW: 0)
        contentv.addSubview(timeicon)
        
        let timetitle = UILabel(frame: CGRectMake(titlepad, 0, titleW, h0), txt: "时        间: ", color: iColor(0xff222222), font: fontsize, align: NSTextAlignment.Left, line: 1)
        contentv.addSubview(timetitle)
        timeicon.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.height.width.equalTo(iconw)
            make.centerY.equalTo(timetitle)
        }
        timeLab=UILabel(frame: nil, txt: "", color: iColor(0xff222222), font: fontsize, align: NSTextAlignment.Left, line: 1)
        contentv.addSubview(timeLab!)
        timeLab!.snp_makeConstraints { (make) in
            make.left.equalTo(timetitle.snp_right)
            make.top.equalTo(timetitle)
            make.height.equalTo(h0)
            make.right.equalTo(0)
        }
        let line0 = UIView(frame: CGRectMake(linepad, h0, linew, 1),bg:linecolor)
        contentv.addSubview(line0)
        
        let h1:CGFloat=88
        let addicon = UIImageView(frame: nil, img: iimg("place"), radi: 0, borderColor: nil, borderW: 0)
        contentv.addSubview(addicon)

        let addtitle = UILabel(frame: CGRectMake(titlepad, h0, titleW, h0), txt: "地        点: ", color: iColor(0xff222222), font: fontsize, align: NSTextAlignment.Left, line: 1)
        contentv.addSubview(addtitle)
        addicon.snp_makeConstraints { (make) in
            make.left.height.width.equalTo(timeicon)
            make.centerY.equalTo(addtitle)
        }
        
        addlab = UILabel(frame: nil, txt: "", color: iColor(0xff222222), font: fontsize, align: NSTextAlignment.Left, line: 1)
        contentv.addSubview(addlab!)
        addlab!.snp_makeConstraints { (make) in
            make.left.equalTo(addtitle.snp_right)
            make.right.equalTo(0)
            make.height.equalTo(h0)
            make.top.equalTo(h0)
        }
//        contentv.addSubview( UIImageView(frame: CGRectMake(0, 0, h1, h1), img: iimg("location")))
        let line1 = UIView(frame: CGRectMake(linepad, h1, linew, 1),bg:linecolor)
        contentv.addSubview(line1)
        
        //------ 2-
        let h2:CGFloat = 62
        let idenicon = UIImageView(frame: nil, img: iimg("tag"), radi: 0, borderColor: nil, borderW: 0)
        contentv.addSubview(idenicon)
        let eqidentitle = UILabel(frame: CGRectMake(titlepad, h1, titleW, h0), txt: "地震标识: ", color: iColor(0xff222222), font: fontsize, align: NSTextAlignment.Left, line: 1)
        contentv.addSubview(eqidentitle)
        let chooidenbtn = UIButton(frame: nil,  title: "手动选择", font: iFont(14), titleColor: iColor(0xffffffff), titleHlColor: iColor(0xffdddddd),  bgcolor: iColor(53, 112, 245), corner: 3, bordercolor: iColor(0xff888888), borderW: 1, tar: self, action: #selector(self.onClick(_:)), tag: 1)
        contentv.addSubview(chooidenbtn)
        idenicon.snp_makeConstraints { (make) in
            make.left.height.width.equalTo(timeicon)
            make.centerY.equalTo(eqidentitle)
        }
        
        eqidenlab = UILabel(frame: nil, txt: "", color: iColor(0xff555555), font: fontsize, align: NSTextAlignment.Left, line: 2)
        eqidenlab?.lineBreakMode = .ByCharWrapping
        contentv.addSubview(eqidenlab!)
        eqidenlab?.snp_makeConstraints(closure: { (make) in
            make.height.equalTo(h2)
            make.left.equalTo(eqidentitle.snp_right)
            make.right.equalTo(chooidenbtn.snp_left).offset(-5)
            make.top.equalTo(eqidentitle)
        })
        chooidenbtn.snp_makeConstraints { (make) in
            make.centerY.equalTo(eqidenlab!)
            make.width.width.equalTo(65)
            make.height.equalTo(30)
            make.right.equalTo(0)
        }

        let line2 = UIView(frame: CGRectMake(linepad, h1+h2, linew, 1),bg:linecolor)
        contentv.addSubview(line2)
        
        //-------- 3-
        let h3:CGFloat = 44
        let leveltitle = UILabel(frame: CGRectMake(titlepad, h1+h2, titleW, h3), txt: "烈度等级: ", color: iColor(0xff222222), font: fontsize, align: NSTextAlignment.Left, line: 1)
        contentv.addSubview(leveltitle)
        
        let detaillevel = UIButton(frame: nil,  title: "详细描述", font: iFont(14), titleColor: iColor(0xffffffff), titleHlColor: iColor(0xffdddddd),  bgcolor: iColor(53, 112, 245), corner: 3, bordercolor: iColor(0xff888888), borderW: 1, tar: self, action: #selector(self.onClick(_:)), tag: 2)
        contentv.addSubview(detaillevel)
        detaillevel.snp_makeConstraints { (make) in
            make.centerY.equalTo(leveltitle)
            make.width.width.equalTo(chooidenbtn)
            make.height.equalTo(30)
            make.right.equalTo(0)
        }
        
        levelbtn = ComUI.dropBtn("", tar: self, sel: #selector(self.onClick(_:)), tag: 0,font:fontsize)
        contentv.addSubview(levelbtn!)
        levelbtn?.snp_makeConstraints(closure: { (make) in
            make.height.equalTo(h3-12)
            make.left.equalTo(leveltitle.snp_right)
            make.right.equalTo(detaillevel.snp_left).offset(-8)
            make.centerY.equalTo(leveltitle)
            
        })
        
        let levelicon = UIImageView(frame: nil, img: iimg("level"), radi: 0, borderColor: nil, borderW: 0)
        contentv.addSubview(levelicon)
        levelicon.snp_makeConstraints { (make) in
            make.left.height.width.equalTo(timeicon)
            make.centerY.equalTo(leveltitle)
        }
        
        let line3 = UIView(frame: CGRectMake(linepad, h1+h2+h3, linew, 1),bg:linecolor)
        contentv.addSubview(line3)
        
        
        // -------4-
        let h4:CGFloat = 65
        let desctitle = UILabel(frame: CGRectMake(titlepad, h1+h2+h3, titleW, h0), txt: "简要描述: ", color: iColor(0xff222222), font: fontsize, align: NSTextAlignment.Left, line: 1)
        contentv.addSubview(desctitle)
        
        
        descbtn = ComUI.dropBtn("", tar: self, sel: #selector(self.onClick(_:)), tag: 0,font: fontsize)
        descbtn?.titleLabel?.numberOfLines=2
        contentv.addSubview(descbtn!)
        descbtn?.snp_makeConstraints(closure: { (make) in
            make.height.equalTo(h4-16)
            make.left.equalTo(desctitle.snp_right)
            make.right.equalTo(0)
            make.top.equalTo(desctitle).offset(8)
            
        })
        
        
        let descicon = UIImageView(frame: nil, img: iimg("The_paper"), radi: 0, borderColor: nil, borderW: 0)
        contentv.addSubview(descicon)
        descicon.snp_makeConstraints { (make) in
            make.left.height.width.equalTo(timeicon)
            make.centerY.equalTo(desctitle)
        }
        
        let line4 = UIView(frame: CGRectMake(linepad, h1+h2+h3+h4, linew, 1),bg:linecolor)
        contentv.addSubview(line4)

        // -----5-
        detailTv =  AutoHeightTextView(frame: nil, bg: iColor(0xffffffff), corner: 5, bordercolor: iColor(0xff1155ff), borderW: 1)
        contentv.addSubview(detailTv!)
        detailTv?.font=fontsize
        let detailtitle = UILabel(frame: nil, txt: "详细描述: ",color: iColor(0xff222222), font: fontsize, align: NSTextAlignment.Left, line: 1)
        contentv.addSubview(detailtitle)
        detailtitle.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(line4.snp_bottom)
            make.left.equalTo(titlepad)
            make.width.equalTo(titleW)
            make.height.equalTo(h0)
        })
        detailTv?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(detailtitle.snp_right)
            make.top.equalTo(line4).offset(12)
            make.right.equalTo(0)
            make.height.equalTo(detailTv!.minH)
        })
        let detailicon = UIImageView(frame: nil, img: iimg("detailed"), radi: 0, borderColor: nil, borderW: 0)
        contentv.addSubview(detailicon)
        detailicon.snp_makeConstraints { (make) in
            make.left.height.width.equalTo(timeicon)
            make.centerY.equalTo(detailtitle)
        }
        
        let line5 = UIView(frame: nil,bg:linecolor)
        contentv.addSubview(line5)
        line5.snp_makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalTo(linew)
            make.top.equalTo(detailTv!.snp_bottom).offset(12)
            make.left.equalTo(linepad)
        }

        // -----6-
        let picker = ImgBtn2(frame: nil, img: iimg("photo"), title: "照片选取", font: iFont(18), titleColor: iColor(0xff222222), titleHlColor: iColor(0xff999999), bgcolor: iColor(0xffffffff), corner: 4, bordercolor: iColor(0xff888888), borderW: 1, tar: self, action: #selector(self.onClick(_:)), tag: 3)
        picker.contentEdgeInsets=UIEdgeInsetsMake(0, 6, 0, 6)
        let cam = ImgBtn2(frame: nil, img: iimg("photographic"), title: "照相", font: iFont(18), titleColor: iColor(0xff222222), titleHlColor: iColor(0xff999999), bgcolor: iColor(0xffffffff), corner: 4, bordercolor: iColor(0xff888888), borderW: 1, tar: self, action: #selector(self.onClick(_:)), tag: 4)
        cam.contentEdgeInsets=UIEdgeInsetsMake(0, 6, 0, 6)

        let video = ImgBtn2(frame: nil, img: iimg("video"), title: "视频", font: iFont(18), titleColor: iColor(0xff222222), titleHlColor: iColor(0xff999999), bgcolor: iColor(0xffffffff), corner: 4, bordercolor: iColor(0xff888888), borderW: 1, tar: self, action: #selector(self.onClick(_:)), tag: 5)
        video.contentEdgeInsets=UIEdgeInsetsMake(0, 6, 0, 6)
        

        contentv.addSubview(picker)
        contentv.addSubview(cam)
        contentv.addSubview(video)
        picker.snp_makeConstraints { (make) in
            make.top.equalTo(line5.snp_bottom).offset(10)
            make.left.equalTo(0)
            make.height.equalTo(38)
        }
        cam.snp_makeConstraints { (make) in
            make.top.equalTo(line5.snp_bottom).offset(10)
            make.left.equalTo(picker.snp_right).offset(20)
            make.height.equalTo(picker)
        }
        video.snp_makeConstraints { (make) in
            make.top.equalTo(line5.snp_bottom).offset(10)
            make.left.equalTo(cam.snp_right).offset(20)
            make.height.equalTo(picker)
        }
        
        contentv.addSubview(gv)
        gv.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(video.snp_bottom).offset(10)
            make.bottom.equalTo(0)
        }
    }
    
}


class EndScrollV:UIScrollView{
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.endEditing(true)
    }
}

class ImgBtn2:UIButton{
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(8, 8,contentRect.height-10, contentRect.height-16)
    }
}


