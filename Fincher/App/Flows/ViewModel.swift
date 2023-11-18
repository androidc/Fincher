// Created by chizztectep on 29.10.2023

import Foundation
import Combine
import Darwin

class ViewModel {
// private var creditTermInMonth: Int = 0
    var paymentsCalendar: [Payments] = []
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
    /// сумма платежа в месяц, установленная пользователем
    @Published var paymentSetted: Double = 0.0 {
        didSet {
            print("paymentSetted changed to:", paymentSetted)
        }
    }
    /// месячная процентная ставка (годовая ставка, поделенная на 12),
    var pTax: Double {
        return interestRate / 12 / 100
    }
    /// срок в месяцах
    var termInMonth: Int {
        creditTermType == 0 ? creditTerm * 12 : creditTerm
    }
    /// размер ежемесячного взноса по аннуитетной схеме
    var monthlyPaymentA: Double {
        let tmp = pow(Double(1+pTax),Double(termInMonth)) - 1
        return Double(self.amountOfCredit) * (pTax + pTax / tmp)
    }
    /// сумма кредита зная ежемесячный платеж
    var maxCredit: Double {
        let tmpx = pow(Double(1+pTax),Double(termInMonth)) - 1
        let tmpy = pTax + pTax / tmpx
        return paymentSetted / tmpy
    }
    /// размер ежемесячного взноса по дифференцированной схеме
    var monthlyPaymentB: Double {
        return Double(amountOfCredit) / Double(termInMonth)
    }
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
        let oneHPart = self.pTax
        /// размер ежемесячного взноса по аннуитетной схеме
        var monthlyPaymentA = self.monthlyPaymentA
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
            percentShare = ostatok * oneHPart
            percentAll += percentShare
            mainShare = monthlyPaymentA - percentShare
            Sn = ostatok - mainShare
            let payment: Payments = Payments(number: index, ostatok: ostatok, payment: monthlyPaymentA, percent: percentShare, main: mainShare, Sn: Sn)
            self.paymentsCalendar.append(payment)
            ostatok = Sn
        }
        return percentAll
    }
    /**
     Вычисляет платежи по дифференцированной схеме
     - Returns: кортеж с первым и последним платежом и суммой выплаченных процентов
     */
    func calculateDiffPayments() -> (Double,Double, Double) {
        var result: (Double,Double,Double) = (0,0,0)
        /// размер ежемесячного взноса по дифференцированной схеме
        let monthlyPamentB = self.monthlyPaymentB
        /// сотая часть от месячной процентной ставки
        let oneHPart = self.pTax
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
            percentShare = ostatok * oneHPart
            payment = monthlyPamentB + percentShare
            percentAll += percentShare
            Sn = ostatok - monthlyPamentB
            let payment: Payments = Payments(number: index, ostatok: ostatok, payment: payment, percent: percentShare, main: monthlyPamentB, Sn: Sn)
            self.paymentsCalendar.append(payment)
            ostatok = Sn
        }
        
        result.0 = self.paymentsCalendar[0].payment
        result.1 = self.paymentsCalendar.last?.payment ?? 0.00
        result.2 = percentAll
        return result
    }
    /**
     Вычисляет срок кредита по дифференцированной схеме
     - Returns: кортеж с сроком кредита в месяцах и начисленные проценты
     */
    
    func calculateTermPayments() -> (Int,Double) {
        var result: (Int,Double) = (0,0)
        // очищаем календарь
        self.paymentsCalendar = []
        /// остаток основного долга
        var ostatok = Double(amountOfCredit)
        /// остаток после уплаты части основного долга
        var Sn = 0.0
        /// сколько идет в погашение процентов
        var percentShare = 0.0
        /// сумма выплаченных процентов
        var percentAll: Double = 0.0
        /// сколько идет в счет основного долга
        var mainShare = 0.0
        /// сколько прошло месяцев
        var term = 0
        /// сотая часть от месячной процентной ставки
        let oneHPart = self.pTax
        var index = 0
        // расчет
        while ostatok > 0 {
            index += 1
            percentShare = ostatok * oneHPart
            percentAll += percentShare
            mainShare = paymentSetted - percentShare
            Sn = ostatok - mainShare
            let payment: Payments = Payments(number: index, ostatok: ostatok, payment: paymentSetted, percent: percentShare, main: mainShare, Sn: Sn)
            self.paymentsCalendar.append(payment)
            ostatok = Sn
        }
        result.0 = index
        result.1 = percentAll
        return result
    }
    // на будущее для расчета максимальной суммы кредита по схеме https://www.sravni.ru/text/kak-rasschitat-maksimalnuyu-summu-kredita/?upd
//    // платежеспособность заемщика by default
//    let solvency = 45000.00
//
//    //поправочный коэффициент by default
//    let coefficient = 0.5
    /**
       Вычисляет срок максимальную сумму кредита по аннуитетной схеме
     - Returns: кортеж с суммой кредита и начисленные проценты
     */
    
    func calculateMaxCredit() -> (Double,Double) {
        var result: (Double,Double) = (0,0)
        // очищаем календарь
        self.paymentsCalendar = []
        /// срок кредита
        let term = self.termInMonth
        /// остаток после уплаты части основного долга
        var Sn = 0.0
        /// сколько идет в погашение процентов
        var percentShare = 0.0
        /// остаток основного долга
        var ostatok = self.maxCredit
        result.0 = ostatok
        /// сотая часть от месячной процентной ставки
        let oneHPart = self.pTax
        /// сумма начисленных процентов
        var percentAll:Double = 0.0
        /// сколько идет в счет основного долга
        var mainShare = 0.0
        
        // расчет
        for index in 1...termInMonth {
            percentShare = ostatok * oneHPart
            percentAll += percentShare
            mainShare = self.paymentSetted - percentShare
            Sn = ostatok - mainShare
            let payment: Payments = Payments(number: index, ostatok: ostatok, payment: self.paymentSetted, percent: percentShare, main: mainShare, Sn: Sn)
            self.paymentsCalendar.append(payment)
            ostatok = Sn
        }
        result.1 = percentAll
        print(paymentsCalendar)
        return result
    }
}
