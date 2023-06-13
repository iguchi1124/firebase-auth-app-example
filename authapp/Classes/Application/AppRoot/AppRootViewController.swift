import UIKit
import FirebaseAuth

class AppRootViewController: UIViewController {
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        loginButton.addAction(.init { _ in self.login() }, for: .touchUpInside)

        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            loginButton.heightAnchor.constraint(equalToConstant: 100),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func login() {
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously()
        }

        Auth.auth().currentUser?.getIDToken { idToken, error in
            SessionStore.shared.setIdToken(idToken!)
        }

        let homeViewController = HomeViewController()
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
}
