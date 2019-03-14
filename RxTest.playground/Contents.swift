import UIKit
import RxSwift
import RxCocoa

var str = "Hello, playground"


let publish = PublishSubject<Int>()
let behair = BehaviorSubject<Int>(value: 0)
publish.onNext(1)
behair.onNext(1)

let pubR = PublishRelay<Int>()
pubR.accept(2)

let bahR = BehaviorRelay<Int>.init(value: 7)
bahR.accept(4)

publish.subscribe(onNext: { bool in
    print(bool)
})

behair.subscribe(onNext: { bool in
    print(bool)
})

pubR.subscribe(onNext: { bool in
    print(bool)
})

bahR.subscribe(onNext: { bool in
    print(bool)
})

