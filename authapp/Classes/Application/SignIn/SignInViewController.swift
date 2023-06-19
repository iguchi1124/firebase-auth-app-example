import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
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
    }
}

extension SignInViewController: SignInFormDelegate {
    func submit(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
                return
            }

            self.navigationController?.popToRootViewController(animated: true)
        }

        Auth.auth().currentUser?.getIDToken { idToken, error in
            SessionStore.shared.setIdToken(idToken!)
        }
    }
}
