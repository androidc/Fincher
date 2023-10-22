//Created by chizztectep on 22.10.2023 

import Foundation
import UIKit

class CreditTermStackViewBuilder {
    //label + textView + dropDown (лет/месяцев)
    
    let dropDownButtonBuilder = DropDownButtonBuilder()
    
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
        textViewCreditTerm.snp.makeConstraints { make in
            make.left.equalTo(lblCalculationOption.snp.right).inset(-10)
        }
        dropDownButton.snp.makeConstraints { make in
            make.left.equalTo(textViewCreditTerm.snp.right).inset(-10)
        }
        return stackView
    }
    
}
