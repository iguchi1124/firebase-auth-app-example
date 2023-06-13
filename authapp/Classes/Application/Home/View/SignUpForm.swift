import UIKit

protocol SignUpFormDelegate: AnyObject {
    func submit(email: String, password: String)
}

class SignUpForm: UIView {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    weak var delegate: SignUpFormDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func loadNib() {
        if let view = Bundle.main.loadNibNamed("SignUpForm", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        } else {
            assertionFailure()
        }

        submitButton.addAction(.init { _ in self.delegate?.submit(email: self.emailField.text!, password: self.passwordField.text!) }, for: .touchUpInside)
    }
}
