[iOS 부스트코스] 5강. 영화정보 애플리케이션

개요
- 서버 API 통신
- 영화정보 보여주기
- 테이블뷰
- 컬렉션뷰

얼럿과 액션시트
- 사용자에게 경고 또는 알림 메시지를 표시
- 타이틀, 메시지, 액션(확인, 취소 등)으로 구성
- UIAlertController 클래스를 통해 구성 후 UIViewController의 present() 메서드를 사용해 모달로 보여줌
- UIAlertAction 클래스로 내부에서 사용할 버튼과 수행할 액션 구성
￼
￼

* 실습: cancel 중복해서 사용하면 오류, 액션시트에는 텍스트필드 추가할 수 없음


탭바
- 화면 하단, 뷰 컨트롤러 사이 화면전환을 위해 사용되는 인터페이스로 여러 메뉴 구성할 때 많이 사용
- 직접 탭바를 제어할 컨트롤러 클래스 작성해서 사용할 수도 있지만, 대부분 UITabBarController 사용하여 제어
- 탭바 구조: 탭바 컨트롤러는 연결된 컨텐츠 뷰 컨트롤러들의 컨테이너 뷰 컨트롤러. 각 컨텐츠 VC는 탭바에서 하나의 탭에 해당
￼
- 탭바 아이템: 탭바 뷰에서 각 탭의 이름과 이미지(아이콘), 6개 이상인 경우 5번째 탭부터 ‘More’로 묶이게 된다
- 탭바 델리게이트: 사용자와 상호작용 시, 탭바 컨트롤러 객체는 이에 관한 알림을 델리게이트 인스턴스(UITabBarControllerDelegate)로 보낸다.

URLSession
- URLSession: HTTP/HTTPS를 통해 콘텐츠(데이터)를 주고받는 API를 제공하는 클래스
- 인증 지원 위한 많은 델리게이트 메서드 제공, 어플 실행 중이지 않거나 일시 중단 시 백그라운드 작업, URLSession API 사용 위해 어플은 세션 생성
- 3가지 세션 유형: 기본 세션, 임시 세션, 백그라운드 세션

- 3가지 작업 유형: 데이터 작업, 업로드 작업, 다운로드 작업
- (데이터작업)URLSessionDataTask: HTTP의 각종 메서드 이용해 서버에서 응답 데이터 받아서 Data 객체를 가져오는 작업 수행
- (업로드작업)URLSessionUploadTask: 어플에서 웹 서버로 Data 객체 또는 파일 데이터 업로드하는 작업 수행, 주로 HTTP POST/PUT 메서드
- (다운로드작업)URLSessionDownloadTask: 서버에서 데이터 다운 받아서 파일의 형태로 저장하는 작업 수행, 백그라운드 상태에서도 다운 가능
- 데이터 작업은 어떤 응답이라도 Data객체 형태로 전달받을 때, 업로드 및 다운로드 작업은 단순한 바이너리 파일 전달 목적

- App Transport Security- ATS: 어플과 웹 서비스 사이에 통신 보안 향상 기능, iOS 9.0, macOS 10.11부터 적용 가능
- 모든 인터넷 통신 시 안전한 프로토콜 사용토록 보장, 사용자의 민감 정보 유출 방지
- 2016년부터 새롭게 만들 어플은 반드시 ATS 사용

- URLSession, CFURL, NSURLConnection API 이용해 데이터 주고 받을 때 ATS 기능 사용
- ATS 활성화 시 HTTP통신 불가, 애플에서 권장하는 요구 사항 충족해야 네트워크 연결 가능

- 용어
- 전송 계층 보안(Transport Layer Security, TLS): 암호 프로토콜, 도청,간섭,위조 방지위해 설계
- HTTPS(Hypertext Transfer Protocol Secure): TLS 사용해 암호화된 연결하는 HTTP
- 어플이 ATS 요구사항 충족하기 힘든 경우, ATS 기능 비활성화 가능
- ATS 기능 사용하지 않을 수 있는 예외사항: AVFoundation 프레임워크를 통한 스트리밍 서비스, Webkit 을 통한 컨텐츠 요청, 로컬 네트워크 연결, 유지보수 위해 일시적으로 사용하지 않을 수도 있음
- info.plist 에서 비활성화 설정


Grand Central Dispatch
- 멀티코어와 멀티 프로세싱 환경에서 최적화된 프로그래밍을 할 수 있도록 애플이 개발한 기술


디스패치 대기열(Dispatch Queue)
- 작업을 연속적 혹은 동시에 진행하지만, 언제나 먼저 들어오면 먼저 나가는 순서로 실행
-  Serial Dispatch Queue는 한 번에 하나의 작업만을 실행, 해당 작업이 대기열에서 제외되고 새로운 작업이 시작되기 전까지 대기. 
-  반대로 Concurrent Dispatch Queue는 이미 시작된 작업이 완료될 때까지 기다리지 않고 가능한 많은 작업을 진행합니다. 디스패치 대기열(Dispatch Queue)은 GCD 기술 일부
-  디스패치 소스(Dispatch Source)는 특정 유형의 시스템 이벤트를 비동기적으로 처리하기 위한 C 기반 메커니즘. 특정 유형의 시스템 이벤트 정보를 캡슐화하고, 해당 이벤트가 발생할 때마다 특정 클로저(블록) 객체 혹은 기능을 디스패치 대기열(Dispatch Queue)에 전달합니다. 디스패치 소스(Dispatch Source)는 GCD 기술 일부입니다.
-  연산 대기열(Operation Queue)은 Concurrent Dispatch Queue와 동일하게 동작. 디스패치 대기열은 (FIFO - First in First out)순으로 작업 실행, 연산 대기열(Operation Queue)은 작업의 실행 순서를 결정할 때에 다른 요인들 고려. 연산 대기열(Operation Queue)은 디스패치 대기열(Dispatch Queue)과 매우 유사한 클래스입니다.

-  GCD와 연산 대기열 (Operation Queue) 차이점?
-  Operation Queue에서는 동시에 실행할 수 있는 연산(Operation)의 최대 수 지정 가능.
-  Operation Queue에서는 KVO(Key Value Observing)을 사용할 수 있는 많은 프로퍼티들이 있습니다.
-  Operation Queue에서는 연산(Operation)을 일시 중지, 다시 시작 및 취소를 할 수 있습니다.

-  언제 사용해야 할까요?
-  Operation Queue : 비동기적으로 실행되어야 하는 작업을 객체 지향적인 방법으로 사용하는 데 적합합니다. KVO(key Value Observing)를 사용해 작업 진행 상황을 감시하는 방법이 필요할 때도 적합합니다.
-  GCD : 작업이 복잡하지 않고 간단하게 처리하거나 특정 유형의 시스템 이벤트를 비동기적으로 처리할 때 적합합니다. 예를 들면 타이머, 프로세스 등의 관련 이벤트입니다.

Notification
- 등록된 노티피케이션에 노티피케이션 센터를 통해 정보를 전달하기 위한 구조체입니다.
- NotificationCenter: 등록된 옵저버에게 동시에 노티피케이션을 전달하는 클래스입니다. 
- NotificationCenter 클래스는 노티피케이션을 발송하면 노티피케이션 센터에서 메세지를 전달한 옵저버의 처리할 때까지 대기합니다. 즉, 흐름이 동기적(synchronous)으로 흘러갑니다. 노티피케이션을 비동기적으로 사용하려면 NotificationQueue를 사용하면 됩니다.
