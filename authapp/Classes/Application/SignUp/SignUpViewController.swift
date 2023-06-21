import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
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
    }
}

extension SignUpViewController: SignUpFormDelegate {
    func submit(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
                return
            }

            let credential = EmailAuthProvider.credential(withEmail: email, password: password)

            guard let user = authResult?.user else { return }
            user.link(with: credential) { authResult, error in
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
}
