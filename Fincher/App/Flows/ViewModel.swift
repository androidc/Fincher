//Created by chizztectep on 29.10.2023 

import Foundation
import Combine
import Darwin

class ViewModel {
    
    //private var creditTermInMonth: Int = 0
    
    /// сумма кредита
    @Published var amountOfCredit: Int = 0 {
        didSet {
            print("amountOfCredit changed to:", amountOfCredit)
        }
    }
    
    /// срок кредита
    @Published var creditTerm: Int = 0 {
        didSet {
            print("creditTerm changed to:", creditTerm)
        }
    }
    
    /// валюта кредита
    @Published var creditCurrency: Int = 0 {
        didSet {
            print("creditCurrency changed to:", creditCurrency)
        }
    }
    
    /// срок в годах/месяцах
    @Published var creditTermType: Int = 0 {
        didSet {
            print("creditCurrency changed to:", creditTermType)
        }
    }
    
    /// процентная ставка
    @Published var interestRate: Double = 0.0 {
        didSet {
            print("interestRate changed to:", interestRate)
        }
    }
    
    
    // месячная процентная ставка (годовая ставка, поделенная на 12),
    var p: Double  {
        return interestRate / 12 / 100
    }
    
    // срок в месяцах
    var termInMonth: Int {
        creditTermType == 0 ? creditTerm * 12 : creditTerm
    }
    
    // размер ежемесячного взноса по аннуитетной схеме
    var a: Double {
        let x = pow(Double(1+p),Double(termInMonth)) - 1
        return Double(self.amountOfCredit) * (p + p / x)
    }
  
    
    
  
    
    
    
    
    
}
