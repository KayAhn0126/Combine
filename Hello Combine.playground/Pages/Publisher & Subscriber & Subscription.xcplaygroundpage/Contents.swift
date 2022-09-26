import Foundation
import Combine
let publisher = (1...6).publisher

final class IntSubscriber: Subscriber {
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.max(3))
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        print("Received value", input)
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Received completion", completion)
    }
}

let subscriber = IntSubscriber()
publisher.subscribe(subscriber)  // publisher에서 subscriber까지 stream 프로세스 정리.
                                // 1 subscriber가 subscribe한다 publisher를.
                                // 2 여기엔 없어서 안보이지만, protocol publisher내 receive(subscriber:)함수 호출 (생성자가 구독자를 받는 행위)
                                // 3 publisher가 subscription 생성
                                // 4 protocol subscriber에 정의된 receive(subscription:) 함수 호출 (구독자가 구독권을 받는 행위)
                                // 5 protocol subscription내 request(_:)함수 호출 파라미터는 Demand 타입 (값을 최대 몇개 받을것인지 설정)
                                // 6 protocol subscriber내 receive(_:)를 통해 publisher가 방출하는 값들을 받을수 있다. 파라미터는 Demand 타입. request함수에 넣은 값만큼 호출
                                // 7 만약 publisher가 더 이상 값을 생성하지 않거나 error를 발생한다면, protocol subscriber내 receive(completion:)을 호출해 종료.
                                
                                // subscription의 역할
                                //  - publisher에서 새로운 값들이 발생 했을때 subscriber가 요청한것 보다 더 많은 값을 받지 않도록 보장.
                                //  - subscribers의 유지 및 해제를 관리.
