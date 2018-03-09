//
//  WebPubChemViewController.swift
//  SearchPubChem
//
//  Created by Jae Seung Lee on 3/8/18.
//  Copyright © 2018 Jae Seung Lee. All rights reserved.
//

import UIKit
import WebKit

class WebPubChemViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = URLRequest(url: url)
        webView.load(request)
    }
}