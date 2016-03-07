//
//  ViewController.swift
//  scale
//
//  Created by Johannes Boß on 06.02.16.
//  Copyright © 2016 Johannes Boß. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var grams: UILabel!
    @IBOutlet weak var outputLabel : UILabel!

    let request = NSURLRequest(URL: NSURL(string: "https://api.twitter.com/1.1/search/tweets.json?q=&geocode=-22.912214,-43.230182,1km&lang=pt&result_type=recent")!)

    var currentForce: CGFloat!



    override func viewDidLoad() {
        super.viewDidLoad()
        let responseJSON = NSURLSession.sharedSession().rx_JSON(request)

        // no requests will be performed up to this point
        // `responseJSON` is just a description how to fetch the response

        let cancelRequest = responseJSON
            // this will fire the request
            .subscribeNext { json in
                print(json)
        }

        NSThread.sleepForTimeInterval(3)

        // if you want to cancel request after 3 seconds have passed just call
        cancelRequest.dispose()
    }

    func setupEverything() {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch?

        currentForce = touch?.force

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

    @IBAction func cancelButton(sender: AnyObject) {

    }

    func forceToGrams(force:CGFloat) -> String{
        return String(format: "%.2f g", (force)/CGFloat(0.02))
    }

}

