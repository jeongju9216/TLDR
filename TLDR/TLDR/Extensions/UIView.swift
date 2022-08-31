//
//  UIView.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

extension UIView {
    func centerX(to anchor: NSLayoutXAxisAnchor, offset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
    }
    
    func centerY(to anchor: NSLayoutYAxisAnchor, offset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
    }
    
    func pinCenter(ofView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func pinLeft(to anchor: NSLayoutXAxisAnchor, offset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
    }
    
    func pinRight(to anchor: NSLayoutXAxisAnchor, offset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rightAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
    }
    
    func pinTop(to anchor: NSLayoutYAxisAnchor, offset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
    }
    
    func pinBottom(to anchor: NSLayoutYAxisAnchor, offset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
    }
}
