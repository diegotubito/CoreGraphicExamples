//
//  BasicPath.swift
//  CGExample
//
//  Created by David Diego Gomez on 14/02/2021.
//

import UIKit

//class DrawingCanvas: UIImageView {
//    
//    var currentTouchPosition: CGPoint?
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        isUserInteractionEnabled = true
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        guard let newTouchPoint = touches.first?.location(in: self) else { return }
//        
//        currentTouchPosition = newTouchPoint
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let newTouchPoint = touches.first?.location(in: self) else { return }
//        guard let previousTouchPoint = currentTouchPosition else { return }
//        let renderer = UIGraphicsImageRenderer(size: bounds.size)
//        
//        image = renderer.image { ctx in
//            image?.draw(in: bounds)
//            UIColor.red.setStroke()
//            ctx.cgContext.setLineCap(.round)
//            ctx.cgContext.setLineWidth(5)
//            ctx.cgContext.move(to: previousTouchPoint)
//            ctx.cgContext.addLine(to: newTouchPoint)
//            ctx.cgContext.strokePath()
//        }
//        
//        currentTouchPosition = newTouchPoint
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        currentTouchPosition = nil
//    }
//}



class DrawingCanvas: UIView {
    
    // we use a multi-dimensional array to store separate lines, otherwise
    // all your lines will be connected
    var lines = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // create a new line
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let newTouchPoint = touches.first?.location(in: self) else { return }
        
        // use `indices` to safetly modify the last element
        if let lastIndex = lines.indices.last {
            lines[lastIndex].append(newTouchPoint)
        }
        
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(5)
        context.setLineCap(.round)
        
        lines.forEach { (line) in
            for (index, point) in line.enumerated() {
                if index == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
        }
        context.strokePath()
    }
}
