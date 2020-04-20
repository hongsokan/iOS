[스탠포드] Swift를 활용한 iOS11 앱 개발


3강. Swift 프로그래밍 언어 - Part 1




핵심 키워드

- Tuple
- Computed Property
- 접근제어
- 익스텐션
- 열거형
- 옵셔널




오토레이아웃 데모

- 기기의 화면을 가로에서 세로로 두면 Storyboard 에서 세팅한 UI는 원하는대로 나타나지 않는데, 오토레이아웃으로 해결할 수 있다.
- 스택뷰를 사용하여 해결 (스택뷰는 가로, 세로 단위로 UI를 모을 수 있다)
- Left & Right 대신 Leading & Trailing 을 쓰는 이유는 히브리어나 아랍어 같은 경우는 오른쪽에서 왼쪽으로 가기 때문이다. 
- Top to safe area & Bottom to safe area




첫주차 강의

- Target/Action, Outlets and Outlet Collections
- Methods and Properties
- Property Observer (didSet)
- Array<Element>
- MVC
- Value types (struct) vs Reference types (class)
- Initializers
- Type (static) methods
- lazy properties
- for in loops
- Dictionary<Key, Value>
- Type conversion
- Optional  




Range

- Swift 에서는 시퀀스라는 개념을 통해 반복문이 동작하기 때문에, 셀 수 있는 경우는 문제가 없지만, Floating point 의 CountableRange 는 stride 라는 전역 함수를 사용해야 한다. (from, through 혹은 from, to)
ex) for a in stride(from:10.0, to:20.0, by:0.2) { print(a) }	//10.2, 10.4, …




Tuple

- 메소드나 변수가 없는 소형 구조체, 그냥 값만 있는 형태 (다른 언어의 구조체와 비슷)
- 가볍고 한 줄에 모든 것 정의, 요소의 이름 유연하게 정할 수 있다, 함수 리턴 값으로 튜플 활용 가능 (원래 Swift 함수는 하나의 값만 리턴, 튜플로 여러 개 반환 가능)
ex) 
let x: (String, Int, Double) = (“hello”, 5, 0.85)
let (word, number, value) = x
print(word)	// prints hello
…

or
let x: (w: String, i: Int, v: Double) = (“hello”, 5, 0.85)
print(x.w)		// prints hello
…

그리고 이름 재정의도 가능, 아래는 지역변수로 다시 선언한 것
let (wrd, num, val) = x




Computed Properties

- 보통은 저장 프로퍼티 (Stored Property) 사용
- 연산 프로퍼티는 저장되지 않고 get, set 과 함께 사용된다
- 매번 연산 프로퍼티 요청 시 get 코드 실행, 값 할당 시 set 코드 실행

- Why? 보통 프로퍼티는 구조체 안의 다른 상태로부터 얻어졌을 가능성 많다

ex) Concentration 앱에서
var indexOfOneAndOnlyFaceUpCard: Int? 이 프로퍼티에서
get 에서는 모든 카드 살펴보고, 앞면인 카드 한 장만 찾으면 그 인덱스 리턴, 없다면 nil
set 에서는 그 인덱스 받아서, 그 카드만 앞면이고 다른 모든 카드가 뒷면인 것을 확인 

 


Access Control
- internal
- private
- prinvate(set) : 값 바꾸는 것만 private, 읽는 것은 internal
- fileprivate
- public (for frameworks only)
- open (for frameworks only)




Extension
- 변수와 함수를 다른 클래스에 추가 가능
- 값은 저장할 수 없다
- 클래스에 어울리지 않는 변수나 함수 추가는 지양! (남용하지 말 것)




Enumeration
- 열거형, 분리된 값만 가질 수 있음, 값 타입 (전달 시 복제)
- 연동 자료 (associated data) 와 활용 가능
- 메서드나 변수를 가질 수 있지만 저장 공간을 가지지 않는다, 계산된 변수만을 가질 수 있다
- mutating




Optional
- 제네릭 타입, 열겨형, case none 혹은 case some(<T>)
- none 은 아직 설정되지 않은 경우, some 은 그 타입의 연동 자료를 가지고 있는 것
- 옵셔널 체이닝




ARC
- Auto Reference Counting, 자동 참조 횟수 카운팅
- 클래스는 힙 내부에서 언제 사라지는지(?) 알 수 있다
- strong, weak(옵셔널), unowned(참조하지 않는다는 의미)
