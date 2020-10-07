//
//  UIView+Styling.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import UIKit

public struct UIViewStyle<T: UIView> {
    
    private let styling: (T) -> Void
    
    public init(styling: @escaping (T) -> Void) {
        self.styling = styling
    }

    public static func compose(_ styles: UIViewStyle<T>...)-> UIViewStyle<T> {
        
        return UIViewStyle { view in
            for style in styles {
                style.styling(view)
            }
        }
    }
    
    public func composing(with other: UIViewStyle<T>)-> UIViewStyle<T> {
        return UIViewStyle { view in
            self.styling(view)
            other.styling(view)
        }
    }
    
    public func composing(with otherStyling: @escaping (T) -> Void)-> UIViewStyle<T> {
        return self.composing(with: UIViewStyle(styling: otherStyling))
    }

    public func apply(to view: T) {
        styling(view)
    }

    public func apply(to views: T...) {
        for view in views {
            styling(view)
        }
    }
}
