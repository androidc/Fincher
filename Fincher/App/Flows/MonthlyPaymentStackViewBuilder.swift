//Created by chizztectep on 25.10.2023 

import Foundation
import UIKit
import SnapKit

class MonthlyPaymentStackViewBuilder {
    let dropDownButtonBuilder = DropDownButtonBuilder()
    
    let lblMonthlyPayment: UILabel = {
           let lbl = UILabel()
           lbl.text = Strings.shared.monthlyPaymentString
           lbl.textColor = .lightGray
           return lbl
       }()
    
    let textViewMonthlyPayment: UITextView = {
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
    
    func buildMonthlyPaymentStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        let dropDownButton = dropDownButtonBuilder.buildDropDownCurrencyButton()
        [self.lblMonthlyPayment,
            self.textViewMonthlyPayment,
         dropDownButton].forEach { stackView.addArrangedSubview($0) }
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        return stackView
    }
    
    
}
