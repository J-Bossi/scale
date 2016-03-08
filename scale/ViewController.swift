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

    @IBOutlet var avatarImageViewForUser: UIImageView!
    @IBOutlet weak var grams: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet var userCredentialsSlider: UISlider!

    let viewModel = ViewModel()

    let disposeBag = DisposeBag()

    var currentForce: CGFloat! = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Binding the UI
        searchText.rx_text.subscribeNext { searchText in self.viewModel.searchText = searchText }.addDisposableTo(disposeBag)
        userCredentialsSlider.rx_value.subscribeNext { floatValue in
            self.viewModel.sliderVal = floatValue
        }.addDisposableTo(disposeBag)

        viewModel.output.subscribeNext { str in
            if (str != nil) {
                self.outputLabel.text = str
            }
        }.addDisposableTo(disposeBag)
        viewModel.avatarImage.subscribeNext { img in
            self.avatarImageViewForUser.image = img
        }.addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch?
        currentForce = touch?.force
        forceObserver(currentForce).subscribeNext {value in
            self.grams.text = self.forceToGrams(value)
        }.addDisposableTo(disposeBag)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch?
        currentForce = touch?.force
        forceObserver(currentForce).subscribeNext {value in
            self.grams.text = self.forceToGrams(value)
        }.addDisposableTo(disposeBag)
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        currentForce = 0
        forceObserver(currentForce).subscribeNext {value in
            self.grams.text = self.forceToGrams(value)
        }.addDisposableTo(disposeBag)
    }

    func forceObserver(element: CGFloat) -> Observable<CGFloat> {
        return Observable.create { observer in
            observer.on(.Next(element))
            return NopDisposable.instance
        }
    }

    @IBAction func cancelButton(sender: AnyObject) {
        searchText.resignFirstResponder()
    }

    func forceToGrams(force: CGFloat) -> String {
        return String(format: "%.2f g", (force) / CGFloat(0.02))
    }
}
