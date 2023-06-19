import UIKit
import FirebaseAuth

class PasswordResetViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let passwordResetForm = PasswordResetForm()
        passwordResetForm.delegate = self

        passwordResetForm.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordResetForm)
        NSLayoutConstraint.activate([
            passwordResetForm.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            passwordResetForm.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            passwordResetForm.leftAnchor.constraint(equalTo: view.leftAnchor),
            passwordResetForm.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension PasswordResetViewController: PasswordResetFormDelegate {
    func submit(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
                return
            }

            self.showMessagePrompt("sent reset mail") { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
