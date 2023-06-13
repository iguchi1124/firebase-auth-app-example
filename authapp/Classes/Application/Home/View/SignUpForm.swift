import UIKit

class SignUpForm: UIView {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

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
    }
}
