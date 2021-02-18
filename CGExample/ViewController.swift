//
//  ViewController.swift
//  CGExample
//
//  Created by David Diego Gomez on 11/02/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawingCanvas: DrawingCanvas!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var plusButton: PlusButton!
    @IBOutlet weak var minusButton: PlusButton!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var counterView: CounterView!
    
    var isGraphVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(plusButtonDidPress))
        plusButton.addGestureRecognizer(tap)
        
        let minusTap = UITapGestureRecognizer(target: self, action: #selector(minusDidPress))
        minusButton.addGestureRecognizer(minusTap)
        
       
        graphView.isHidden = true
        let grapViewTap = UITapGestureRecognizer(target: self, action: #selector(graphViewDidTap))
        containerView.addGestureRecognizer(grapViewTap)
        
        
        
    }
    
    @objc func graphViewDidTap() {
        if isGraphVisible {
            UIView.transition(from: graphView,
                              to: counterView,
                              duration: 0.5,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews],
                              completion: nil)
        } else {
            UIView.transition(from: counterView,
                              to: graphView,
                              duration: 0.5,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        }
        
        isGraphVisible.toggle()
    }
    
    @objc func plusButtonDidPress() {
        if isGraphVisible {
            graphViewDidTap()
        }
        counterView.counter += 1
    }
    
    @objc func minusDidPress() {
        if isGraphVisible {
            graphViewDidTap()
        }
        counterView.counter -= 1
    }
    
}

