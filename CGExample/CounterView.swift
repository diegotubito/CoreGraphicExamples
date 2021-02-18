//
//  CounterView.swift
//  CGExample
//
//  Created by David Diego Gomez on 12/02/2021.
//

import UIKit

@IBDesignable
class CounterView: UIView {
    @IBOutlet weak var counterLabel : UILabel!
    
    @IBInspectable var backgroundArcColor : UIColor = .brown
    @IBInspectable var backgroundArcLineColor : UIColor = .blue
    @IBInspectable var foregroundArcColor : UIColor = .cyan
    @IBInspectable var foregroundArcLineColor : UIColor = .yellow
    @IBInspectable var startAngle : Float = 0
    @IBInspectable var endAngle : Float = 180
    @IBInspectable var innerRadius : Float = 0.5
    
    public var percentege : Float = 0.0
    public var maxNumber : Int = 20
    public var counter : Int = 0 {
        didSet {
            print("need display")
            if counter > maxNumber {
                counter = 20
            } else if counter < 0 {
                counter = 0
            }
            percentege = Float(counter) / Float(maxNumber)
            counterLabel.text = String(counter)
            setNeedsDisplay()
        }
    }
    
    private var clockwise : Bool = true
    
    private struct Constants {
        static let backgroundArcLineWidth : CGFloat = 5
        static let separationFromBorder = 0
    }
    private var halfWidth : CGFloat {
        return self.bounds.width / 2
    }
    
    private var halfHeight : CGFloat {
        return self.bounds.height / 2
    }
    
    private var innerRaidusAjusted : CGFloat {
        let radius = min(halfWidth, halfHeight)
        return (radius * CGFloat(innerRadius)) - Constants.backgroundArcLineWidth
    }
    
    private var outerRadius : CGFloat {
        let radius = min(halfWidth, halfHeight) - Constants.backgroundArcLineWidth
        return radius
    }
    
    override func draw(_ rect: CGRect) {
        let startAngleRadians : CGFloat = -(CGFloat(startAngle) * .pi) / 180
        let endAngleRadians : CGFloat =  -(CGFloat(endAngle) * .pi) / 180
        
        
        let center = CGPoint(x: halfHeight, y: halfHeight)
        
       // background arc
        let backgroundArc = UIBezierPath(arcCenter: center,
                                     radius: outerRadius,
                                     startAngle: endAngleRadians,
                                     endAngle: startAngleRadians,
                                     clockwise: clockwise)
        
        backgroundArc.addArc(withCenter: center,
                         radius: innerRaidusAjusted,
                         startAngle: startAngleRadians,
                         endAngle: endAngleRadians,
                         clockwise: !clockwise)
        backgroundArc.close()
        backgroundArc.lineJoinStyle = .miter
        backgroundArcColor.setFill()
        backgroundArcLineColor.setStroke()
        backgroundArc.lineWidth = Constants.backgroundArcLineWidth
        backgroundArc.stroke()
        backgroundArc.fill()
        
        
        // foreground arc
        let angleInterval : CGFloat = CGFloat(abs(endAngle - startAngle))
        let addingAngle : CGFloat = CGFloat(angleInterval * CGFloat(percentege))

//        let start : CGFloat = CGFloat(endAngle) * .pi / 180
//        let end : CGFloat = start + (addingAngle * .pi / 180)
//
//        let foreArc = UIBezierPath(arcCenter: center,
//                                   radius: outerRadius,
//                                   startAngle: start,
//                                   endAngle: end,
//                                   clockwise: clockwise)
//        foreArc.addArc(withCenter: center,
//                       radius: innerRaidusAjusted,
//                       startAngle: end,
//                       endAngle: start,
//                       clockwise: !clockwise)
        
        let diff : CGFloat = (angleInterval - addingAngle)
        let start = -(CGFloat(CGFloat(startAngle) + diff) * .pi) / 180
        let end = -(CGFloat(endAngle) * .pi) / 180

        let foreArc = UIBezierPath(arcCenter: center,
                                         radius: outerRadius,
                                         startAngle: start,
                                         endAngle: end,
                                         clockwise: !clockwise)

        foreArc.addArc(withCenter: center,
                             radius: innerRaidusAjusted,
                             startAngle: end,
                             endAngle: start,
                             clockwise: clockwise)
        
        foreArc.close()
        foregroundArcColor.setFill()
        foregroundArcLineColor.setStroke()
        foreArc.lineWidth = Constants.backgroundArcLineWidth
        foreArc.stroke()
        foreArc.fill()
        
    }
}
