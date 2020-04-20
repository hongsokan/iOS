[부스트코스] iOS 프로그래밍
파트2. 회원가입 화면 구현



강의 내용
- 디자인패턴: Delegation Pattern, Singleton, Target-Action
- View Transition: Navigation. Modal
- UIKit : UITextField, UIDatePicker, UIStackView, UIImagePickerController, UINavigationController, UIGestureRecognizer, View Controller States Methods
- Foundation: DateFormatter
- Swift: Dictionary, guard



1. H.I.G.
- 애플리케이션 개발할 때 사용자 인터페이스 구성 방법에 대한 지침. 
- H.I.G. 문서의 가이드라인으로 인터페이스를 작성하여 iOS 사용자에게 익숙한 환경 제공.
- 개발자가 iOS 사용자에게 좋은 인터페이스 제공하도록 도와주는 가이드라인.
=> iOS 디자인은 명확함, 컨텐츠 존중, 깊이를 중요시, 사용자를 위한 디자인 원칙 강조

왜 필요한가?
- 개발자가 아닌 사용자 입장에서 애플리케이션 설계
- 애플리케이션 일관성 유지
- 기획자, 디자이너와의 협업에서 기준점 제시
- 새로운 애플리케이션도 익숙한 환경 제공
- 이미 검증된 사용자 경험을 이해하고 그것을 토대로 조금 더 유연한 사용자 경험 설계 가능

내용 구성 (edwith강의에서 제공하는 pdf 문서 살펴보기)
- Overview : iOS 버전, iPhone 버전에 따른 특징 살펴볼 필요 있을 듯
- App Architecture : 사용자에 권한요청 시 설계, 장애가 있는 사용자에 대한 설계 등 디테일함
- User Interaction : 좋은 오디오 환경 설계, 생체인증 요청적용, 제스처 설계, NFC 설계 등
- System Capabilities : 멀티태스킹, 알림 기능, 프린팅?, Siri 등
- Visual Design : iOS 기기별 화면크기, 애니메이션, 색상 및 글꼴까지 고려
- Icons and Images : 이미지 크기, 해상도, 앱 아이콘 등
- Bars : 내비게이션바, 검색바, 상태바, 탭바, 툴바
- Views : 컬렉션뷰, 테이블뷰, 이미지뷰, 맵뷰, 텍스트뷰, 웹뷰 등
- Controls : 버튼, 레이블, 피커, 슬라이더 등
- Extensions : 키보드 확장 기능, iMessage 확장 기능 등
- Technologies : 애플페이, ARKit, HealthKit, iCloud 등
- Resources : iOS 포함 애플 플랫폼들에 제공되는 자원 관한 내용
=> 이외에도 HIG 한글 번역된 자료 등 더 살펴보면 좋을 듯
(https://www.slideshare.net/DongJinLee22/ios-human-interface-guidelines-85848533)


2. 화면 전환 (내비게이션, 모달)
- 내비 인터페이스는 계층적 구조의 화면전환 위해 사용되는 drill-down interface
- 내비 컨트롤러로 구현, 내비 컨트롤러는 컨탠트 뷰 컨트롤러, 내비 스택으로 관리 (루트 뷰 컨트롤러에 계속 화면이 쌓이는 스택 구조, push & pop)
- 모달은 이목을 집중해야 하는 화면을 다른 화면 위로 Presenting 하는 표현 방식
- 모달 사라지게 하려면 반드시 특정 선택해야 함, 경고창 혹은 액션시트 등
- 전체화면, 페이지, 폼, 팝오버 등 스타일

￼
(액션 시트 내부 alert controller)





3. 뷰 상태변화 감지
- 뷰의 상태 변화나 레이아웃에 변화 생기면 뷰 컨트롤러는 여러 메서드 호출해 서브클래스 적절히 대응하게 할 수 있다
- 뷰의 상태 변화 매서드: viewDidLoad, viewWillAppear, viewDidDisappear 등
- 뷰의 레이아웃 변화 메서드: viewWillLayoutSubviews, viewDidLayoutSubviews 등
- override 키워드 명시하고 super 호출해서 사용




￼
4. Delegation
- 델리게이션 디자인 패턴은 하나의 객체가 다른 객체 대신해 동작 또는 조정할 수 있는 기능 제공
- 특정 상황에 대리자에게 메시지 전달하고 그에 적절한 응답 받기 위한 목적으로 사용
- 델리게이트는 사용자 인터페이스 제어 관련 권한 위임받고, 데이터소스는 데이터 제어 기능 위임받음
- 코코아터치에서 프로토콜 사용해 델리게이션과 데이터소스 구현 가능, 객체간 소통 위한 강력한 통신 규약

공식문서 참고, 다양하게 쓰이므로 익숙해 질 필요 있음
https://jusung.gitbook.io/the-swift-language-guide/language-guide/21-protocols



5. Singleton
- 특정 클래스의 인스턴스가 오직 하나임을 보장하는 객체
- 대표적으로 FileManager, URLSession, NotificationCenter 등
- 객체 불필요하게 여러 개 만들어질 필요 없는 경우 많이 사용. 
- 예를 들면 환경설정, 네트워크 연결처리, 데이터 관리 등. 멀티스레드 환경과는 맞지 않음
- UIStackView



6. Target-Action
- Target-Action 디자인 패턴에서 객체는 이벤트 발생 시, 다른 객체에 메시지 보낼 때 필요한 정보 포함
- 액션은 특정 이벤트 발생 시 호출할 메서드 의미, 타겟은 액션이 호출될 객체 의미
- 이벤트 발생 시 전송된 메시지는 액션 메시지, 타겟은 모든 객체 가능하나 보통 컨트롤러가 일반적
- addTarget 등으로 특정 메서드 타겟으로 정해 호출하는 것
- UIDatePicker



7. Gesture Recognizer
- 여러 제스처 관련 이벤트 인식
- 특정 제스처 이벤트 발생 시 각 타깃에 맞는 액션 메시지 보내 제스처 관련 이벤트 처리 가능
- 강의처럼 인터페이스 / 인터페이스 + 코드 / 코드 (델리게이트) 방식으로 구현 가능
- UITextField
