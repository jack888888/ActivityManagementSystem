//
//  FirstViewController.swift
//  ActivityManagementSystem
//
//  Created by Jack on 1/5/17.
//  Copyright © 2017 Jack. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UITableViewController {
    
    let url = "http://112.74.166.187:8443/api/activities"
    var activities = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "主页"
        //self.tableView.tableHeaderView = self.scrollView
        self.tableView.showsVerticalScrollIndicator = false;
        loadData()
        print(self.activities.count)
    }
    
    func loadData(){
        let params = ["name": "query"]
        
        Alamofire.request(.GET, url, parameters: params)
            .responseJSON {
                response in
                print(response.result.value)
                self.activities = response.result.value as! [NSDictionary]
                
                print(self.activities.count)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let row = indexPath.row
        switch (row) {
        case 0:
            cell.textLabel!.text = "活动1"
            break;
        case 1:
            cell.textLabel!.text = "投票1"
            break;
        case 2:
            cell.textLabel!.text = "投票2"
            break;
        case 3:
            cell.textLabel!.text = "活动2"
            break;
        default:
            break;
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 200
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            let frame = CGRectMake(0, 0, view.bounds.width, view.bounds.width*0.48)
            let imageView = ["2.png","3.png","1.png"]
            
            let loopView = XHAdLoopView(frame: frame, images: imageView, autoPlay: true, delay: 3, isFromNet: false)
            loopView.delegate = self
            return loopView
        } else {
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print("You deselected cell #\(indexPath.row)!")
        //        let type = items.objectAtIndex(indexPath.row) as String
        let type = "activity"
        if (type == "activity") {
            let sb = UIStoryboard(name: "Main", bundle:nil)
            let vc = sb.instantiateViewControllerWithIdentifier("activityViewController") as! ActivityViewController
            self.navigationController!.pushViewController(vc, animated: true)
        } else if (type == "vote"){
            let sb = UIStoryboard(name: "Main", bundle:nil)
            let vc = sb.instantiateViewControllerWithIdentifier("voteViewController") as! VoteViewController
            self.navigationController!.pushViewController(vc, animated: true)
        }
        
    }
    

}

extension FirstViewController : XHAdLoopViewDelegate {
    func adLoopView(adLoopView: XHAdLoopView, IconClick index: NSInteger) {
        print(index)
    }
}