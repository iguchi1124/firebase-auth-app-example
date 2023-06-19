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

            self.navigationController?.popToRootViewController(animated: true)
        }

        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        Auth.auth().currentUser?.link(with: credential)


        Auth.auth().currentUser?.getIDToken { idToken, error in
            SessionStore.shared.setIdToken(idToken!)
        }
    }
}
