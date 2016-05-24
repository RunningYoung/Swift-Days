//
//  DetailViewController.swift
//  project_day01
//
//  Created by xcl on 16/2/29.
//  Copyright © 2016年 xcl. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var detailItem : String?
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let detail = self.detailItem {
            if let imageView = self.detailImageView {
                imageView.image = UIImage(named: detail)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
