//
//  ViewController.swift
//  scale
//
//  Created by Johannes Boß on 06.02.16.
//  Copyright © 2016 Johannes Boß. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var grams: UILabel!


    var currentForce: CGFloat! = 0
    var tara: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch?

        currentForce = touch!.force
        grams.text = forceToGrams(currentForce)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch?

        currentForce = touch!.force
        grams.text = forceToGrams(currentForce)
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        currentForce = 0
        grams.text = forceToGrams(currentForce)
    }

    @IBAction func taraButton(sender: AnyObject) {
        tara = currentForce
        grams.text = forceToGrams(currentForce)
    }

    func forceToGrams(force:CGFloat) -> String{
        return String(format: "%.2f g", (force-tara)/CGFloat(0.02))
    }


}

