




//

import UIKit

class YFVC01: UIViewController,UITableViewDelegate,UITableViewDataSource {
     var tv:UITableView?
    
  
    
    var datas:[Person]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tv=UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: UITableViewStyle.Plain)
        
        self.view.addSubview(tv!)
        tv?.delegate=self
        tv?.dataSource=self
        tv?.rowHeight=70
        self.loadDatas { (res) -> () in
            self.datas=res
            self.tv?.reloadData()
        }
    }
}

extension YFVC01{
    func loadDatas(cb:(res:[Person])->()){
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            var ary=[Person]()
            for i in 0...10{
                ary.append(Person(dict: ["name":"name\(i)","age":random()%100]))
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cb(res: ary)
            })
        }
    }

}
extension YFVC01{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return datas?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let iden="celliden"
        let cell:YFTvCell =  YFTvCell(style: UITableViewCellStyle.Value1, reuseIdentifier: iden)
        cell.m=self.datas![indexPath.row]
        
        return cell
        
    }
    
      func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        var vc=YFDetailVC(f: false)
        vc?.m=self.datas![indexPath.row]
        vc?.clo={
            self.tv?.reloadData()
        }
        if(vc != nil){
            presentViewController(vc!, animated: true ,completion: nil)
        }
    }
}
    

