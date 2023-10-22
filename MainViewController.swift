//Created by chizztectep on 17.10.2023 

import UIKit
import DropDown
import SnapKit


class MainViewController: UIViewController {
    
    var calculationStackViewBuilder = CalculateOptionStackViewBuilder()
    let dropDownButtonBuilder = DropDownButtonBuilder()
    let amountOfCreditBuilder = AmountOfCreditStackViewBuilder()
    let creditTermStackViewBuilder = CreditTermStackViewBuilder()
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        self.calculationStackViewBuilder = CalculateOptionStackViewBuilder(viewController: self)
    }

    lazy var calculationOptionSV: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fill
        
        [   calculationStackViewBuilder.buildCalculationOptionSV(),
            dropDownButtonBuilder.buildDropDownButton(),
            amountOfCreditBuilder.buildAmountOfCreditStackView(),
            creditTermStackViewBuilder.buildCreditTermStackView()].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(calculationOptionSV)
        setupConstraints()
       
        // Do any additional setup after loading the view.
    }
    
    private func setupConstraints () {
        calculationOptionSV.translatesAutoresizingMaskIntoConstraints = false
       
       
        calculationOptionSV.snp.makeConstraints { (make) in
                        make.centerX.equalToSuperview()
                        make.centerY.equalToSuperview().offset(-100)
                        make.left.equalToSuperview().offset(20)
                        make.right.equalToSuperview().offset(-20)
              }
    }

}
