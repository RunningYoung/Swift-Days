//
//  ViewController.swift
//  Project4-days4
//
//  Created by xcl on 16/3/21.
//  Copyright © 2016年 xcl. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate {
    var webView : WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com","runningyoung.github.io"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: "openTapped")
        progressView = UIProgressView(progressViewStyle: .Default)
        progressView.sizeToFit()
        progressView.frame = CGRectMake(0, 44, UIScreen.mainScreen().bounds.width, 5)
        navigationController?.navigationBar.addSubview(progressView)
//        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: webView, action: "reload")
//        progressButton,
        toolbarItems = [ spacer,refresh]
        navigationController?.toolbarHidden = false
        let url = NSURL(string: "https://" + websites[0])!
        webView.loadRequest(NSURLRequest(URL: url))
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func openTapped(){
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .ActionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .Default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancle", style: .Cancel, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    func openPage(action : UIAlertAction!){
                let url = NSURL(string: "https://" + action.title!)!
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        title = webView.title
    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "estimatedProgress" {
            progressView.hidden = false

            progressView.progress = Float(webView.estimatedProgress)
            if progressView.progress == 1 {
            
                progressView.hidden = true
            }
        }
    }
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.URL
        if let host = url!.host {
            for website in websites {
                if host.rangeOfString(website) != nil {
                    decisionHandler(.Allow)
                    return
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

