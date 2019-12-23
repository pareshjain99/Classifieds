//
//  ClassifiedItemViewModel.swift
//  DubizzleClassified
//
//  Created by PareshJain on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ClassifiedItemViewModel {

    let loadData = PublishSubject<Void>()
    let dataLodingInProgress = PublishSubject<Bool>()
    var classifiedItems: [ClassifiedItem]?
    var filterClassifiedItems: [ClassifiedItem]?
    
    var isLoadingdata : Bool = true {
        didSet {
            dataLodingInProgress.onNext((isLoadingdata))
        }
    }
    
    init() {
        self.fetchData()
    }
    
    func fetchData() {
        isLoadingdata = true
        APIManager.fetchData(completion: { response  in
            self.classifiedItems = response
            self.filterClassifiedItems = response
            self.isLoadingdata = false
            self.loadData.onNext(())
        })
    }
    
    func numberOfRows() -> Int {
        if isLoadingdata {
            return 6
        }
        return self.filterClassifiedItems?.count ?? 0
    }
}
