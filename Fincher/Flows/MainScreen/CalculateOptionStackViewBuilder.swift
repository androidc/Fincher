//Created by chizztectep on 22.10.2023 

import Foundation
import UIKit
import SnapKit


class CalculateOptionStackViewBuilder {
    
    var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
    
    let image = UIImage(systemName: "questionmark.app")
    
    lazy var btnCalculationOptionTip: UIButton = {
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action: #selector(btnPopUpCalculationOption), for: .touchUpInside)
        return btn
    }()
    
    
    let lblCalculationOption: UILabel = {
           let lbl = UILabel()
           lbl.text = Strings.shared.calcOptionString
           lbl.textColor = .lightGray
           return lbl
       }()
    
    func buildCalculationOptionSV() -> UIStackView {
      let stackView = UIStackView()
      stackView.axis = .horizontal
      stackView.alignment = .top
      stackView.distribution = .fill
     
      [self.lblCalculationOption,
          self.btnCalculationOptionTip].forEach { stackView.addArrangedSubview($0) }
//        self.btnCalculationOptionTip.snp.makeConstraints { make in
//            make.left.equalTo(self.lblCalculationOption.snp.right).inset(-10)
//        }
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        return stackView
    }
    
    @objc
    func btnPopUpCalculationOption(sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: Strings.shared.calcOptionString, message: Strings.shared.calcOptionsTipString, preferredStyle: UIAlertController.Style.alert)
               // add the actions (buttons)
        alert.addAction(UIAlertAction(title: Strings.shared.okString, style: UIAlertAction.Style.default, handler: nil))
              
               // show the alert
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    
}
