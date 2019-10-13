//
//  WebViewController.swift
//  asos_demo
//
//  Created by Surendra on 11/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit
import WebKit

class WebViewPresenter: UIViewController {
    @IBOutlet private var webviewContainerView: UIView!
    @IBOutlet private var navigationBar: UINavigationBar!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    private var url: URL?
    private var pageName: String?
    private var webView: WKWebView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        url = nil
        pageName = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        activityIndicator.startAnimating()
        if let _ = url {
            webView.load(URLRequest(url: url!))
        }
        
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

extension WebViewPresenter: WebViewPresenting {
    func loadURL(_ url: URL, withTitle title: String, forViewController viewController: UIViewController) {
        self.url = url
        pageName = title

        viewController.present(self, animated: true, completion: nil)
    }
}
