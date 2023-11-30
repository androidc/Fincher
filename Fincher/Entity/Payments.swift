struct Payments {
    var number: Int
    var ostatok: Double
    var payment: Double
    // сколько идет в погашение процентов
    var percent: Double
    // сколько идет в счет основного долга
    var main: Double
    // остаток на конец периода
    var remains: Double
}
