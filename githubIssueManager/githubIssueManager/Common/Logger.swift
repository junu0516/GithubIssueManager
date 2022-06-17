import Foundation
import OSLog

final class Log {
    private static let logger = Logger()
    
    static func debug(_ message: String) {
        logger.debug("\(message)")
    }
    
}
