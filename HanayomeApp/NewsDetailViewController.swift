//
//  NewsDetailViewController.swift
//  HanayomeApp
//
//  Created by 西尾悠太 on 2022/01/02.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var link: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: self.link) {
            let reqest = URLRequest(url: url)
            self.webView.load(reqest)
        }
    }
    
}
