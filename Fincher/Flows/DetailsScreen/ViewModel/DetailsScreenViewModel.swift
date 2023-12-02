// final class DetailsScreenViewModel {
//    private(set) var monthData: [DetailsScreenViewData]
//
//    init(_ monthData: [DetailsScreenViewData]) {
//        self.monthData = monthData
//    }
// }
final class DetailsScreenViewModel {
    private(set) var monthData: [Payments]

    init(_ monthData: [Payments]) {
        self.monthData = monthData
    }
}
