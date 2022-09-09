//: [Previous](@previous)

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
subscription.cancel() // 구독 취소
subject.send("Hello")
//: [Next](@next)
