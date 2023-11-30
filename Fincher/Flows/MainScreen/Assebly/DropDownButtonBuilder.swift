import Combine
import DropDown
import Foundation
import UIKit

class DropDownButtonBuilder: ObservableObject {
    let dropDown = DropDown()
    let dropDownImage = UIImage(systemName: "arrowtriangle.down")

    @Published var calculationOption = 0
    @Published var currency = 0
    @Published var creditTermType = 0

    func buildDropDownButton() -> UIButton {
        let btn = UIButton()
        btn.layer.cornerRadius = 5.0
        btn.clipsToBounds = true
        btn.setTitleColor(.black, for: .normal)
        btn.setImage(dropDownImage, for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.setTitle(Strings.shared.calcMonthlyPaymentString, for: .normal)
        btn.addTarget(self, action: #selector(btnCalculationTouchUpInside), for: .touchUpInside)
        return btn
    }

    func buildDropDownTermButton() -> UIButton {
        let btn = UIButton()
        btn.layer.cornerRadius = 5.0
        btn.clipsToBounds = true
        btn.setTitleColor(.black, for: .normal)
        btn.setImage(dropDownImage, for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.setTitle(Strings.shared.yearString, for: .normal)
        btn.addTarget(self, action: #selector(btnTermTouchUpInside), for: .touchUpInside)
        return btn
    }

    func buildDropDownCurrencyButton() -> UIButton {
        let btn = UIButton()
        btn.layer.cornerRadius = 5.0
        btn.clipsToBounds = true
        btn.setTitleColor(.black, for: .normal)
        btn.setImage(dropDownImage, for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.setTitle("RUB", for: .normal)
        btn.addTarget(self, action: #selector(btnCurrencyTouchUpInside), for: .touchUpInside)
        return btn
    }

    @objc
    func btnCalculationTouchUpInside(sender: UIButton) {
        dropDown.dataSource = [
            Strings.shared.calcMonthlyPaymentString,
            Strings.shared.calcLoanTermString,
            Strings.shared.calcMlaString
        ]
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.calculationOption = index
            sender.setTitle(item, for: .normal)
        }
    }

    @objc
    func btnTermTouchUpInside(sender: UIButton) {
        dropDown.dataSource = [Strings.shared.yearString, Strings.shared.monthString]
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.creditTermType = index
            sender.setTitle(item, for: .normal)
        }
    }

    @objc
    func btnCurrencyTouchUpInside(sender: UIButton) {
        dropDown.dataSource = ["RUB", "USD", "EUR"]
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.currency = index
            sender.setTitle(item, for: .normal)
        }
    }
}
