//
//  UIView+Extensions.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(top: (NSLayoutYAxisAnchor, CGFloat)? = nil, bottom: (NSLayoutYAxisAnchor, CGFloat)? = nil, leading: (NSLayoutXAxisAnchor, CGFloat)? = nil, trailing: (NSLayoutXAxisAnchor, CGFloat)? = nil, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top.0, constant: top.1).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom.0, constant: -bottom.1).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading.0, constant: leading.1).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing.0, constant: -trailing.1).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
    
    func anchorToSuperview() {
        guard let superview = superview else { return }
        anchor(top: (superview.topAnchor, 0), bottom: (superview.bottomAnchor, 0), leading: (superview.leadingAnchor, 0), trailing: (superview.trailingAnchor, 0))
    }
    
    func anchorToSafeArea() {
        guard let superview = superview else { return }
        if #available(iOS 11.0, *) {
            anchor(top: (superview.safeAreaLayoutGuide.topAnchor, 0), bottom: (superview.safeAreaLayoutGuide.bottomAnchor, 0), leading: (superview.safeAreaLayoutGuide.leadingAnchor, 0), trailing: (superview.safeAreaLayoutGuide.trailingAnchor, 0))
        } else {
            anchorToSuperview()
        }
    }
    
    func anchorFromSuperview(points: CGFloat) {
        guard let superview = superview else { return }
        anchor(top: (superview.topAnchor, points), bottom: (superview.bottomAnchor, points), leading: (superview.leadingAnchor, points), trailing: (superview.trailingAnchor, points))
    }
    
    func anchorFromSafeArea(points: CGFloat) {
        guard let superview = superview else { return }
        if #available(iOS 11.0, *) {
            anchor(top: (superview.safeAreaLayoutGuide.topAnchor, points), bottom: (superview.safeAreaLayoutGuide.bottomAnchor, points), leading: (superview.safeAreaLayoutGuide.leadingAnchor, points), trailing: (superview.safeAreaLayoutGuide.trailingAnchor, points))
        } else {
            anchorFromSuperview(points: points)
        }
    }
    
    func centerIn(_ view: UIView, constants: (x: CGFloat, y: CGFloat) = (x: 0, y: 0)) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constants.x).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constants.y).isActive = true
    }
    
    func centerYInSuperview() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func centerXInSuperview() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
    
    func equalSizeTo(_ view: UIView, multipliers: (width: CGFloat, height: CGFloat) = (width: 1, height: 1)) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multipliers.width).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multipliers.height).isActive = true
    }
}
