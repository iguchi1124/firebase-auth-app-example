import UIKit
import FirebaseAuth

class SignInWithCustomTokenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let signInWithCustomTokenForm = SignInWithCustomTokenForm()
        signInWithCustomTokenForm.delegate = self
        signInWithCustomTokenForm.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signInWithCustomTokenForm)
        NSLayoutConstraint.activate([
            signInWithCustomTokenForm.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            signInWithCustomTokenForm.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signInWithCustomTokenForm.leftAnchor.constraint(equalTo: view.leftAnchor),
            signInWithCustomTokenForm.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func presentPasswordResetView() {
        let passwordResetViewController = PasswordResetViewController()
        self.navigationController?.pushViewController(passwordResetViewController, animated: true)
    }
}

extension SignInWithCustomTokenViewController: SignInWithCustomTokenFormDelegate {
    func submit(customToken: String) {
        Auth.auth().signIn(withCustomToken: customToken) { authResult, error in
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
