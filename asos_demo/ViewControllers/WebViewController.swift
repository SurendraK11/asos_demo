//
//  WebViewController.swift
//  asos_demo
//
//  Created by Surendra on 11/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit
import WebKit

protocol WebViewPresenting {
    func loadURL(_ url: URL, withTitle title: String)
    
}

class WebViewPresenter: UIViewController {
    @IBOutlet private var webviewContainerView: UIView!
    @IBOutlet private var navigationBar: UINavigationBar!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    private let url: URL
    private let pageName: String
    private var webView: WKWebView!
    
    init(withURL url: URL, title: String) {
        self.url = url
        pageName = title
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("deini - WebViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        activityIndicator.startAnimating()
        webView.load(URLRequest(url: url))
    }
    
    private func setup() {
        
        // setup navigation bar
        navigationBar.topItem?.title = pageName
        
        //setup web view
        webView = WKWebView(frame: view.bounds)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webviewContainerView.addSubview(webView)
        NSLayoutConstraint.activate(
            [
                webviewContainerView.bottomAnchor.constraint(equalTo: webView.bottomAnchor, constant: 0),
                webviewContainerView.leftAnchor.constraint(equalTo: webView.leftAnchor, constant: 0),
                webviewContainerView.rightAnchor.constraint(equalTo: webView.rightAnchor, constant: 0),
                webviewContainerView.heightAnchor.constraint(equalTo: webView.heightAnchor, constant: 0)
            ]
        )
        webviewContainerView.layoutIfNeeded()
        webView.navigationDelegate = self
    }
    
}

extension WebViewPresenter: WKNavigationDelegate {
    func webView(_ didFinishwebView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
