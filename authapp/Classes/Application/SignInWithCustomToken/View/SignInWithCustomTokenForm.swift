import UIKit

protocol SignInWithCustomTokenFormDelegate: AnyObject {
    func submit(customToken: String)
}

class SignInWithCustomTokenForm: UIView {
    @IBOutlet weak var customTokenField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    weak var delegate: SignInWithCustomTokenFormDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func loadNib() {
        if let view = Bundle.main.loadNibNamed("SignInWithCustomTokenForm", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        } else {
            assertionFailure()
        }

        submitButton.addAction(.init { _ in self.delegate?.submit(customToken: self.customTokenField.text!) }, for: .touchUpInside)
    }
}
