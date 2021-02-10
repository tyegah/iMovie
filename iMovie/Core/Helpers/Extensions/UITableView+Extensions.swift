//
//  UITableView+Extensions.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
    
    func registerCell(_ type:UITableViewCell.Type) {
        self.register(UINib(nibName: String(describing: type.self), bundle: nil), forCellReuseIdentifier: String(describing: type.self))
    }
}

extension UIViewController {
    @objc func toggleLoadingView(_ isLoading: Bool) {
        if isLoading {
            self.show()
        }
        else {
            self.hide()
        }
    }
    
    private func show() {
        DispatchQueue.main.async { [weak self] in
            self?.view.removeOverlayLoader()
            self?.view.showOverlayLoader()
        }
    }
    
    private func hide() {
        DispatchQueue.main.async { [weak self] in
            self?.view.removeOverlayLoader()
        }
    }
    
    @objc func hideRefreshView() {
        let v = self.view.viewWithTag(1001)
        v?.removeFromSuperview()
    }
    
    @objc func showRefreshView(_ target:UIViewController, onRetry: Selector, message:String) {
        let refreshView = UINib.init(nibName: "RefreshView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as! RefreshView
        refreshView.tag = 1001
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        refreshView.alpha = 0
        self.view.addSubview(refreshView)
        refreshView.layer.cornerRadius = 5.0
        refreshView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        refreshView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width - 32).isActive = true
        refreshView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        refreshView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        refreshView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.frame.size.height/2 - 160).isActive = true
        refreshView.retryButton.addTarget(target, action: onRetry, for: .touchUpInside)
        refreshView.messageLabel.text = message
        self.view.bringSubviewToFront(refreshView)
        
        UIView.animate(withDuration: 1.0, animations: {
            refreshView.alpha = 0
        }) { (success) in
            refreshView.alpha = 0.8
        }
    }
}

extension UIView {
    func showOverlayLoader() {
        let overlayLoader = OverlayLoader(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        self.addSubview(overlayLoader)
        self.bringSubviewToFront(overlayLoader)
    }

    func removeOverlayLoader() {
        if let overlayLoader = subviews.first(where: { $0 is OverlayLoader }) {
            overlayLoader.removeFromSuperview()
        }
    }
    
    func showBlurLoader() {
        let blurLoader = BlurLoader(frame: frame)
        self.addSubview(blurLoader)
    }

    func removeBluerLoader() {
        if let blurLoader = subviews.first(where: { $0 is BlurLoader }) {
            blurLoader.removeFromSuperview()
        }
    }
}

class OverlayLoader: UIView {
    var overlayView: UIView?
    override init(frame: CGRect) {
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        self.overlayView = view
        super.init(frame: frame)
        addSubview(view)
        addLoader()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addLoader() {
        guard let overlayView = overlayView else { return }
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        overlayView.addSubview(activityIndicator)
        activityIndicator.center = overlayView.center
        activityIndicator.startAnimating()
    }
}

class BlurLoader: UIView {

    var blurEffectView: UIVisualEffectView?

    override init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView = blurEffectView
        super.init(frame: frame)
        addSubview(blurEffectView)
        addLoader()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addLoader() {
        guard let blurEffectView = blurEffectView else { return }
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        activityIndicator.startAnimating()
    }
}

extension UIImageView {
    func setImageAnimated(_ newImage: UIImage?) {
        image = newImage
        
        guard newImage != nil else { return }
        
        alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
}
