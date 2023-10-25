//Created by chizztectep on 17.10.2023 

import UIKit
import DropDown
import SnapKit
import Combine

class MainViewController: UIViewController {
    
    private var subscriptions = Set<AnyCancellable>()
    
    var calculationStackViewBuilder = CalculateOptionStackViewBuilder()
    let dropDownButtonBuilder = DropDownButtonBuilder()
    let amountOfCreditBuilder = AmountOfCreditStackViewBuilder()
    let creditTermStackViewBuilder = CreditTermStackViewBuilder()
    let interestRateStackViewBuilder = InterestRateStackViewBuilder()
    let monthlyPaymentStackViewBuilder = MonthlyPaymentStackViewBuilder()
    var calculaionSV: UIStackView = UIStackView()
    var dropDownButton: UIButton = UIButton()
    var amountOfCreditSV: UIStackView = UIStackView()
    var creditTermSV: UIStackView = UIStackView()
    var interestRateSV: UIStackView = UIStackView()
    var monthlyPaymentSV: UIStackView = UIStackView()
    
    

    convenience init() {
        self.init(nibName:nil, bundle:nil)
        self.calculationStackViewBuilder = CalculateOptionStackViewBuilder(viewController: self)
        self.calculaionSV = calculationStackViewBuilder.buildCalculationOptionSV()
        self.dropDownButton = dropDownButtonBuilder.buildDropDownButton()
        self.amountOfCreditSV = amountOfCreditBuilder.buildAmountOfCreditStackView()
        self.creditTermSV = creditTermStackViewBuilder.buildCreditTermStackView()
        self.interestRateSV = interestRateStackViewBuilder.buildInterestRateStackView()
        self.monthlyPaymentSV = monthlyPaymentStackViewBuilder.buildMonthlyPaymentStackView()
    }

    lazy var mainSV: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fill
        
        [   self.calculaionSV,
            self.dropDownButton,
            self.amountOfCreditSV,
            self.creditTermSV,
            self.interestRateSV].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
          self.view.addSubview(self.mainSV)
          self.setupConstraintsMain()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        dropDownButtonBuilder.selectedCalculationOption
            .sink { value in
                print(value)
                switch value {

                case 0:
                            self.mainSV.subviews.forEach({ $0.removeFromSuperview() })
                    [   self.calculaionSV,
                        self.dropDownButton,
                        self.amountOfCreditSV,
                        self.creditTermSV,
                        self.interestRateSV].forEach { self.mainSV.addArrangedSubview($0) }
                        self.setupConstraintsMain()
                case 1:
                    self.mainSV.subviews.forEach({ $0.removeFromSuperview() })
                    [   self.calculaionSV,
                        self.dropDownButton,
                        self.amountOfCreditSV,
                        self.monthlyPaymentSV,
                        self.interestRateSV].forEach { self.mainSV.addArrangedSubview($0) }
                    self.setupConstraintsMain()
                default:
                    break
                }

            }
            .store(in: &subscriptions)
        
    
       
        // Do any additional setup after loading the view.
    }
    
    private func setupConstraintsMain () {
        mainSV.translatesAutoresizingMaskIntoConstraints = false
        mainSV.spacing = UIStackView.spacingUseSystem
        mainSV.isLayoutMarginsRelativeArrangement = true
        mainSV.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        mainSV.snp.makeConstraints { (make) in
                        make.centerX.equalToSuperview()
                        make.centerY.equalToSuperview().offset(-100)
                        make.left.equalToSuperview().offset(20)
                        make.right.equalToSuperview().offset(-20)
              }
    }


}
