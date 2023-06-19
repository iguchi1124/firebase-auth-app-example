import UIKit

protocol PasswordResetFormDelegate: AnyObject {
    func submit(email: String)
}

class PasswordResetForm: UIView {
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var emailField: UITextField!

    weak var delegate: PasswordResetFormDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func loadNib() {
        if let view = Bundle.main.loadNibNamed("PasswordResetForm", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        } else {
            assertionFailure()
        }

        submitButton.addAction(.init { _ in self.delegate?.submit(email: self.emailField.text!) }, for: .touchUpInside)
    }
}
