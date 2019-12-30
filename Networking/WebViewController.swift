//
//  WebViewController.swift
//  NetworkingApp
//
//  Created by Azat Chorekliev on 12/30/19.
//  Copyright © 2019 Azat Chorekliev. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var selectedDeviceName: String? = nil
    var selectedDeviceURL: String? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let titleName = selectedDeviceName {
            navigationItem.title = titleName
            
        }
        
        if let deviceUrl = selectedDeviceURL {
            let link = URL(string: deviceUrl)
            if let deviceURLLink = link    {
                
                let request = URLRequest(url: deviceURLLink)
                
                webView.load(request)
                
            }
            
        }
    }
    
}
