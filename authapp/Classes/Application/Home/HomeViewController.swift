import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?
    var user:  User?

    private let logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        return button
    }()

    private let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        return button
    }()

    private let signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        return button
    }()

    private let signInWithCustomTokenButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign in with custom token", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        logoutButton.addAction(.init { _ in self.logout() }, for: .touchUpInside)
        signInButton.addAction(.init { _ in self.presentSignInView() }, for: .touchUpInside)
        signUpButton.addAction(.init { _ in self.presentSignUpView() }, for: .touchUpInside)
        signInWithCustomTokenButton.addAction(.init { _ in self.presentSignInWithCustomTokenView() }, for: .touchUpInside)

        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.widthAnchor.constraint(equalToConstant: 300),
            logoutButton.heightAnchor.constraint(equalToConstant: 100),
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.addSubview(signInButton)
        NSLayoutConstraint.activate([
            signInButton.widthAnchor.constraint(equalToConstant: 300),
            signInButton.heightAnchor.constraint(equalToConstant: 100),
            signInButton.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 50),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.widthAnchor.constraint(equalToConstant: 300),
            signUpButton.heightAnchor.constraint(equalToConstant: 100),
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 50),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.addSubview(signInWithCustomTokenButton)
        NSLayoutConstraint.activate([
            signInWithCustomTokenButton.widthAnchor.constraint(equalToConstant: 300),
            signInWithCustomTokenButton.heightAnchor.constraint(equalToConstant: 100),
            signInWithCustomTokenButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 50),
            signInWithCustomTokenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        refresh()
    }

    func refresh() {
        guard let user = self.user else { return }
        if user.isAnonymous {
            signInButton.isHidden = false
            signUpButton.isHidden = false
        } else {
            signInButton.isHidden = true
            signUpButton.isHidden = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        handle = Auth.auth().addStateDidChangeListener { auth, user in
            self.user = user
            self.refresh()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        Auth.auth().removeStateDidChangeListener(handle!)
    }

    private func logout() {
        do {
           try  Auth.auth().signOut()
        } catch {
            fatalError()
        }

        dismiss(animated: true)
    }

    private func presentSignUpView() {
        let signUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }

    private func presentSignInView() {
        let signInViewController = SignInViewController()
        self.navigationController?.pushViewController(signInViewController, animated: true)
    }

    private func presentSignInWithCustomTokenView() {
        let signInWithCustomTokenViewController = SignInWithCustomTokenViewController()
        self.navigationController?.pushViewController(signInWithCustomTokenViewController, animated: true)
    }
}
