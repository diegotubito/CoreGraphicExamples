//
//  SkyView.swift
//  CGExample
//
//  Created by David Diego Gomez on 14/02/2021.
//

import UIKit

@IBDesignable
class ArcCell: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
       // drawBackground(rect: rect, context: context, colorSpace: colorSpace)
        drawArc(rect: rect, context: context, colorSpace: colorSpace)
       
    }
    
    func drawArc(rect: CGRect, context: CGContext, colorSpace: CGColorSpace) {
        context.saveGState()
        defer {
            context.restoreGState()
        }
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: rect.size.height - 0))
        path.addQuadCurve(to: CGPoint(x: rect.size.width - 0, y: rect.size.height - 0),
                          control: CGPoint(x: rect.size.width / 2, y: rect.size.height - 32))
        path.addLine(to: CGPoint(x: rect.size.width - 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.size.height - 0))
        
        context.addPath(path)
        context.clip()
    
        let gradient = CreateGradient()
        context.drawLinearGradient(gradient!,
                                   start: CGPoint(x: rect.size.width/2, y: 0),
                                   end: CGPoint(x: rect.size.width/2, y: rect.size.height - 0),
                                   options: [])
        
    
        
        context.setStrokeColor(UIColor.black.cgColor)
        context.strokePath()
        context.setFillColor(UIColor.green.cgColor)
        context.fillPath()
        
    }
    
    func drawBackground(rect: CGRect, context: CGContext, colorSpace: CGColorSpace) {
        context.saveGState()
        defer { context.restoreGState() }
        
        let baseColor = UIColor(red: 148.0 / 255.0, green: 158.0 / 255.0,
                                blue: 183.0 / 255.0, alpha: 1.0)
        let middleStop = UIColor(red: 127.0 / 255.0, green: 138.0 / 255.0,
                                 blue: 166.0 / 255.0, alpha: 1.0)
        let farStop = UIColor(red: 96.0 / 255.0, green: 111.0 / 255.0,
                              blue: 144.0 / 255.0, alpha: 1.0)
        
        let colors : [CGColor] = [baseColor.cgColor, middleStop.cgColor, farStop.cgColor]
        let location : [CGFloat] = [0.1, 0.25, 0.5]
        
        
        guard let gradient = CGGradient(colorsSpace: colorSpace,
                                        colors: colors as CFArray,
                                        locations: location) else {
            return
        }
        
        let startPoint = CGPoint(x: rect.size.height / 2, y: 0)
        let endPoint = CGPoint(x: rect.size.height / 2, y: rect.size.width)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }
    
    func CreateGradient() -> CGGradient? {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let baseColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0,
                                blue: 0.0 / 255.0, alpha: 1.0)
        let middleStop = UIColor(red: 50.0 / 255.0, green: 50.0 / 255.0,
                                 blue: 255.0 / 255.0, alpha: 1.0)
        let farStop = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0,
                              blue: 255.0 / 255.0, alpha: 1.0)
        
        let colors : [CGColor] = [baseColor.cgColor, middleStop.cgColor, farStop.cgColor]
        let location : [CGFloat] = [0.1, 0.25, 0.5]
        
        
        guard let gradient = CGGradient(colorsSpace: colorSpace,
                                        colors: colors as CFArray,
                                        locations: location) else {
            return nil
        }
        
        return gradient
    }
    
   
}
