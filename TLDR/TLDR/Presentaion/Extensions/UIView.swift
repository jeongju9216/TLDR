//
//  UIView.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

extension UIView {
    func pinCenter(ofView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func pinCenterX(to anchor: NSLayoutXAxisAnchor, offset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
    }
    
    func pinCenterY(to anchor: NSLayoutYAxisAnchor, offset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
    }
    
    func pinWidth(to anchor: NSLayoutAnchor<NSLayoutDimension>? = nil, constant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let anchor = anchor {
            self.widthAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        } else {
            self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        }
    }
    
    func pinHeight(to anchor: NSLayoutAnchor<NSLayoutDimension>? = nil, constant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let anchor = anchor {
            self.heightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        } else {
            self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        }
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
