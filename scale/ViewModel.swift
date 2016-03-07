//
//  ViewModel.swift
//  scale
//
//  Created by Johannes Boß on 07.03.16.
//  Copyright © 2016 Johannes Boß. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel {
    var output = PublishSubject<String?>()
   // var force = BehaviorSubject<CGFloat>(value: 1)
    let request = NSURLRequest(URL: NSURL(string: "https://api.twitter.com/1.1/search/tweets.json?q=&geocode=-22.912214,-43.230182,1km&lang=pt&result_type=recent")!)
    let disposeBag = DisposeBag()
    var searchText :String? {
        didSet {
            if let text = searchText {
                getTweets(text)
            }
        }
    }

    func getTweets(query: String) {
        NSURLSession.sharedSession().rx_JSON(request).subscribeNext{ json in self.output = json as! PublishSubject<String?>}.addDisposableTo(disposeBag)
    }


    init() {


    }


}
