import Foundation

final class Observable<T> {
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    var value: T? {
        didSet {
            if let value = self.value {
                listener?(value)
            }
        }
    }
    
    init() { }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping Listener) {
        self.listener = listener
        if let value = self.value {
            listener(value)
        }
    }
}
