
# Swift를 활용한 iOS11 앱 개발 [스탠포드 CS193P - edwith 강의](https://www.edwith.org/swiftapp)


## 3강. Swift 프로그래밍 언어 - Part 1




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



## 4강. Swift 프로그래밍 언어 - Part 2




핵심 키워드
- Mutating
- Protocol
- 클로저
- String



클래스 -> 구조체 데모
- 클래스에 구현한 메서드 앞에 mutating 을 붙여 객체를 바꾸는 함수라 알린다.
- 변수의 경우에는 var 인지 let 인지, 그기고 계산된 속성의 get 과 set 이 모두 있는지에 달려있다.
- 그래서 함수에만 mutating 을 붙여주면 된다.
- 바꾸는 이유? 참조타입 대신 값타입으로, 구조체는 계속해서 전체를 복사, 스위프트에선 내용이 변경될 때만 복제, 쓰기 시 복사 방식
- 클래스는 힙 내부에 존재, 그저 포인터를 전달하는 방식



프로토콜
- 스위프트의 자료구조 형성하는 기둥들 : 클래스, 구조체, 열거형, 프로토콜
- 별도의 구현이 없는 메소드와 변수의 리스트, API 에서 원하는 것을 불러오는 방식
- API 를 매우 유연하고 더 잘 이해할 수 있도록 만든다. 블라인드 커뮤니케이션 구조에 유용. 
(MVC 에서 V 와 C 사이, will, did, should 와 데이터, 카운트 등 모두 블라인드 상태여야 한다. -> 뷰는 일반적, 컨트롤러는 매우 구체적, 프로토콜은 구현, 권한 주기에 유용)
- 또 서로 다른 타입끼리 기능 공유에 유용
- 다중 상속 가능, 순수하게 기능만 상속

- 프로토콜의 3가지 모습 (가장 중요한 점은 프로토콜은 단지 리턴값을 가지는 메소드와 변수의 리스트라는 점, 구현은 다른 타입들이, 저장 공간은 다른 타입에)
- (선언)프로토콜 선언: 다른 자료구조 타입과 같다, 리턴값을 가지는 메소드와 변수의 리스트
- (구현)다른 타입이 프로토콜의 메소드와 변수 구현
- (코드)프로토콜의 메소드와 변수 구현하는 클래스나 구조체나 열겨형

- 프로토콜 내에 있는 어떤 메소드던, 구조체에 의해 구현되어서 그 내용을 수정한다면, mutating 표시를 해줘야 한다.
- 반대로 프로토콜이 절대 구조체에서 구현되지 않을 거라는 걸 안다면, 클래스만 받는 프로토콜임을 표시, class
- 만약 프로토콜 내에 init 이 있고, 클래스로 프로토콜을 구현하려고 한다면, init 이 required 표시가 되어 있어야 한다.

- 프로토콜의 용도
- MVC 델리게이션
- Hashable, Equatable (Concentration 예제)
- 다중 상속 : CountableRange, Sequence, Collection (프로토콜의 익스텐션)



문자열
- 유니코드, ASCII
- 문자열의 인덱싱 String.Index 타입, index(of: ) / components(separatedBy: )
- NSAttributedString : 각각의 문자가 속성을 갖고 있는 문자열



함수 타입
- var operation: (Double) -> Double
- 클로저 문법 활용 : map 메서드, property initialization (lazy), capturing
- 클로저는 참조타입, 함수




## 5강. 뷰에 나타내기


핵심 키워드
- Keywords
- Error Handling
- Any
- Custom Drawing
- Enum


에러 처리
-  thrown errors : do-catch 활용 , 에러를 날리면 잡아야 한다, do { try 처리할 내용 } catch let error { throw error }
- try! 오류 발생하지 않는 확실한 경우, 오류 발생 시 강제종료 / try? 심각하지 않은 경우, 앱을 멈추지 말고 오류 무시, 리턴 값은 옵셔널 타입

Any & AnyObject
- 특별한 타입, 타입이 뭔지 알 수 없고 어떠한 타입이 될 수도 있다, Objective-C 와 호환 (id 타입)
- prepare(for segue, sender) 화면전환을 위한 세그웨이에서 두번째 인자 sender 는 Any? 타입 (즉 세그웨이를 발생하는 것은 버튼, 셀, 코드 같은 경우 nil)
- How to use? 반드시 내가 아는 타입으로 바꿔줘야 한다. as? 는 Any 를 명시한 타입으로 변환, 불가능할 경우 nil  (if let 과 as?)
- as? 는 Any 뿐만 아니라 다른 타입에서도 사용 가능

