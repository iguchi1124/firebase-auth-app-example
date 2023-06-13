import Foundation

class SessionStore {
    static let shared = SessionStore()

    let idTokenKey = "idToken"

    func setIdToken(_ idToken: String) {
        UserDefaults.standard.set(idToken, forKey: idTokenKey)
    }

    func getIdToken() -> String? {
        return UserDefaults.standard.string(forKey: idTokenKey)
    }
}
