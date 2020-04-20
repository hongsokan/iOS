[http://reactivex.io/](http://reactivex.io/)

[곰튀김님 강의 유튜브](https://www.youtube.com/channel/UCsrPur3UrxuwGmT1Jq6tkQw)

[곰튀김님 강의 깃허브](https://github.com/iamchiwon/RxSwift_In_4_Hours)

RxSwift

- RxSwift란? ReativeX 시리즈 중 하나
- ReativeX? 비동기 프로그래밍를 하기 위한 API, (observable stream을 가지고)
- MS에서 만듦
- 주요 기능 5가지:  Observable, Operators, Single, Subject, Scheduler

step1

- PromiseKit, Volts, RxSwift: 비동기 처리를 위한 라이브러리, 사용 방법은 모두 비슷, 예제 참고
- PromiseKit → Promise<리턴타입?> { }
- Volts → Task<리턴타입> { }
- RxSwift → <리턴타입?> { }
- 모두 똑같은 목적으로 쓰이지만, RxSwift는 Operators 기능도 있다!

- Disposable: dispose()로 진행 중인 비동기 작업 간단하게 취소 가능
- DisposeBag() : disposable에 담긴 작업 여러 개 담을 수 있다, 동시에 처리 가능

step2

- onNext() 데이터 전달 방식은 Observable.just() 로 간단하게 사용 가능
- .subscribe 하면 just() 내용이 바로 전달된다
- just() 쓰면 배열도 그대로 전달, from() 이랑 쓰면 하나씩 전달
- map() 함수와 활용 가능, just().map().subscribe() 이런식
- observable stream: observable.just().map().subscribe() 이런 방식의 표현, 다양하게 활용 가능
