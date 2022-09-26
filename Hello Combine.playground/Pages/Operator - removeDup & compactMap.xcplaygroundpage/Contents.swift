import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

// removeDuplicates -> 중복된 데이터를 어떻게 지울까?
let words = "hey hey there! Mr Mr ?"
    .components(separatedBy: " ")
    .publisher

words.removeDuplicates().sink { value in
    print("Received: \(value)")
}

/* 결과
 Received: hey
 Received: there!
 Received: Mr
 Received: ?
 */




// compactMap -> transform

let strings = ["a", "1.25", "3", "def", "45", "0.23"].publisher

strings.compactMap { Float($0) }.sink { value in
    print("Received: \(value)")
}

/* 결과
 Received: 1.25
 Received: 3.0
 Received: 45.0
 Received: 0.23
 */




// ignoreOutput

let numbers = (1...10000).publisher

numbers.ignoreOutput()
    .sink { print("Completed with: \($0)")} receiveValue: { print($0) }

/* 결과
 Completed with: finished
 */



// prefix

let tens = (1...10).publisher

tens
    .prefix(3)
    .sink {
        print("Completed with: \($0)")
    } receiveValue: { print(($0)) }

/* 결과
 1
 2
 3
 Completed with: finished
 */
