import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    private let passwordResetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Password reset", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let signUpForm = SignUpForm()
        signUpForm.delegate = self

        signUpForm.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpForm)
        NSLayoutConstraint.activate([
            signUpForm.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            signUpForm.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signUpForm.leftAnchor.constraint(equalTo: view.leftAnchor),
            signUpForm.rightAnchor.constraint(equalTo: view.rightAnchor)
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

extension SignUpViewController: SignUpFormDelegate {
    func submit(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
                return
            }

            self.navigationController?.popToRootViewController(animated: true)
        }

        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        Auth.auth().currentUser?.link(with: credential)


        Auth.auth().currentUser?.getIDToken { idToken, error in
            SessionStore.shared.setIdToken(idToken!)
        }
    }
}
