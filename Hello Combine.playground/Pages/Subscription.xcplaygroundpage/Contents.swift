import Foundation
import Combine

let subject = PassthroughSubject<String, Never>()

// The print() operator prints you all lifecycle events

let subscription = subject
    .print("[Debug]")
    .sink { value in
    print("Subscriber received value: \(value)")
}

subject.send("Hello")
subject.send("Hello again!")
subject.send("Hello last time!")
subject.send(completion: .finished) // 퍼블리셔가 종료하는것
subscription.cancel()               // 구독 취소
subject.send("Hello")

// 19번(마지막) 라인까지 실행시켜보면 아래와 같은 결과를 얻을수 있다.
/*
 [Debug]: receive subscription: (PassthroughSubject)
 [Debug]: request unlimited
 [Debug]: receive value: (Hello)
 Subscriber received value: Hello
 [Debug]: receive value: (Hello again!)
 Subscriber received value: Hello again!
 [Debug]: receive value: (Hello last time!)
 Subscriber received value: Hello last time!
 [Debug]: receive finished
 */

// 스트림을 내려받는 곳을 보면 publisher 클래스의 print 메서드가 있다.
// public func print(_ prefix: String = "", to stream: TextOutputStream? = nil) -> Publishers.Print<Self>
// 이 부분은 조금 더 공부 후 업데이트 예정.
