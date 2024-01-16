// The Swift Programming Language
// https://docs.swift.org/swift-book

@resultBuilder
class SoinContainerBuilder {
    static func buildBlock(_ components: (String, SoinBuilder<Any>)...) -> [(String, SoinBuilder<Any>)] {
        components
    }
}

func soinContainer(
    @SoinContainerBuilder block: () -> [(String, SoinBuilder<Any>)]
) -> SoinContainer {
    let result = block()
    let builders = Dictionary(uniqueKeysWithValues: result)
    return SoinContainer(builders: builders)
}

class SoinContainer {
    private var builders = [String : SoinBuilder<Any>]()
    
    init(builders: [String : SoinBuilder<Any>] = [String : SoinBuilder<Any>]()) {
        self.builders = builders
    }
    
    func push(
        _ id: String,
        _ builder: SoinBuilder<Any>
    ) {
        builders[id] = builder
    }
    
    func poop(
        _ id: String
    ) -> Any? {
        return builders[id]?(container: self)
    }
}

extension SoinContainer {
    func poop<T: Any>(
        _ qualifier: String = "",
        _ type: T.Type = T.self
    ) -> T? {
        let id = "\(type)\(qualifier)"
        return poop(id) as? T
    }

    func callAsFunction<T: Any>(
        _ qualifier: String = ""
    ) -> T {
        if let data: T = poop(qualifier) {
            return data
        }
        fatalError("\(T.self) using qualifier \(qualifier) not found")
    }
}
