import Foundation
import Combine

// Map
let numPublisher = PassthroughSubject<Int, Never>()
let subscription1 = numPublisher
    .map { $0 * 2 }
    .sink { value in
        print("Transformed Value: \(value)")
    }

numPublisher.send(10)
numPublisher.send(20)
numPublisher.send(30)
subscription1.cancel()

/* 결과
 Transformed Value: 20
 Transformed Value: 40
 Transformed Value: 60
 */


// Filter
let stringPublisher = PassthroughSubject<String, Never>()
let subscription2 = stringPublisher
    .filter { $0.contains("a") }        // 받은 값이 "a"를 포함하고 있습니까?
    .sink { value in
        print("Filtered Value: \(value)")
    }

stringPublisher.send("abc")
stringPublisher.send("Jack")
stringPublisher.send("Joon")
stringPublisher.send("Jenny")
stringPublisher.send("Jason")
subscription2.cancel()

/* 결과 -> "a"를 포함하는 문자열만 출력
 Filtered Value: abc
 Filtered Value: Jack
 Filtered Value: Jason
 */
