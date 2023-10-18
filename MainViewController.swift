//Created by chizztectep on 17.10.2023 

import UIKit
import DropDown
import SnapKit

class MainViewController: UIViewController {
    let dropDown = DropDown()
    let image = UIImage(systemName: "questionmark.app")
    let dropDownImage = UIImage(systemName: "arrowtriangle.down")
    let imageView = UIImageView()
    
    lazy var lblCalculationOption: UILabel = {
           let lbl = UILabel()
           lbl.text = Strings.shared.calcOptionString
           lbl.textColor = .lightGray
           return lbl
       }()
    
    lazy var lblAmountCredit: UILabel = {
           let lbl = UILabel()
           lbl.text = Strings.shared.amountOfCreditString
           lbl.textColor = .lightGray
           return lbl
       }()
    
    lazy var textViewAmountCredit: UITextView = {
        let textView = UITextView()
           textView.backgroundColor = .white //bkgdColor
           textView.textAlignment = .center
           //textView.frame = CGRect(x: 5, y: 5, width: 5, height: 5)
           textView.tintColor = .black
         //   textView.layer.borderColor =
           textView.layer.borderWidth = 0.5
           textView.layer.cornerRadius = 5
           textView.translatesAutoresizingMaskIntoConstraints = false //enable autolayout
           textView.heightAnchor.constraint(equalToConstant: 20).isActive = true
           textView.widthAnchor.constraint(equalToConstant: 100).isActive = true
           return textView
    }()
    
    
    lazy var btnCalculationOptionTip: UIButton = {
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action: #selector(btnPopUpCalculationOption), for: .touchUpInside)
        return btn
    }()
    
    lazy var amountCreditSV: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        [self.lblAmountCredit,
            self.textViewAmountCredit].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    lazy var btnCalculationOption: UIButton = {
           let btn = UIButton()
           btn.layer.cornerRadius = 5.0
           btn.clipsToBounds = true
           btn.setTitleColor(.black, for: .normal)
           btn.setImage(dropDownImage, for: .normal)
           btn.semanticContentAttribute = .forceRightToLeft
           btn.setTitle(Strings.shared.calcMonthlyPaymentString, for: .normal)
           btn.addTarget(self, action: #selector(btnCalculationTouchUpInside), for: .touchUpInside)
           return btn
       }()
    
    lazy var calculationOptionLabelSV: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        [self.lblCalculationOption,
            self.btnCalculationOptionTip].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    lazy var calculationOptionSV: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fill
        [   self.calculationOptionLabelSV,
            self.btnCalculationOption,
            self.amountCreditSV].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
//    lazy var sumCreditSV: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.alignment = .top
//        stackView.distribution = .fill
//    }()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(calculationOptionSV)
        setupConstraints()
     
        // Do any additional setup after loading the view.
    }
    
    private func setupConstraints () {
        calculationOptionSV.translatesAutoresizingMaskIntoConstraints = false
        btnCalculationOptionTip.snp.makeConstraints { make in
            make.left.equalTo(lblCalculationOption.snp.right).inset(-10)
        }
        textViewAmountCredit.snp.makeConstraints { make in
            make.left.equalTo(lblAmountCredit.snp.right).inset(-10)
        }
        calculationOptionSV.snp.makeConstraints { (make) in
                        make.centerX.equalToSuperview()
                        make.centerY.equalToSuperview().offset(-100)
                        make.left.equalToSuperview().offset(20)
                        make.right.equalToSuperview().offset(-20)
              }
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
                 sender.setTitle(item, for: .normal) //9
               }
       }
    @objc
    func btnPopUpCalculationOption(sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: Strings.shared.calcOptionString, message: Strings.shared.calcOptionsTipString, preferredStyle: UIAlertController.Style.alert)

               // add the actions (buttons)
        alert.addAction(UIAlertAction(title: Strings.shared.okString, style: UIAlertAction.Style.default, handler: nil))
              

               // show the alert
               self.present(alert, animated: true, completion: nil)
    }
    

}
