import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    private let passwordResetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let signInForm = SignInForm()
        signInForm.delegate = self
        signInForm.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signInForm)
        NSLayoutConstraint.activate([
            signInForm.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            signInForm.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signInForm.leftAnchor.constraint(equalTo: view.leftAnchor),
            signInForm.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        view.addSubview(passwordResetButton)
        passwordResetButton.addAction(.init { _ in self.presentPasswordResetView() }, for: .touchUpInside)
        NSLayoutConstraint.activate([
            passwordResetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            passwordResetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func presentPasswordResetView() {
        let passwordResetViewController = PasswordResetViewController()
        self.navigationController?.pushViewController(passwordResetViewController, animated: true)
    }
}

extension SignInViewController: SignInFormDelegate {
    func submit(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
                return
            }

            guard let user = authResult?.user else { return }
            user.getIDToken { idToken, error in
                SessionStore.shared.setIdToken(idToken!)
            }

            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
