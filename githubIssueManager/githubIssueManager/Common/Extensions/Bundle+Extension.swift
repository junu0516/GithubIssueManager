import Foundation

extension Bundle {
    
    var githubClientId: String {
        guard let filePath = self.path(forResource: "GithubKeys", ofType: "plist"),
              let plistData = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
              let plistMap = try? PropertyListSerialization.propertyList(from: plistData, format: nil) as? [String:String],
              let clientId = plistMap["Github_Client_ID"] else {
            fatalError("failed to get clientId from bundle")
        }

        return clientId
    }
}
