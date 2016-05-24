//
//  ViewController.swift
//  Project2-days2
//
//  Created by xcl on 16/3/1.
//  Copyright © 2016年 xcl. All rights reserved.
//

import UIKit
import GameplayKit
class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    var countries = [String]()
    var currentCountryName = 0
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGrayColor().CGColor
        button2.layer.borderColor = UIColor.lightGrayColor().CGColor
        button3.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        askQuestion(nil)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func askQuestion(acction : UIAlertAction!){
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]
        
        button1.setImage(UIImage(named: countries[0]), forState: .Normal)
        button2.setImage(UIImage(named: countries[1]), forState: .Normal)
        button3.setImage(UIImage(named: countries[2]), forState: .Normal)
        currentCountryName = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
        title = countries[currentCountryName].uppercaseString
    }
    
    @IBAction func buttonTap(sender: AnyObject) {
        var title : String
        if sender.tag == currentCountryName {
            title = "correct"
            score += 1
        } else {
            title = "error"
            score -= 1
        }
        let ac = UIAlertController(title: title, message:"Your score is \(score)", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .Default, handler: askQuestion))
        presentViewController(ac, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

