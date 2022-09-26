import Foundation
import Combine

// Publisher & Subscriber
let just = Just(1000)                       // just라는 publisher는 데이터를 한번 전송하고 끝
let subscription1 = just.sink { value in
    print("Received Value: \(value)")
}
// 8번 라인 설명 -> publisher가 제공한 데이터를 받을수 있는 클로져 제공하는 sink를 사용해 데이터를 받아와 출력하기


let arrayPublisher = [1,3,5,7,9].publisher  // .publisher를 붙여줘서 [1,3,5,7,9]를 퍼블리셔로 만들어 준다.
let subscription2 = arrayPublisher.sink { value in
    print("Received Value: \(value)")
}

class MyClass {
    var number: Int = 0 {
        didSet {
            print("Did set Property to  \(number)")
        }
    }
}

let object = MyClass()
let subscription3 = arrayPublisher.assign(to: \.number, on: object) // 말 그대로 assign(할당).
// assign(to: 프로퍼티명, on: 객체) -> 어떤 객체의 어떤 프로퍼티에 할당 해야 하는지 묻는것.
