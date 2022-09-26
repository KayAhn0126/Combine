import Foundation
import Combine

// CombineLatest -> 두 개의 퍼블리셔를 한번에 받는것
// 각 퍼블리셔에서 가장 최신의 데이터를 받는다!

// Basic CombineLatest
let strPublisher = PassthroughSubject<String, Never>()
let numPublisher = PassthroughSubject<Int, Never>()

strPublisher.combineLatest(numPublisher).sink { (str, num) in
    print("Received: \(str), \(num)")
}
// 이렇게 사용하는 것이 더 깔끔한것 같다!

/*
Publishers.CombineLatest(strPublisher, numPublisher).sink { (str, num) in
    print("Received: \(str), \(num)")
}
*/

/* 예제 1
 strPublisher.send("a")
 strPublisher.send("b")
 strPublisher.send("c")

 numPublisher.send(1)
 numPublisher.send(2)
 numPublisher.send(3)
*/

/* 예제 2
 strPublisher.send("a")
 numPublisher.send(1)
 strPublisher.send("b")
 strPublisher.send("c")

 numPublisher.send(2)
 numPublisher.send(3)
*/

 
// Advanced CombineLatest
let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublusher = PassthroughSubject<String, Never>()

let validatedCredntialSubscription = usernamePublisher.combineLatest(passwordPublusher)
    .map { (username, password) in
        return !username.isEmpty && !password.isEmpty && password.count > 12
    }
    .sink { valid in
        print("Credential valid?: \(valid)")
    }

usernamePublisher.send("jasonlee")
passwordPublusher.send("weakpw")
passwordPublusher.send("verystrongpassword")


// Merge
// merge는 두개의 퍼블리셔의 output type이 같아야 한다!
let publisher1 = [1,2,3,4,5].publisher
let publisher2 = [300,400,500].publisher

let mergePublisherSubscription = publisher1.merge(with: publisher2).sink { value in
    print("Merge: subscription received value: \(value)")
}

// 이렇게 사용하는게 더 깔끔한것 같다!
/*
 let mergePublisherSubscription = Publisher.Merge(publisher1, publihser2)
    .sink { value in
        print("Merge: subscription received value: \(value)")
    }
*/
