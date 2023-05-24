//
//  ViewController.swift
//  NavBarAnimation
//
//  Created by Ion Sebastian Rodriguez Lara on 23/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var plusButton: UIButton!
    
    var isBarShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func plusIconPressed(_ sender: UIButton) {
        if !isBarShown {
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
                self.heightConstraint.constant = 200
                self.plusButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 0.25)
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
                self.heightConstraint.constant = 108
                self.plusButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi * 0.25)
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        isBarShown.toggle()
    }
    
}

