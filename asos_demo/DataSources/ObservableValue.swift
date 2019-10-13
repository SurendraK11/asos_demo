//
//  ObservableValue.swift
//
//  Created by Surendra
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation


/// ObservableValue is class which notifies client when it's value property get
/// updated. It works as reactive manor
class ObservableValue<T> {
    
    typealias CompletionHandler = (() -> Void)
    private var observers = [String : CompletionHandler]()
    
    ///value generic type
    var value: T? {
        didSet {
            notify()
        }
    }
    
    init(withValue value: T?) {
        self.value = value
    }
    
    deinit {
        observers.removeAll()
    }
    
    /// Responsible to remove all observers registered for value
    /// This must be called from client to safly remvoe all objects
    func disposeBag() {
        observers.removeAll()
    }
    
    func addObserver(withCompletionHandler completionHandler: @escaping CompletionHandler) {
        observers[UUID().uuidString] = completionHandler
    }
    
    func addAndNotifyObserver(withCompletionHandler completionHandler: @escaping CompletionHandler)  {
        observers[UUID().uuidString] = completionHandler
        notify()
    }
    
    private func notify() {
        observers.forEach({ $0.value() })
    }
}
