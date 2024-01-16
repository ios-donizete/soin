//
//  SoinSingleton.swift
//
//
//  Created by Donizete Vida on 15/01/24.
//

class SoinSingleton<T : Any> : SoinBuilder<T> {
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

extension SoinContainer {
    func singleton<T: Any>(
        _ qualifier: String = "",
        _ builder: @escaping (SoinContainer) -> T
    ) {
        let (id, singleton) = soinSingleton(qualifier, T.self, builder)
        push(id, singleton)
    }
    
    func singleton<T: Any>(
        _ builder: @escaping () -> T,
        _ qualifier: String = ""
    ) {
        singleton(qualifier) { c in builder() }
    }
    
    func singleton<T: Any, A: Any>(
        _ builder: @escaping (A) -> T,
        _ qualifier: String = ""
    ) {
        singleton(qualifier) { c in builder(c()) }
    }
    
    func singleton<T: Any, A: Any, B: Any>(
        _ builder: @escaping (A, B) -> T,
        _ qualifier: String = ""
    ) {
        singleton(qualifier) { c in builder(c(), c()) }
    }
}

func soinSingleton<T: Any>(
    _ qualifier: String = "",
    _ type: T.Type = T.self,
    _ builder: @escaping (SoinContainer) -> T
) -> (String, SoinBuilder<Any>){
    let id = "\(type)\(qualifier)"
    let factory = SoinSingleton<Any>(
        builder: builder
    )
    return (id, factory)
}

func soinSingleton<T: Any>(
    _ builder: @escaping () -> T,
    _ qualifier: String = ""
) -> (String, SoinBuilder<Any>) {
    soinSingleton(qualifier) { c in builder() }
}

func soinSingleton<T: Any, A: Any>(
    _ builder: @escaping (A) -> T,
    _ qualifier: String = ""
) -> (String, SoinBuilder<Any>) {
    soinSingleton(qualifier) { c in builder(c()) }
}

func soinSingleton<T: Any, A: Any, B: Any>(
    _ builder: @escaping (A, B) -> T,
    _ qualifier: String = ""
) -> (String, SoinBuilder<Any>) {
    soinSingleton(qualifier) { c in builder(c(), c()) }
}
