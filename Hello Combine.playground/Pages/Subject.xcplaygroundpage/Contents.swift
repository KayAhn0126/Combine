import Foundation
import Combine

/*
 Subject
    - send(_:) 메서드를 통해 이벤트 값을 주입 시킬수 있는 Publisher
    - 기존의 비동기처리 방식에서 Combine으로 전환시 유용
    - 2가지 Built - In 타입
        - PassthroughSubject
            Subscriber가 데이터를 요청하면 그 시점부터 받은 값을 전달, 전달한 값을 들고있지 않음.
        - CurrentValueSubject
            Subscriber가 데이터를 요청하면 가지고 있던 값을 전달하고, 그때 부터 받은 값을 전달, 전달한 값 들고있음.
 */

// PassthroughSubject
let relay = PassthroughSubject<String, Never>() // Never 는 실패할 일이 없다.
let subscription1 = relay.sink { value in
    print("subscription1 received value: \(value)")
}

relay.send("Hello")
relay.send("World!")



// CurrentValueSubject
let variable = CurrentValueSubject<String, Never>("original text") // "A"는 초기값, 초기값을 꼭 주입 해주어야 한다.

variable.send("new text") // sink로 데이터를 받기전 send는 초기값 변경.

let subscription2 = variable.sink { value in
    print("subscription2 received value: \(value)")
}

variable.send("More text")
//CurrentValueSubject는 기존에 가지고 있던 데이터를 보내고 그때 부터 받은 값을 전달한다.




let publisher = ["Here", "we", "go"].publisher
publisher.subscribe(relay)
// public func subscribe<S>(_ subject: S) -> AnyCancellable where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output
// relay라는 이름을 가진 Subject가 subscribe한다 publisher를.
// subject들(passthroughSubject, CurrentValueSubject)은 subscribe 할 수 있다!
