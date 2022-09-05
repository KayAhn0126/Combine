# Combine 정리
- 주요 컴포넌트
- Publisher, Subscriber, Operator

## 🍎 Publisher - 생산자
```swift
protocol Publisher {
    associatedtype Output
    associatedtype Faulure: Error
    func subscribe<S: Subscriber>(_ subscriber: S)
        where S.Input == Output, S.Failure == Failure
}
```
- 구체적인 Output 및 실패 타입을 정의
- Subscriber가 요청한것 만큼 데이터를 제공
- Built-In Publisher 제공
    - Just -> 값을 다룸
    - Future -> Function을 다룸

### 🍎 특별한 형태의 Publisher
#### Subject
- send(_:) 메서드를 통해 이벤트 값을 주입 시킬수 있는 Publisher
- 기존의 비동기처리 방식에서 Combine으로 전환시 유용
- 2가지 Built - In 타입
    - **PassthroughSubject**
        - Subscriber가 데이터를 요청하면 그 시점부터 받은 값을 전달, 전달한 값을 들고있지 않음.
    - **CurrentValueSubject**
        - Subscriber가 데이터를 요청하면 가지고 있던 값을 전달하고, 그때 부터 받은 값을 전달, 전달한 값 들고있음.
#### @Published
- @Published로 선언된 프로퍼티를 Publisher로 만들어준다.
- 클래스에 한해서 사용됨 (구조체에서 사용 안됨)
- $를 이용해서 퍼블리셔에 접근할 수 있음.
```swift
class Weather {
    @Published var temperature: Double
    init(temperature: Double) {
        self.temperature = temperature
    }
}

let weather = Weather(temperature: 20)
let subscription = weather.$temperature.sink {
    print ("Temperature now: \($0)")
}
weather.temperature = 25

// Temperature now: 20.0
// Temperature now: 25.0
```
- @Published로 선언 해주면서 temperature는 값이 바뀔때마다 데이터를 방출 할 수 있는 publisher가 되었다.
## 🍎 Subscriber - 소비자

```swift
protocol Subscriber {
    associatedtype Input
    associatedtype Failure: Error
    
    func receive(subscription: Subscription)
    func receive(_ input: Input) -> Subscribers.Demand
    func receive(completion: Subscribers.Completion<Failure>)
}
```
- Publisher에게 데이터 요청
- 구체적인 Input 및 실패 타입을 정의
- Publusher 구독 후, 갯수 요청
- 파이프라인 취소 가능
- Built - In Subscriber
    - assign
        - Publisher가 제공한 데이터를 특정 객체의 키패스에 할당 
    - sink
        - Publisher가 제공한 데이터를 받을수 있는 클로져 제공



## 🍎 Publisher와 Subscriber의 관계
![](https://i.imgur.com/5ci7NL5.png)

- Subscription이란?
    - Publisher 가 발행한 구독 티켓
    - 구독 티켓이 있어야 데이터를 받을수 있다
    - 구독 티켓이 없으면 구독 관계도 끝
    - Subscription은 Cancellable 프로토콜을 따르고 있어 Subscription을 통해 연결 Cancel 가능

## 🍎 Operator - 가공자
- Publisher에게 받은 값을 가공해 Subscriber에게 제공
- Input, Output, Failure type을 받는데 타입이 다를수 있다.
- Built - In 오퍼레이터가 많이 있다.
    - map, filter, reduce, collect, combineLatest...

## 🍎 Scheduler - 스케쥴러
- 언제, 어떻게 클로져를 실행할지 정해준다.
- Operator에서 Scheduler를 파라미터로 받을때가 있다.
    - 따라서, 작업에 따라서, 백그라운드 혹은 메인스레드에서 작업이 실행될수 있게 도와줌
- Scheduler 가 스레드 자체는 아니다.

### 🍎 2가지 Scheduler 메소드
#### subscribe(on:)
- Publisher가 어느 스레드에서 수행할지 결정해주는 메서드
    - 무거운 작업은 메인스레드가 아닌 다른 스레드에서 작업할수 있게 도와줌
        - 예) 백그라운드 계산이 많이 필요한것
        - 예) 파일 다운로드해야하는 경우

#### receive(on:)
- operator, subscriber 가 어느 스레드에서 수행할지 결정해주는 메서드
    - UI 업데이트 필요한 데이터를 메인스레드에서 받을수 있게 도와줌 
        - 예) 서버에서 가져온 데이터를 UI 업데이트 할때

#### 2가지 메서드를 사용한 일반적인 패턴
```swift
let jsonPublisher = MyJSONLoaderPublisher() // publisher

jsonPublisher
    .subscribe(on: backgroundQueue)
    .receive(on: RunLoop.main)
    .sink { value in
        label.text = value
}
```

#### UI 업데이트 시
- ❌ 이렇게 하지말고
```swift
pub.sink {
    DispatchQueue.main.async {
        // Do update ui
    }
}
```

- 🆗 이렇게 하기
```swift
pub.receive(on: DispatchQueue.main).sink {
        // Do update ui
}
```

- 첫번째 코드로 실행해도 문제는 없지만 애플이 추구하는 방향은 두번째 코드.
