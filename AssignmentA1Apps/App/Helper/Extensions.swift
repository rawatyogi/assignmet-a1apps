//
//  Extensions.swift
//  AssignmentA1Apps
//
//  Created by Yogi Rawat on 19/09/25.
//

import UIKit
import Foundation

extension UIView {
    
    func applyGradient(colors: [UIColor]) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint   = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func makeRounded(radius: CGFloat, corners: Bool = true) {
        self.layer.cornerRadius = radius
        if corners {
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        self.clipsToBounds = true
    }
    
    func addShadow(color: UIColor = .black,
                   opacity: Float = 0.2,
                   offset: CGSize = .zero,
                   radius: CGFloat = 6,
                   cornerRadius: CGFloat = 0) {
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        
        if cornerRadius > 0 {
            self.layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: cornerRadius
            ).cgPath
        }
    }
    
    func addCornerRadiusWithShadow(cornerRadius: CGFloat,
                                   shadowColor: UIColor = .black,
                                   shadowOpacity: Float = 0.2,
                                   shadowOffset: CGSize = .zero,
                                   shadowRadius: CGFloat = 4) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
    
    func createFooterLoader(showLoader: Bool = false) -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 60))
        footerView.backgroundColor = .blue
        let loader = UIActivityIndicatorView(style: .large)
        loader.center = CGPoint(x: footerView.frame.width/2, y: footerView.frame.height/2)
        loader.color = .red
        
        if showLoader {
            loader.startAnimating()
        } else {
            loader.stopAnimating()
        }
        
        footerView.addSubview(loader)
        return footerView
    }
}

extension UITableView {
    
    func registerCell(identifier: UITableViewCell.Type) {
        let id = String(describing: identifier)
        self.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
        
    }
}

extension UIViewController {
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
    }
}
