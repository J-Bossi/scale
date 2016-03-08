//
//  ViewModel.swift
//  scale
//
//  Created by Johannes Boß on 07.03.16.
//  Copyright © 2016 Johannes Boß. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class ViewModel {

    var output = PublishSubject<String?>()
    // var force = BehaviorSubject<CGFloat>(value: 1)
    let request = NSURLRequest(URL: NSURL(string: "https://api.github.com/users")!)
    // When user sets the slider, we request the user credential for that value
    var sliderVal: Float? {
        didSet {
            NSURLSession.sharedSession().rx_JSON(request).debug("my request").subscribeNext { dataFromNetworking in
                let json = JSON(dataFromNetworking)
                var userNumber = 0
                if self.sliderVal != nil {
                    userNumber = Int(self.sliderVal!)
                }
                if let login = json[userNumber]["login"].string {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.output.onNext(login)
                    })
                }
            }
                .addDisposableTo(disposeBag)
        }
    }

    let disposeBag = DisposeBag()
    var searchText: String? {
        didSet {
            if let text = searchText {
                getTweets(text)
            }
        }
    }
    // i really forgot comments
    func getTweets(query: String) {
        NSURLSession.sharedSession().rx_JSON(request).debug("my request").subscribeNext { dataFromNetworking in
            let json = JSON(dataFromNetworking)
            if let login = json[0]["login"].string {
                dispatch_async(dispatch_get_main_queue(), {
                    self.output.onNext(login)
                })
            }
        }
            .addDisposableTo(disposeBag)
    }

    init() {
    }
}
