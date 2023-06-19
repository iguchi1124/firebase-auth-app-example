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
        SessionStore.shared.clear()

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user else { return }
        }

        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        Auth.auth().currentUser?.link(with: credential)


        Auth.auth().currentUser?.getIDToken { idToken, error in
            SessionStore.shared.setIdToken(idToken!)
        }

        self.navigationController?.popToRootViewController(animated: true)
    }
}
