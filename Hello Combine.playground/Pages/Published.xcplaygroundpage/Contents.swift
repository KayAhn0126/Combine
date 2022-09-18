//: [Previous](@previous)

import Foundation
import UIKit
import Combine

final class SomeViewModel {
    @Published var name: String = "Jack"        // @Published는 class에서만 사용할 수 있다.
}

final class Label {
    var text: String = ""
}

// SomeViewModel 클래스에 있는 (@Publisher)퍼블리셔로 등록된 name 프로퍼티의 값 "Jack"을 Label 클래스의 text에 넣는 작업.
let label = Label()
let vm = SomeViewModel()

vm.$name.assign(to: \.text, on: label)  // -> vw의 name 프로퍼티를 label의 text 프로퍼티에 assign 해주세요~!
// $name은 "name 프로퍼티가 publisher이다" 라고 알려주는것.
print(label.text)   // "Jack"

vm.name = "Kay"
print(label.text)   // "Kay"
// vm의 name이라는 값을 "Kay"라고 바꿨을 뿐인데 어떻게 label.text에도 적용이 되는것일까?
// -> name프로퍼티는 publisher로 선언이 되었기 때문에 값이 바뀔때마다 데이터를 방출한다. 19 번째 라인에서 label의 text프로퍼티가 assigned 되었기 때문에 label.text의 값이 바뀌는것.

//: [Next](@next)
