import Foundation

protocol BasicViewModel {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get}
}