Casting
- downcasing, let vc: UIViewController = ConcentrationViewController(), 가능한 문법, 그러나 vc.flipCard(…) 은 불가능
- If let cvc = vc as? ConcentrationViewController { cvc.flipCard(…) }, 타입 캐스팅을 통해 사용 가능, vc 에서 하위 형변환

Other Interesting Classes
- NSObject: Ob-C 의 모든 클래스의 루트 클래스, UIKit 모든 클래스들이 Ob-C 에서 개발됨, 여전히 호환
- NSNumber: Ob-C 에서 숫자 전달 시 이 클래스 이용, 참조할 때 사용
- Date: 날짜나 시간 표현하는 타입
- Data: 비트가 담겨 있는 가방, iOS API 간에 데이터 전송 시 사용, UIImage, JSON 등 

Views
- MVC 에서 View, MVC 패턴의 뷰는 수많은 뷰들 (UIView 의 서브클래스 View 와 다른 개념)
- UIView 의 서브클래스? 좌표계를 정의하는 화면의 사각형, 드로잉, 멀티터치 등, 계층 구조
- 코드로 구현 가능, func addSubview(), func removeFromSuperview() 등
- 뷰 계층의 최상위는? UIViewController 에는 아주 중요한 변수인 view(UIView 타입) 가 있고, 이는 최상위 검정색 뷰를 가리킨다.
- 뷰는 아울렛을 이용하여 언제 어디서나 접근 가능

Initializing a UIView
- init(frame: CGRect), init(coder: NSCoder), 둘 다 구현해야 함
- awakeFromNib() 함수, 인터페이스 빌더 파일에서 나온 모든 오브젝트에게 보내진다(UIButton, UIViewController 등), 인터페이스 빌더에 의존

