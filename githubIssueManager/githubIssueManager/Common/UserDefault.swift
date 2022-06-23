import Foundation

@propertyWrapper
struct UserDefault {
    
    private let userDefault: UserDefaults = .standard
    private let key: UserDefaultKey
    
    var wrappedValue: String {
        get {
            return userDefault.string(forKey: key.value) ?? ""
        }
        set {
            userDefault.set(newValue, forKey: key.value)
        }
    }
    
    init(key: UserDefaultKey) {
        self.key = key
    }
}

extension UserDefault {
    
    enum UserDefaultKey {
        case authToken
        
        var value: String {
            switch self {
            case .authToken:
                return "Github_Access_Token"
            }
        }
    }
}
