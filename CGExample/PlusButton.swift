//
//  GraphView.swift
//  CGExample
//
//  Created by David Diego Gomez on 11/02/2021.
//

import UIKit

@IBDesignable
class PlusButton: UIButton {
    @IBInspectable var fillColor : UIColor = .black
    @IBInspectable var isPlusButton : Bool = true

    private struct Constants {
        static let plusLineWith : CGFloat = 6.0
        static let plusButtonScale : CGFloat = 0.6
        static let halfPointShift : CGFloat = 0.5
    }
    
    private var halfWidth : CGFloat {
        return self.bounds.width / 2
    }
    
    private var halfHeight : CGFloat {
        return self.bounds.height / 2
    }
    
    override func draw(_ rect: CGRect) {
        fillColor.setFill()
        let path = UIBezierPath(ovalIn: rect)
        path.fill()
        
        let linePath = UIBezierPath()
        linePath.lineWidth = Constants.plusLineWith
        linePath.move(to: CGPoint(x: halfWidth / 2, y: halfHeight))
        linePath.addLine(to: CGPoint(x: halfWidth + (halfWidth / 2), y: halfHeight))
        if isPlusButton {
            linePath.move(to: CGPoint(x: halfWidth, y: halfHeight / 2))
            linePath.addLine(to: CGPoint(x: halfWidth, y: halfHeight + (halfHeight / 2)))
        }
        linePath.lineCapStyle = .round
        UIColor.white.setStroke()
        linePath.stroke()
        
    }
}
