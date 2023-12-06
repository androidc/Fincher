final class DetailsScreenAssembly {
//    func assemble(_ monthData: [DetailsScreenViewData]) -> DetailsScreenViewController {
//        let controller = DetailsScreenViewController()
//        let viewModel = DetailsScreenViewModel(monthData)
//        controller.viewModel = viewModel
//        return controller
//    }
        func assemble(_ monthData: [Payments]) -> DetailsScreenViewController {
            let controller = DetailsScreenViewController()
            let viewModel = DetailsScreenViewModel(monthData)
            controller.viewModel = viewModel
            return controller
        }

    func mockData() -> [DetailsScreenViewData] {
        [
            DetailsScreenViewData(
                number: "1", date: "Дата:\n 25.12.2025",
                amount: "Сумма:\n50 000 руб", percent: "Проценты:\n30 000 руб", renewal: "Основной:\n50 000 руб",
                contrib: "Доп взнос:\n0 руб", general: "Общая сумма:\n3 000 000"),
            DetailsScreenViewData(
                number: "2", date: "Дата:\n 25.01.2026",
                amount: "Сумма:\n50 000 руб", percent: "Проценты:\n30 000 руб", renewal: "Основной:\n50 000 руб",
                contrib: "Доп взнос:\n0 руб", general: "Общая сумма:\n3 000 000"),
            DetailsScreenViewData(
                number: "3", date: "Дата:\n 25.12.2025",
                amount: "Сумма:\n50 000 руб", percent: "Проценты:\n30 000 руб",
                renewal: "Основной:\n50 000 руб", contrib: "Доп взнос:\n0 руб", general: "Общая сумма:\n3 000 000"),
            DetailsScreenViewData(
                number: "4", date: "Дата:\n 25.01.2026",
                amount: "Сумма:\n50 000 руб", percent: "Проценты:\n30 000 руб",
                renewal: "Основной:\n50 000 руб", contrib: "Доп взнос:\n0 руб", general: "Общая сумма:\n3 000 000"),
            DetailsScreenViewData(
                number: "5", date: "Дата:\n 25.12.2025",
                amount: "Сумма:\n50 000 руб", percent: "Проценты:\n30 000 руб",
                renewal: "Основной:\n50 000 руб", contrib: "Доп взнос:\n0 руб", general: "Общая сумма:\n3 000 000"),
            DetailsScreenViewData(
                number: "6", date: "Дата:\n 25.01.2026", amount: "Сумма:\n50 000 руб",
                percent: "Проценты:\n30 000 руб", renewal: "Основной:\n50 000 руб",
                contrib: "Доп взнос:\n0 руб", general: "Общая сумма:\n3 000 000"),
            DetailsScreenViewData(
                number: "7", date: "Дата:\n 25.12.2025",
                amount: "Сумма:\n50 000 руб", percent: "Проценты:\n30 000 руб", renewal: "Основной:\n50 000 руб",
                contrib: "Доп взнос:\n0 руб", general: "Общая сумма:\n3 000 000"),
            DetailsScreenViewData(
                number: "8", date: "Дата:\n 25.01.2026",
                amount: "Сумма:\n50 000 руб", percent: "Проценты:\n30 000 руб", renewal: "Основной:\n50 000 руб",
                contrib: "Доп взнос:\n0 руб", general: "Общая сумма:\n3 000 000"),
            DetailsScreenViewData(
                number: "9", date: "Дата:\n 25.12.2025",
                amount: "Сумма:\n50 000 руб", percent: "Проценты:\n30 000 руб", renewal: "Основной:\n50 000 руб",
                contrib: "Доп взнос:\n0 руб", general: "Общая сумма:\n3 000 000"),
            DetailsScreenViewData(
                number: "10", date: "Дата:\n 25.01.2026",
                amount: "Сумма:\n50 000 руб", percent: "Проценты:\n30 000 руб", renewal: "Основной:\n50 000 руб",
                contrib: "Доп взнос:\n0 руб", general: "Общая сумма:\n3 000 000")
        ]
    }
}
