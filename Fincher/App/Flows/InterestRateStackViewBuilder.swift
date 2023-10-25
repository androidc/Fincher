//Created by chizztectep on 25.10.2023 

import Foundation
import UIKit
import SnapKit

class InterestRateStackViewBuilder {
    let lblInterestRate: UILabel = {
           let lbl = UILabel()
           lbl.text = Strings.shared.interestRateString
           lbl.textColor = .lightGray
           return lbl
       }()
    
   let textViewInterestRate: UITextView = {
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
    
    let lblPercent: UILabel = {
           let lbl = UILabel()
           lbl.text = " %"
           lbl.textColor = .lightGray
           return lbl
       }()
    
    func buildInterestRateStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        [self.lblInterestRate,
            self.textViewInterestRate,
            self.lblPercent].forEach { stackView.addArrangedSubview($0) }
//        textViewInterestRate.snp.makeConstraints { make in
//            make.left.equalTo(lblInterestRate.snp.right).inset(-10)
//        }
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        return stackView
    }
    
}
