//
//  SoinBuilder.swift
//
//
//  Created by Donizete Vida on 15/01/24.
//

class SoinBuilder<T : AnyObject> {
    func callAsFunction(container: SoinContainer) -> T {
        fatalError("Should be implemented by subclasses")
    }
}
