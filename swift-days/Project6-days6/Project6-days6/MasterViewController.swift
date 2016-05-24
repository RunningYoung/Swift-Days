//
//  ViewController.swift
//  Project6-days6
//
//  Created by xcl on 16/3/24.
//  Copyright © 2016年 xcl. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController : DetailViewController?
    var objects = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&amp;limit=100"
        }
        
        if let url = NSURL(string : urlString) {
            if let data = try? NSData(contentsOfURL: url,options: []) {
                let json = JSON(data: data)
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    parseJSON(json)
                } else {
                    showError()
                }
                
            } else {
                showError()
            }
        } else {
            showError()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func showError() {
        let ac  = UIAlertController(title: "Loading error",message: "here was a problem loading the feed; please check your connection and try again.",preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK",style: .Default,handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    func parseJSON(json : JSON) {
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let  body = result["body"].stringValue
            let  sigs = result["signatureCount"].stringValue
            let  obj = ["title":title ,"body": body,"sigs" :sigs]
            objects.append(obj)
        }
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath)
        let object = objects[indexPath.row]
        cell.textLabel?.text = object["title"]
        cell.detailTextLabel?.text = object["body"]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let  controller = segue.destinationViewController  as! DetailViewController
                controller.detailItem = object
                
            }
        }
    }
}

