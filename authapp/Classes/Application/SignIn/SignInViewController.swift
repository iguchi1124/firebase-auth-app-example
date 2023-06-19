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
        SessionStore.shared.clear()

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user else { return }
        }

        Auth.auth().currentUser?.getIDToken { idToken, error in
            SessionStore.shared.setIdToken(idToken!)
        }

        self.navigationController?.popToRootViewController(animated: true)
    }
}
