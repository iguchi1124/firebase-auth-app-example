import UIKit
import FirebaseAuth

class AppRootViewController: UIViewController {
    private let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        startButton.addAction(.init { _ in self.login() }, for: .touchUpInside)

        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.widthAnchor.constraint(equalToConstant: 300),
            startButton.heightAnchor.constraint(equalToConstant: 100),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func login() {
        let homeViewController = HomeViewController()
        let navigationViewController = UINavigationController(rootViewController: homeViewController)
        navigationViewController.modalPresentationStyle = .fullScreen

        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously() { authResult, error in
                if let error = error {
                    self.showMessagePrompt(error.localizedDescription)
                    return
                }

                guard let user = authResult?.user else { return }
                user.getIDToken { idToken, error in
                    SessionStore.shared.setIdToken(idToken!)
                }

                self.present(navigationViewController, animated: true)
            }
        } else {
            self.present(navigationViewController, animated: true)
        }
    }
}
