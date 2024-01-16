//
//  SoinFactory.swift
//
//
//  Created by Donizete Vida on 15/01/24.
//

class SoinFactory<T: Any> : SoinBuilder<T> {
    private var builder: (SoinContainer) -> T
    
    init(builder: @escaping (SoinContainer) -> T) {
        self.builder = builder
    }
    
    override func callAsFunction(container: SoinContainer) -> T {
        return builder(container)
    }
}

extension SoinContainer {
    func factory<T: Any>(
        _ qualifier: String = "",
        _ builder: @escaping (SoinContainer) -> T
    ) {
        let (id, factory) = soinFactory(qualifier, T.self, builder)
        push(id, factory)
    }

    func factory<T: Any>(
        _ builder: @escaping () -> T,
        _ qualifier: String = ""
    ) {
        factory(qualifier) { c in builder() }
    }
    
    func factory<T: Any, A: Any>(
        _ builder: @escaping (A) -> T,
        _ qualifier: String = ""
    ) {
        factory(qualifier) { c in builder(c()) }
    }
    
    func factory<T: Any, A: Any, B: Any>(
        _ builder: @escaping (A, B) -> T,
        _ qualifier: String = ""
    ) {
        factory(qualifier) { c in builder(c(), c()) }
    }
}

func soinFactory<T: Any>(
    _ qualifier: String = "",
    _ type: T.Type = T.self,
    _ builder: @escaping (SoinContainer) -> T
) -> (String, SoinBuilder<Any>){
    let id = "\(type)\(qualifier)"
    let factory = SoinFactory<Any>(
        builder: builder
    )
    return (id, factory)
}

func soinFactory<T: Any>(
    _ builder: @escaping () -> T,
    _ qualifier: String = ""
) -> (String, SoinBuilder<Any>) {
    soinFactory(qualifier) { c in builder() }
}

func soinFactory<T: Any, A: Any>(
    _ builder: @escaping (A) -> T,
    _ qualifier: String = ""
) -> (String, SoinBuilder<Any>) {
    soinFactory(qualifier) { c in builder(c()) }
}

func soinFactory<T: Any, A: Any, B: Any>(
    _ builder: @escaping (A, B) -> T,
    _ qualifier: String = ""
) -> (String, SoinBuilder<Any>) {
    soinFactory(qualifier) { c in builder(c(), c()) }
}