Coordinate System Data Structures
- CGFloat (Core Graphics: 2차원 드로잉을 위한 시스템, 4개의 타입)
- CGPoint (CGFloat 타입 변수 x, y가 들어있는 구조체)
- CGSize (CGFloat 타입 높이, 너비 있는 구조체)
- CGRect (CGPoint 점과 CGPoint 크기를 조합함, 직사각형, 뷰의 경계

View Coordinate System
- 좌표 시스템에서는 points 단위 (픽셀 X),  보통 2 pixels per point (1~3 point), UIView의 contentScaleFactor 로 확인 가능
- 모든 UIView 에서 가장 중요한 직사각형은 bounds, 현재 뷰의 원점, 높이, 너비 등을 알 수 있음 (자신의 좌표계, 뷰마다 서로 다른 좌표계 갖고 있음)
- frame: frame 은 슈퍼 뷰에서 어디 있는지를 말함 (슈퍼 뷰의 좌표계)
- center 도 슈퍼 뷰의 입장에서 뷰의 중심을 말함
- frame과 center는 드로잉을 하고 있는 곳이 어딘지, bounds는 지금 드로잉하는 곳

Custom Views
- view 를 다시 드로잉하는 경우, draw(CGRect) 를 직접 호출해선 안되고, setNeedsDisplay(), setNeedsDisplay(_ rect: CGRect) 이용해야 된다
- draw를 호출할 수 있는 것은 iOS 시스템 뿐
- 코어 그래픽스: 컨텍스트 기반, UIGraphicsGetCurrentContext(), UIBezierPath

Drawing
- UIBezierPath, addClip() : 만약 삼각형을 그리고 addClip() 사용하면 이후 드로잉은 모두 삼각형 안에 남는다.
- UIColor.green … , .withAlphaComponent(0.5), 알파0(완전투명 fully transparent) ~ 알파1(완전불투명 fully opaque)
- 뷰에서 투명도를 바꾸고 싶다면 변수 var opaque =  false 로 해야한다. UIView 전체의 투명도는 var alpha: CGFloat, 뷰 내 모든 드로잉에 적용

Layers
- 드로잉을 위한 다른 레이어 CALayer, 코어 애니메이션 API
- subviews 리스트의 순서로 뷰의 순서를 알 수 있다
- isHidden 으로 숨길 수 있다, 어떤 조건 충족 시 나타나게 할 수 있다 

Drawing Text
- UILabel: Usually use it
- NSAttributtedString: To draw in draw(CGRect), use it
- NSRange: Accessing a range of characters in an NSAttributedString, 과거 Ob-C 에서 범위를 쓸 때 사용하던 방법

Fonts
- 적절한 폰트를 선택하기 위해선? 그냥 애플에서 제공하는 Preferred Fonts 사용, UIFontTextStyle, preferredFont()
- 오토레이아웃으로 가변적인 폰트 크기 설정하는 것이 좋을 것

Drawing Images
- UIImage(named: ), UIImage(contentsOfFile: ), UIImage(data: )
- UIGraphicsBeginImageContext(CGSize) 로 직접 그릴 수도 있다

Redraw on bounds change?
- UIView 의 bounds 가 바뀌는 경우, UIView 의 contentMode 로 설정하여 redraw 할 수 있다
- .left/.top/.bottomRight/.center 등, 비율 유지하고 위치만 조정
- .scaleToFill/.scaleAspectFill/.scaleAspectFit , 비율 조정
- .redraw
- 드로잉 한 경우




## 6강. 멀티터치


핵심 키워드
- PlayingCard demo continued
- Gestures: Getting multitouch input from users
- Demo: Manipulating our Playing Card / Swiping, Tapping and Pinching

CustomStringConvertible
- 인스턴스를 문자열로 변환하는 자체 표현을 제공한다.
- 이 프로토콜을 준수하기 위해 description 프로퍼티를 구현해야 한다.

PlayingCardView
- 코어그래픽스와 UIBazierPath 사용 방법
- UIView를 상속 받아 draw() 메서드를 통해 View를 직접 구성해본다. (지난 강의에서 코어그래픽스 활용)
- Custom View 에서 세로로 landscape 할 경우, Contend Mode 를  Redraw 로 설정하면 다시 그림
- View의 모서리 둥글게 하고 싶다면? draw() 메서드 override 해서 UIBezierPath로 bounds 조정 [C2-1]

centeredAttributedString()
- preferredFont로 font 선택
- UIFontMetrics로 리셋, scaledFont로 설정에서 폰트 크기 설정되는 값를 정할 수 있다.

cornerString
- rank+”\n”+suit, fontSize: 0.0
- rank 는 정수형이므로 rank+suit를 쓸 수 없다. -> extension PlayingCardView 에서 rankString 처리
- rankString+”\n”+suit 로 사용, fontSize 의 값도 cornerFontSize 로 변경

class PlayingCardView: UIView
- rank: 정수형
- suit: 문자열
- 여기서는 모델과 상관없이 오로지 카드를 드로잉하는 뷰 
- 그렇다면 뷰와 모델 사이의 번역은 누가? 바로 컨트롤러!
- isFaceUp: Bool
- 임의로 초기화하고, (ex. rank = 5) 값이 바뀌면 어떻게 처리? var = 5 { didSet { setNeedsDisplay(); setNeedsLayout() } } 
(모든 public var 들에 해줘야 된다. public var 가 바뀌어서 카드의 겉모양이 바뀌어야 할 경우)
- setNeedsDisplay 는 layoutSubviews() 메서드를 호출, setNeedsLayout() 은 draw() 메서드를 호출
- layoutSubviews 에서 upperLeftCornerLabel, lowerRightCornerLabel 의 frame 값 설정

extension PlayingCardView
- 데모의 속도를 높이기 위해 extension 처리
- SizeRatio 내부 모든 상수는 비율 (코너, 폰트, 카드 크기 비율) 

createCornerLabel()
- UILabel 만들고 리턴
- upperLeftCornerLabel, lowerRightCornerLabel 을 위한 함수
- 하지만 속성 이니셜라이저에서 해당 함수의 인스턴스를 바로 쓸 수는 없음 -> 완전한 초기화를 요구하기 때문에 지연시켜주는 lazy 활용

configureCornerLabel()
- cornerLabel 의 속성을 위해 추가할 메서드
- 카드가 뒤집힌 경우에는 숨긴다 (isHidden)
- 그리고 layoutSubviews() 에서 대각선에서도 똑같은 숫자(5)와 모양(하트)가 보여지도록 frame 값 추가 (lowerRightCornerLabel, maxX 와 maxY 에 고정시키고 - 값을 준 다음, CGAffineTransform() 메서드로 아핀 변환 -> 평행이동 + CGFloat.pi 만큼 회전)

traitCollectionDidChange()
- 화면이 회전하는지, 가로인지 세로 모드인지, 폰트 크기가 바뀌었는지 등 시스템 특성이 바뀌었는지 감지하는 메서드

Priority
- 중요하지 않는 뷰 제약조건의 우선순위는 낮게 설정 (required, high, low)

IBDesignable
- IBInspectable : inspector에서 해당 인터페이스 요소의 속성을 변경할 수 있게 하는 것 (인터페이스 빌더에서 인스펙터 속성 추가)
- IBInspectable 은 런타임에만 속성이 적용된 것을 확인 가능
- IBDesignable 은 컴파일타임, 실시간으로 볼 수 있게 해준다 (인터페이스 빌더에서)


멀티터치
- UIGesturesRecognizer : 스와이프, 확대/축소, 이동, 탭 등
- target : 보통 self
- action : 호출 할 메서드
