//
//  SpinnerView.swift
//  
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//


import UIKit

class SpinnerView: UIView {
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var message: UILabel!
    
    override func awakeFromNib() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIConstants.ColorConstant.whitishGrayColor.cgColor
    }
    
    func showSpinner(inVeiw view: UIView, withInformation information: String? = "") {
        message.text = information
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate(
            [
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
                view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
                view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
                view.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0)
            ]
        )
        view.layoutIfNeeded()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        activityIndicator.startAnimating()
    }
    
    func hideSpinner() {
        activityIndicator.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        removeFromSuperview()
    }
}
