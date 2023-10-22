//Created by chizztectep on 22.10.2023 

import Foundation
import UIKit
import DropDown


class DropDownButtonBuilder {
    //var viewController: UIViewController?
    let dropDown = DropDown()
    let dropDownImage = UIImage(systemName: "arrowtriangle.down")
    
    
    //init(viewController: UIViewController? = nil) {
    //    self.viewController = viewController
   // }
    
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
    
    // MARK: - objc
    @objc
    func btnCalculationTouchUpInside(sender: UIButton) {
        dropDown.dataSource = [Strings.shared.calcMonthlyPaymentString, Strings.shared.calcLoanTermString, Strings.shared.calcMlaString]//4
               dropDown.anchorView = sender //5
               dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
               dropDown.show() //7
               dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
                 guard let _ = self else { return }
                // TODO: сделать binding связку index с выбором типа Calculation
                 sender.setTitle(item, for: .normal) //9
               }
       }
    
    @objc
    func btnTermTouchUpInside(sender: UIButton) {
        dropDown.dataSource = [Strings.shared.yearString, Strings.shared.monthString]//4
               dropDown.anchorView = sender //5
               dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
               dropDown.show() //7
               dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
                 guard let _ = self else { return }
                // TODO: сделать binding связку index с выбором типа Term
                 sender.setTitle(item, for: .normal) //9
               }
       }
    
}
