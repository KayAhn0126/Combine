//: [Previous](@previous)

import Foundation
import Combine
import UIKit

// URLSessionTask Publisher and JSON Decoding Operator -> "이런것이 있다" 정도만 알고 넘어가기!
struct SomeDecodable: Decodable { }
URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.google.com")!)
    .map { data, response in
        return data
    }
    .decode(type: SomeDecodable.self, decoder: JSONDecoder())



// Notifications
let center = NotificationCenter.default
let identifier = Notification.Name("MyNoti")
let notiPublisher = center.publisher(for: identifier, object: nil)
let subscription = notiPublisher.sink { _ in
    print("Noti Received")
}

center.post(name: identifier, object: nil)


// KeyPath binding to NSObject instances
let ageLabel = UILabel()
print("text: \(ageLabel.text)")

Just(28)
    .map{"Age is \($0)"}
    .assign(to: \.text, on: ageLabel)
print("text: \(ageLabel.text!)")




// Timer
// autoconnect 를 이용하면 subscribe 되면 바로 시작함
let timerPublisher = Timer
    .publish(every: 1, on: .main, in: .common)  // 1초마다 메인스레드에서 보통 방법으로 데이터를 방출하는 퍼블리셔를 만든다. (Timer.publish 메서드로 퍼블리셔를 만들면 Timer.TimerPublisher 타입으로 생성되고 Timer.TimerPublisher은 ConnectablePublisher 프로토콜을 채택하고있다.
    .autoconnect()

// ConnectablePublisher(Zedd0202 블로그 참고 후 작성함)
// elements를 생성하기 전, 추가 세팅을 해야하는 경우 ConnectablePublisher를 사용. 이 Publisher는 connect()를 호출할 때 까지 element를 생성하지 않는다.
// ConnectablePublisher 프로토콜을 채택한 퍼블리셔는 connect()를 호출해줘야 한다.


let timerSubscription = timerPublisher.sink { time in
    print("time: \(time)")
}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    timerSubscription.cancel()
}

//: [Next](@next)
