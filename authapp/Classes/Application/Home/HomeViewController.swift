import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let signUpForm = SignUpForm()
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
