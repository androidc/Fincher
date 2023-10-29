//Created by chizztectep on 17.10.2023 

import UIKit
import DropDown
import SnapKit
import Combine

enum CalculationType: String {
        case anuitent = "Ануитентные"
        case differentiated = "Дифференцированные"
    }
    
    enum TagViews: Int {
        case anuitentButton = 1
        case differentiatedButton = 2
        case infoAnuitentButton = 3
        case infoDifferentiatedButton = 4
    }


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
    var radioButtonView: UIView = UIView()
    
    var calculationType: CalculationType = .anuitent
   
    

    convenience init() {
        self.init(nibName:nil, bundle:nil)
        self.calculationStackViewBuilder = CalculateOptionStackViewBuilder(viewController: self)
        self.calculaionSV = calculationStackViewBuilder.buildCalculationOptionSV()
        self.dropDownButton = dropDownButtonBuilder.buildDropDownButton()
        self.amountOfCreditSV = amountOfCreditBuilder.buildAmountOfCreditStackView()
        self.creditTermSV = creditTermStackViewBuilder.buildCreditTermStackView()
        self.interestRateSV = interestRateStackViewBuilder.buildInterestRateStackView()
        self.monthlyPaymentSV = monthlyPaymentStackViewBuilder.buildMonthlyPaymentStackView()
        self.radioButtonView = createCalculationTypeView()
    }

    lazy var mainSV: UIStackView = {
        
        
        let radioView = createCalculationTypeView()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fill
        
        [   self.calculaionSV,
            self.dropDownButton,
            self.amountOfCreditSV,
            self.creditTermSV,
            self.interestRateSV,
            radioView].forEach { stackView.addArrangedSubview($0) }
        
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
                        self.interestRateSV,
                        self.radioButtonView].forEach { self.mainSV.addArrangedSubview($0) }
                        self.setupConstraintsMain()
                case 1:
                    self.mainSV.subviews.forEach({ $0.removeFromSuperview() })
                    [   self.calculaionSV,
                        self.dropDownButton,
                        self.amountOfCreditSV,
                        self.monthlyPaymentSV,
                        self.interestRateSV].forEach { self.mainSV.addArrangedSubview($0) }
                        self.setupConstraintsMain()
                case 2:   self.mainSV.subviews.forEach({ $0.removeFromSuperview() })
                    [   self.calculaionSV,
                        self.dropDownButton,
                        self.creditTermSV,
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
    
    func createCalculationTypeView() -> UIView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        let anuitentView = createRadioButtonView(.anuitent)
        let differentiatedView = createRadioButtonView(.differentiated)
        stack.addArrangedSubview(anuitentView)
        stack.addArrangedSubview(differentiatedView)
        return stack
    }
    
    func createRadioButtonView(_ type: CalculationType) -> UIView {
            let stack = UIStackView()
            stack.axis = .horizontal
            let radioButton = createRadioButton(type)
            let infoButton = createCalculationInfoButton(type)
            switch type {
                case .anuitent:
                    radioButton.tag = TagViews.anuitentButton.rawValue
                    infoButton.tag = TagViews.infoAnuitentButton.rawValue
                case .differentiated:
                    radioButton.tag = TagViews.differentiatedButton.rawValue
                    infoButton.tag = TagViews.infoDifferentiatedButton.rawValue
            }
            stack.addArrangedSubview(radioButton)
            stack.addArrangedSubview(infoButton)
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }
    
    
    func createCalculationInfoButton(_ type: CalculationType) -> UIButton {
           let infoButton = UIButton(type: .system)
           infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
           infoButton.addTarget(self, action: #selector(radioButtonTap(sender:)), for: .touchUpInside)
           
           infoButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               infoButton.widthAnchor.constraint(equalToConstant: 44),
               infoButton.heightAnchor.constraint(equalToConstant: 44),
           ])
           return infoButton
       }



    
    func createRadioButton(_ type: CalculationType) -> UIButton {
        let radioButton = UIButton(type: .system)
        radioButton.setImage(UIImage(systemName: "circle"), for: .normal)
        radioButton.setImage(UIImage(systemName: "circle.circle"), for: .selected)
        radioButton.addTarget(self, action: #selector(radioButtonTap(sender:)), for: .touchUpInside)
        radioButton.setTitle(type.rawValue, for: .normal)
        radioButton.isSelected = type == calculationType
        
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            radioButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
        return radioButton
    }
    
    func calculationTypeHandler(_ type: CalculationType) {
            let anuitentButton = view.viewWithTag(TagViews.anuitentButton.rawValue) as? UIButton
            let differentiatedButton = view.viewWithTag(TagViews.differentiatedButton.rawValue) as? UIButton
            switch type {
                case .anuitent:
                    anuitentButton?.isSelected = true
                    differentiatedButton?.isSelected = false
                case .differentiated:
                    anuitentButton?.isSelected = false
                    differentiatedButton?.isSelected = true
            }
            calculationType = type
        }
    
    func tagHandler(_ tag: Int) {
           switch TagViews(rawValue: tag) {
               case .anuitentButton:
                   calculationTypeHandler(.anuitent)
               case .differentiatedButton:
                   calculationTypeHandler(.differentiated)
               case .infoAnuitentButton:
                   print("show anuitent calculation info")
               case .infoDifferentiatedButton:
                   print("show differentiated calculation info")
               case .none:
                   break
           }
       }
    
    @objc func radioButtonTap(sender: UIButton) {
           tagHandler(sender.tag)
       }


}
