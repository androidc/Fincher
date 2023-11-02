//Created by chizztectep on 29.10.2023 

import Foundation
import Combine
import Darwin

class ViewModel {
    
    //private var creditTermInMonth: Int = 0
    
    var paymentsCalendar:[Payments] = []
    
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
    
    // размер ежемесячного взноса по дифференцированной схеме
    var b: Double {
        return Double(amountOfCredit) / Double(termInMonth)
    }
    
    
    ///
    /**
      функция вычисляет платежи по аннуитетной схеме
    - Returns: возвращает сумму выплаченных процентов
    */
    func calculateAnnuitentPayments() -> Double {
        // сумма выплаченных процентов
        var percentAll: Double = 0.0
        // количество итераций = количеству месяцев (termInMonth)
        // очищаем календарь
        self.paymentsCalendar = []
        // начальные значения
        var ostatok = Double(amountOfCredit)
        var p = self.p
        var a = self.a
        // сколько идет в погашение процентов
        var percentShare = 0.0
        // сколько идет в счет основного долга
        var mainShare = 0.0
        // остаток после уплаты части основного долга
        var Sn = 0.0
        // сумма начисленных процентов
        percentAll = 0.0
        
        // расчет
        for index in 1...termInMonth {
            percentShare = ostatok * p
            percentAll += percentShare
            mainShare = a - percentShare
            Sn = ostatok - mainShare
            let payment: Payments = Payments(number: index, ostatok: ostatok, payment: a, percent: percentShare, main: mainShare, Sn: Sn)
            self.paymentsCalendar.append(payment)
            ostatok = Sn
        }
        return percentAll
        print(paymentsCalendar)
    }
    
    /**
     Вычисляет платежи по дифференцированной схеме
     - Returns: кортеж с первым и последним платежом
     */
    func calculateDiffPayments() -> (Int,Int) {
        var result: (Int,Int) = (0,0)
        result.0 = 1
        result.1 = 2
        return result
    }
  
    
    
  
    
    
    
    
    
}
