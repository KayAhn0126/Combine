import Foundation
import Combine

/*
 
 Scheduler
 - Scheduler 는 언제, 어떻게 클로져를 실행할지 정해주는 녀석임
 - Operator 에서 Scheduler를 파라미터로 받을때가 있음
     - 따라서, 작업에 따라서, 백그라운드 혹은 메인스레드에서 작업이 실행될수 있게 도와줌
 - Scheduler 가 스레드 자체는 아님

 2가지 Scheduler 메소드

 subscribe(on:) 을 이용해서, publisher 가 어느 스레드에서 수행할지 결정해주는것

 - 무거운 작업은 메인스레드가 아닌 다른 스레드에서 작업할수 있게 도와줌
     - 예) 백그라운드 계산이 많이 필요한것
     - 예) 파일 다운로드해야하는 경우

 receive(on:) 을 이용해서 operator, subscriber 가 어느 스레드에서 수행할지 결정해주는것

 - UI 업데이트 필요한 데이터를 메인스레드에서 받을수 있게 도와줌
     - 예) 서버에서 가져온 데이터를 UI 업데이트 할때
 */

let arrPublisher = [1,2,3].publisher

let queue = DispatchQueue(label: "custom")

/*
let subscription = arrPublisher
    .map { value -> Int in
        print("transform: \(value), thread: \(Thread.current)")
        return value
    }
    .sink { value in
    print("Receive Value: \(value), thread: \(Thread.current)")
}
*/

let subscription = arrPublisher
    .subscribe(on: queue)               // publisher 가 어느 스레드에서 수행할지 결정하는 역할
    .map { value -> Int in
        print("transform: \(value), thread: \(Thread.current)")
        return value
    }
    .receive(on: DispatchQueue.main)    // element를 수신할 scheduler를 지정하는 역할
    .sink { value in
    print("Receive Value: \(value), thread: \(Thread.current)")
}
