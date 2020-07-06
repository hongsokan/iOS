[스탠포드] Swift를 활용한 iOS11 앱 개발


6강. 멀티터치


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
