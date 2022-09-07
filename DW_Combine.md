# 나만의 Combine 정리
- [출처](https://www.donnywals.com/an-introduction-to-combine/)

## 🍎 publishers and subscribers
- publisher는 데이터를 하나, 여러개, 0 개를 방출할 수 있다.
- 방출이 끝났으면 Completion을, 방출 도중 에러가 났으면 에러 이벤트를 방출한다.

![](https://i.imgur.com/tiWKrmO.png)

- 브라운 -> completion으로 끝난 Publisher
    - completion으로 끝나게 되면 publisher는 더이상 어떤 값도 방출하지 않는다.
- 레드 -> error로 끝난 Publisher
    - error는 publisher의 방출(stream)을 종료한다.

## 🍎 sink의 역할

![](https://i.imgur.com/PLtgJpw.png)
- **sink(receiveCompletion:receiveValue:)** method로 publisher를 subscribe 할 수 있다. 
- 이 메서드는 해당 메서드를 호출한 publisher를 subscribe 하는 subscriber를 만든다. 
- 즉 publisher가 sink(receiveCompletion:receiveValue:)메서드를 부르면 subscriber를 즉시 만들고 publisher가 streaming value(s)를 가능케 한다.
- publisher는 subscriber가 있어야 데이터를 방출한다.
- 결과
![](https://i.imgur.com/aOorKeL.png)

## 🍎 Keeping track of subscriptions
#### sink의 반환 객체를 저장하자!
- 위의 코드에서는 sink메서드에서 반환된 객체를 저장하고 있지 않다.
    - playground에서는 괜찮다. 하지만...
- 프로젝트에서는 반환된 subscription을 들고있는 변수가 있어야 한다!
- 만약 변수에 저장하지 않으면 subscription을 생성하는 스코프를 빠져 나가자마자 사라진다.

#### sink의 return type AnyCancellable
- return 받은 subscription은 Cancellable 타입.
- 해당 subscription을 삭제하고 싶다면 cancel 호출하기.
