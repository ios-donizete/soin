//
//  SoinFactory.swift
//
//
//  Created by Donizete Vida on 15/01/24.
//

class SoinFactory<T: AnyObject> : SoinBuilder<T> {
    private var builder: (SoinContainer) -> T

    init(builder: @escaping (SoinContainer) -> T) {
        self.builder = builder
    }

    override func callAsFunction(container: SoinContainer) -> T {
        return builder(container)
    }
}
