[스탠포드] Swift를 활용한 iOS11 앱 개발


5강. 뷰에 나타내기


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
