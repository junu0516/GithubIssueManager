import Foundation

protocol BasicViewModel: AnyObject {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get}
}

