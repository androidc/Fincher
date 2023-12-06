import Combine
import Foundation
import SnapKit
import UIKit

class AmountOfCreditStackViewBuilder {
    var subscriptions = Set<AnyCancellable>()
    let dropDownButtonBuilder = DropDownButtonBuilder()
    var viewModel: MainViewModel

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

    let lblAmountCredit: UILabel = {
        let lbl = UILabel()
        lbl.text = Strings.shared.amountOfCreditString
        lbl.textColor = .lightGray
        return lbl
    }()

    let textViewAmountCredit: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.textAlignment = .center
        textView.tintColor = .black
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return textView
    }()

    func buildAmountOfCreditStackView() -> UIStackView {
        let resultStackView = UIStackView()
        resultStackView.axis = .vertical
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        let dropDownButton = dropDownButtonBuilder.buildDropDownCurrencyButton()
        dropDownButtonBuilder.$currency
            .dropFirst()
            .assign(to: \.creditCurrency, on: viewModel)
            .store(in: &subscriptions)
        [
         self.textViewAmountCredit,
         dropDownButton].forEach { stackView.addArrangedSubview($0) }
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        [self.lblAmountCredit,
         stackView].forEach { resultStackView.addArrangedSubview($0) }
        resultStackView.spacing = UIStackView.spacingUseSystem
        resultStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20,
                                                                           bottom: 20, trailing: 20)
        return resultStackView
    }
}
