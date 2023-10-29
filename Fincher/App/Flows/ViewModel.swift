//Created by chizztectep on 29.10.2023 

import Foundation
import Combine

class ViewModel {
    @Published var amountOfCredit: String = "" {
        didSet {
            print("amountOfCredit changed to:", amountOfCredit)
        }
    }
}
