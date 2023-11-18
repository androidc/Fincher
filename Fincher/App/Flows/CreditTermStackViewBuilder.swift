//Created by chizztectep on 22.10.2023 

import Foundation
import UIKit
import Combine

//label + textView + dropDown (лет/месяцев)
class CreditTermStackViewBuilder {
    var subscriptions = Set<AnyCancellable>()
    let dropDownButtonBuilder = DropDownButtonBuilder()
    var viewModel: ViewModel!
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    let lblCalculationOption: UILabel = {
           let lbl = UILabel()
           lbl.text = Strings.shared.creditTermString
           lbl.textColor = .lightGray
           return lbl
       }()
    
    let textViewCreditTerm: UITextView = {
         let textView = UITextView()
            textView.backgroundColor = .white //bkgdColor
            textView.textAlignment = .center
            textView.tintColor = .black
            textView.layer.borderWidth = 0.5
            textView.layer.cornerRadius = 5
            textView.translatesAutoresizingMaskIntoConstraints = false //enable autolayout
            textView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            textView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            return textView
     }()
    
    func buildCreditTermStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        let dropDownButton = dropDownButtonBuilder.buildDropDownTermButton()
        [self.lblCalculationOption,
          self.textViewCreditTerm,
         dropDownButton].forEach { stackView.addArrangedSubview($0) }
        dropDownButtonBuilder.selectedCreditTermType
            .assign(to: \.creditTermType, on: viewModel)
            .store(in: &subscriptions)
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        return stackView
    }
}
