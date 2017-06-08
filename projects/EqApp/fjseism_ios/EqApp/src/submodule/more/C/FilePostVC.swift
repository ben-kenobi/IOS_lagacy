

//
//  FilePostVC.swift
//  EqApp
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class FilePostVC: FilePreviewVC {
    var type:Int = 0
    lazy var bglab:UILabel={
          let lab  = UILabel(frame: nil, txt: "当前文档未生成", color: iColor(0xff333333), font: ibFont(20), align: NSTextAlignment.Center, line: 1)
        return lab
    }()
    var pd:DLDialog?
    
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
    let prefixes:[String] = ["hbr_","adm_"]
    
    let prefixenames:[String] = ["灾情简报_","辅助决策报告_"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        let info = EQInfo.getIns()
        if(info==nil || !info!.hasLayer){
            tv.hidden=true
        }else{
            tv.hidden=false
            dcs.append(DocFile.getByPrefix(prefixes[type],showPref: prefixenames[type],info: info!));
            
        }
        
//        tv.hidden=false
//        
//                    dcs.append(DocFile.getByPrefix(prefixes[type],showPref: prefixenames[type],info: EQInfo()));
//        dcs[0].url="http://61.154.9.242:5551/rgyxtqapp.apk"
        
          cb = {
                (sender) in
                if sender.tag == 1{
                    let df = self.dcs[0]
                    print(df.path!)
                    if !iFm.fileExistsAtPath(df.path!){
                        self.dl2F(df.url!, path: df.path!,delegate: self, cb: {
                            (path) in
                            if iFm.fileExistsAtPath(path){
                                iPop.toast("下载成功")
                                self.tv.reloadData()
                            }else{
                                iPop.toast("下载失败")
                            }
                        })
                    }else{
                       self.previewFile(df.path!)
                    }
                }else if sender.tag == 2{
                    let vc  = UIAlertController(title: "提示", message: "确认删除该文件", preferredStyle: .Alert)
                    vc.addAction(UIAlertAction(title: "确定", style: .Default, handler: { (ac) in
                        let df = self.dcs[0]
                        if iFm.fileExistsAtPath(df.path!){
                            try! iFm.removeItemAtPath(df.path!)
                        }
                        
                        self.tv.reloadData()
                    }))
                    vc.addAction(UIAlertAction(title: "取消", style: .Default,handler: nil))
                    self.presentViewController(vc, animated: true, completion: nil)
                }
                
        }

    }

    
    var cb:((sender:UIButton)->())?
   
    
     func dl2F(url:String,path:String,delegate:NSURLSessionDownloadDelegate,cb:((path:String)->())){
        var stop:Bool = false
        let url = NetUtil.fullUrl(url).urlEncoded()
        print(url+"---------")
        let session = NSURLSession(configuration:         NSURLSessionConfiguration.defaultSessionConfiguration()
            , delegate: delegate, delegateQueue: NSOperationQueue())
        session.downloadTaskWithRequest(NSURLRequest(URL: iUrl(url)!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 15)).resume()
        let pd=DLDialog.dialogWith("正在下载", mes: "当前进度", btns: ["取消"]) { (pos, dialog) -> Bool in
            session.invalidateAndCancel()
            return true
        }
        pd.show(self)
        self.pd=pd
        
    }
    
    
}



extension FilePostVC:UITableViewDelegate,UITableViewDataSource,NSURLSessionDownloadDelegate{
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
    
    
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        let df = self.dcs[0]
        try! iFm.copyItemAtPath(location.path!, toPath: df.path!)
        dispatch_async(dispatch_get_main_queue()) {
            self.pd?.dismiss()
            self.pd=nil
            if iFm.fileExistsAtPath(df.path!){
                iPop.toast("下载成功")
                self.tv.reloadData()
            }else{
                iPop.toast("下载失败")
            }
        }
        

    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        NSThread.sleepForTimeInterval(1)
        if let pd = pd{
            pd.pv.total=CGFloat(totalBytesExpectedToWrite)
            pd.pv.progress=CGFloat(totalBytesWritten)
        }
    }
    
    
    
    
   
}
