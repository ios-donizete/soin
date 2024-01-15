//
//  SoinSingleton.swift
//
//
//  Created by Donizete Vida on 15/01/24.
//

class SoinSingleton<T : AnyObject> : SoinBuilder<T> {
    private var builder: (SoinContainer) -> T
    private var singleton: T? = nil

    init(builder: @escaping (SoinContainer) -> T) {
        self.builder = builder
    }

    override func callAsFunction(container: SoinContainer) -> T {
        if (singleton == nil) {
            singleton = builder(container)
        }
        return singleton!
    }
}
