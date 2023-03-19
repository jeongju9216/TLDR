//
//  LoadingIndicator.swift
//  TLDR
//
//  Created by 유정주 on 2022/11/10.
//

import UIKit

struct LoadingIndicator {
    static func showLoading(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            let loadingIndicatorView: UIActivityIndicatorView
            loadingIndicatorView = UIActivityIndicatorView(style: .large)
            loadingIndicatorView.frame = viewController.view.frame //다른 UI가 눌리지 않도록
            loadingIndicatorView.color = .label
            viewController.view.addSubview(loadingIndicatorView)

            loadingIndicatorView.startAnimating()
        }
    }

    static func hideLoading(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            viewController.view.subviews.filter {
                $0 is UIActivityIndicatorView
            }.forEach {
                $0.removeFromSuperview()
            }
        }
    }
}
