// The Swift Programming Language
// https://docs.swift.org/swift-book

class SoinContainer {
    private var builders = [String : SoinBuilder<AnyObject>]()
    
    func push(
        _ id: String,
        _ builder: SoinBuilder<AnyObject>
    ) {
        builders[id] = builder
    }
    
    func poop(
        _ id: String
    ) -> AnyObject? {
        return builders[id]?(container: self)
    }
}

extension SoinContainer {
    func poop<T: AnyObject>(
        _ type: T.Type = T.self,
        _ qualifier: String = ""
    ) -> T? {
        let id = "\(type)\(qualifier)"
        return poop(id) as? T
    }

    func callAsFunction<T: AnyObject>(
        _ qualifier: String = ""
    ) -> T {
        if let data = poop(T.self, qualifier) {
            return data
        }
        fatalError("\(T.self) using qualifier \(qualifier) not found")
    }
}

extension SoinContainer {
    func factory<T: AnyObject>(
        _ qualifier: String = "",
        _ type: T.Type = T.self,
        _ builder: @escaping (SoinContainer) -> T
    ) {
        let id = "\(type)\(qualifier)"
        let factory = SoinFactory<AnyObject>(
            builder: builder
        )
        push(id, factory)
    }

    func singleton<T: AnyObject>(
        _ qualifier: String = "",
        _ type: T.Type = T.self,
        _ builder: @escaping (SoinContainer) -> T
    ) {
        let id = "\(type)\(qualifier)"
        let singleton = SoinSingleton<AnyObject>(
            builder: builder
        )
        push(id, singleton)
    }
}

extension SoinContainer {
    func factory<T: AnyObject>(
        _ builder: @escaping () -> T,
        _ qualifier: String = ""
    ) {
        factory(qualifier) { c in builder() }
    }

    func factory<T: AnyObject, A: AnyObject>(
        _ builder: @escaping (A) -> T,
        _ qualifier: String = ""
    ) {
        factory(qualifier) { c in builder(c()) }
    }
    
    func factory<T: AnyObject, A: AnyObject, B: AnyObject>(
        _ builder: @escaping (A, B) -> T,
        _ qualifier: String = ""
    ) {
        factory(qualifier) { c in builder(c(), c()) }
    }
}

extension SoinContainer {
    func singleton<T: AnyObject>(
        _ builder: @escaping () -> T,
        _ qualifier: String = ""
    ) {
        singleton(qualifier) { c in builder() }
    }
    
    func singleton<T: AnyObject, A: AnyObject>(
        _ builder: @escaping (A) -> T,
        _ qualifier: String = ""
    ) {
        singleton(qualifier) { c in builder(c()) }
    }

    func singleton<T: AnyObject, A: AnyObject, B: AnyObject>(
        _ builder: @escaping (A, B) -> T,
        _ qualifier: String = ""
    ) {
        singleton(qualifier) { c in builder(c(), c()) }
    }
}
