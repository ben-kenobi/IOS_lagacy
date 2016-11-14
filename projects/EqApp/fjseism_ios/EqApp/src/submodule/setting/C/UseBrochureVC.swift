//
//  UseBrochureVC.swift
//  EqApp
//
//  Created by apple on 16/11/9.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation


class  UseBrochureVC : FilePreviewVC {
    var type:Int = 0
    lazy var bglab:UILabel={
        let lab  = UILabel(frame: nil, txt: "当前没有可查看的文档", color: iColor(0xff333333), font: ibFont(20), align: NSTextAlignment.Center, line: 1)
        return lab
    }()
    
    
    lazy var tv:UITableView={
        let tv = UITableView(frame: CGRectMake(0, 0, 0, 0), style: UITableViewStyle.Plain)
        tv.delegate=self
        tv.dataSource=self
        tv.separatorStyle = .None
        tv.showsVerticalScrollIndicator=true
        tv.bounces=false
        tv.rowHeight = 95
        tv.backgroundColor=iColor(0xffefeff4)
        return tv
        
    }()
    
    var dcs:[DocFile] = []
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        let doc = DocFile.getByPath(iRes("辅助决策系统IOS端APP用户操作手册v1.1.doc")!)
        dcs.append(doc)
        if(dcs.count==0){
            tv.hidden=true
        }else{
            tv.hidden=false
        }
        
        
        cb = {
            (sender) in
            if sender.tag == 1{
                let df = self.dcs[0]
                if iFm.fileExistsAtPath(df.path!){
                    self.previewFile(df.path!)
                }else{
                    iPop.toast("文件不存在")
                }
            }
        }
        
    }
    
    var cb:((sender:UIButton)->())?
}



extension UseBrochureVC:UITableViewDelegate,UITableViewDataSource{
    func initUI(){
        view.addSubview(bglab)
        bglab.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        view.addSubview(tv)
        tv.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dcs.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return FilePostCell.cellWith(tableView, df: dcs[indexPath.row],cb:cb!)
    }
 
    
}
