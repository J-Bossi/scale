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
    @IBOutlet weak var searchText : UITextField!

    let viewModel = ViewModel()

    let disposeBag = DisposeBag()

    var currentForce: CGFloat!



    override func viewDidLoad() {
        super.viewDidLoad()
        //Binding the UI
        viewModel.searchText.asObservable().bindTo(searchText.rx_text).addDisposableTo(disposeBag)
        viewModel.output.asObservable().bindTo(outputLabel.rx_text).addDisposableTo(disposeBag)
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
        searchText.resignFirstResponder()
    }

    func forceToGrams(force:CGFloat) -> String{
        return String(format: "%.2f g", (force)/CGFloat(0.02))
    }

}

