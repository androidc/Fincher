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
    
    
    /// месячная процентная ставка (годовая ставка, поделенная на 12),
    var p: Double  {
        return interestRate / 12 / 100
    }
    
    /// срок в месяцах
    var termInMonth: Int {
        creditTermType == 0 ? creditTerm * 12 : creditTerm
    }
    
    /// размер ежемесячного взноса по аннуитетной схеме
    var a: Double {
        let x = pow(Double(1+p),Double(termInMonth)) - 1
        return Double(self.amountOfCredit) * (p + p / x)
    }
    
    /// размер ежемесячного взноса по дифференцированной схеме
    var b: Double {
        return Double(amountOfCredit) / Double(termInMonth)
    }
    
    
    ///
    /**
      функция вычисляет платежи по аннуитетной схеме
    - Returns: возвращает сумму выплаченных процентов
    */
    func calculateAnnuitentPayments() -> Double {
        /// сумма выплаченных процентов
        var percentAll: Double = 0.0
        // количество итераций = количеству месяцев (termInMonth)
        // очищаем календарь
        self.paymentsCalendar = []
        // начальные значения
        /// остаток основного долга
        var ostatok = Double(amountOfCredit)
        /// сотая часть от месячной процентной ставки
        var p = self.p
        /// размер ежемесячного взноса по аннуитетной схеме
        var a = self.a
        /// сколько идет в погашение процентов
        var percentShare = 0.0
        /// сколько идет в счет основного долга
        var mainShare = 0.0
        /// остаток после уплаты части основного долга
        var Sn = 0.0
        /// сумма начисленных процентов
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
     - Returns: кортеж с первым и последним платежом и суммой выплаченных процентов
     */
    func calculateDiffPayments() -> (Double,Double, Double) {
        var result: (Double,Double,Double) = (0,0,0)
        /// размер ежемесячного взноса по дифференцированной схеме
        let b = self.b
        /// сотая часть от месячной процентной ставки
        let p = self.p
        /// остаток основного долга
        var ostatok = Double(amountOfCredit)
        /// сколько идет в погашение процентов
        var percentShare = 0.0
        /// сумма ежемесячного взноса
        var payment: Double = 0.0
        /// остаток после уплаты части основного долга
        var Sn = 0.0
        /// сумма выплаченных процентов
        var percentAll: Double = 0.0
        
        // расчет
        for index in 1...termInMonth {
            percentShare = ostatok * p
            payment = b + percentShare
            percentAll += percentShare
            Sn = ostatok - b
            let payment: Payments = Payments(number: index, ostatok: ostatok, payment: payment, percent: percentShare, main: b, Sn: Sn)
            self.paymentsCalendar.append(payment)
            ostatok = Sn
        }
        
        result.0 = self.paymentsCalendar[0].payment
        result.1 = self.paymentsCalendar.last?.payment ?? 0.00
        result.2 = percentAll
        
        print(paymentsCalendar)
        return result
    }
  
    
    
  
    
    
    
    
    
}
