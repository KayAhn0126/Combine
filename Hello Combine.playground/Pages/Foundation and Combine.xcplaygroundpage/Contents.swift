//: [Previous](@previous)

import Foundation
import Combine
import UIKit

// URLSessionTask Publisher and JSON Decoding Operator


// Notifications
let center = NotificationCenter.default
let identifier = Notification.Name("MyNoti")
let notiPublisher = center.publisher(for: identifier, object: nil)
let subscription = notiPublisher.sink { _ in
    print("Noti Received")
}

center.post(name: identifier, object: nil)


// KeyPath binding to NSObject instances



// Timer
// autoconnect 를 이용하면 subscribe 되면 바로 시작함


//: [Next](@next)
