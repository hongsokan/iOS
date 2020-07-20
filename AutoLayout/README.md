## iOS AutoLayout 완벽 가이드 - 실무 프로젝트를 위한 실전강의 [(인프런 강의)](https://www.inflearn.com/course/autolayout/)


### 섹션1. Basic - 오토레이아웃 핵심기능 완벽정리

Basic_1_Constraints_1
- Xcode 사용법
- 스토리보드에서 Constraints 주기
- Trailing, Leading, Top, Bottom
- Width, Height

Basic_2_iPhone_X_SafeArea
- iPhoneX 부터 노치 디자인에 맞춰 safe area 적용
- 세로모드에서는 top 과 bottom, 가로모드에서는 left, right(좌우 대칭) 와 bottom(홈버튼 제스처)
- view.safeAreaInsets
- view.safeAreaGuide
- safe area를 무시하고 화면에 꽉 채우고 싶다면? super view 기준으로 화면 꽉 채우면 된다. (특별한 경우만..)
- 비디오 컨텐츠 같은 경우는 디스플레이를 가득 채워야 한다. (애플 가이드)

Basic_3_Constraints_2
- Resolve Auto Layout Issues (인터페이스 빌더)
- Reset to Suggested Constraints : 시스템이 설정해주는 값은 원치 않는 모습인 경우가 많아 사용하지 않는 것이 좋다
- Clear Constraints : 뷰의 모든 제약 삭제
- Add New Constraints : 크기와 위치를 제대로 설정하지 않으면 오류
- Align : 여러 뷰들을 정렬, Horizontally in Container, Vertically … (super view 기준으로 정렬)

Basic_4_Constraints_Equal_1
- 여러 뷰들을 구성하려면 알아야 하는 것들
- 서로 간격만 설정하는 것이 아니라 크기도 설정해야 된다
- Equal Widths, 중복된 제약은 알아서 처리된다

Basic_5_Constraints_Equal_2
- 2가지 크기와 위치가 설정된 뷰 사이에 있는 하나의 뷰는 크기 설정 안하고 관계만 설정해도 된다.(?)

Basic_6_Constraints_Equal_3
- 여러 오브젝트를 좀 더 정교하게 설정하려면? 
- 하나의 오브젝트에 Equals 값을 더 주는 만큼 커진다

Basic_7_Align
- 2개의 크기가 다른 View 정렬 (Align)
- Leading & Top Edges : 왼쪽 위로 겹치게 정렬
- Trailing & Bottom Edges : 오른쪽 아래로 겹치게 정렬
- Container 는 super view 기준으로 정렬
- Horizontal Centers, Vertical Centers : 다른 뷰 기준으로 수평, 수직 정렬
- 역시 Equals 값을 상수로 추가하면 세부 위치를 조정할 수 있다

Basic_8_Multiplier_1
- 상단 status bar 간격 20
- iPhoneX 는 landscape 은 safe area 고려하여 좌우, 아래 부분 간격 필요
- multiplier 는 비율 (좌표 0 에서 시작하는 값을 multipier 하여도 그대로 0)
- 상수 값을 부여하고 multiplier 하면 : 상수값 * multiplier (ex. Leading 시작하는 위치 * multiplier) 
- Trailing, Bottom 같은 경우 끝나는 지점. multiplier 값을 나누면 끝나는 위치의 좌표. 

Basic_9_Multiplier_2
- 2개의 뷰 Equal Height 에 multiplier 를 지정하여 2:1, 10:1 비율로 지정할 수 있다
- centerX * multiplier = x 위치
- 비율에 맞춰 화면 구성 가능 (centerX * 0.5 multiplier)

Basic_10_Multiplier_3
- 배경 이미지 화면에 꽉 채우려면? Safe area 기준이 아닌 superview 기준으로 화면 채우면 된다
- Content Mode : 이미지 같은 경우 Scale to Fit 보다 Aspect Fill 로 설정하면 비율이 유지가 된다

Basic_11_Hugging_priority
- Priority? 우선순위 정하는 것. 우선순위 높은 오브젝트의 크기나 위치 먼저 정해짐
- 우선순위 높은 오브젝트 때문에 다른 오브젝트에 영향을 줄 수도 있으니 주의
- Hugging priority : 1000 인 경우 그 오브젝트는 가장 높은 우선순위를 갖게 된다
- Hugging은 고유 사이즈의 최대 크기에 제한을 두는 것 (compression resistance는 최소 크기에 제한)

Basic_12_compression_resistance
- compression resistance는 최소 크기에 제한, (작게 압축시키는 동작에 저항하는 것?)
- Label 의 Line Break 는 텍스트가 길어질 경우 어떤 부분을 생략할지 등을 설정할 수 있다.
- 중요한 오브젝트의 hugging priority 는 높게, 덜 중요한 오브젝트의 compression resistance는 낮게!

Basic_13_priority_constraint
- Priority 설정은 hugging, resistance 2가지
- 1000 은 최대값, 가장 높은 우선순위

Basic_14_Rotation
- Vary for Traits: 선택된 아이폰 기종, orientation 에 따라 달라진다
- 회전에 따라 화면 구성을 다르게 하고 싶다면 Vary for Traits 사용하면 된다
- 제일 큰 아이폰일 때만 화면 구성을 다르게 적용할수도 있다

Basic_15_ScrollView
- 갤러리뷰, 이미지가 큰 경우, 컨텐츠가 많은 경우 등
- 여러 뷰들을 하나의 뷰로 묶고, 스크롤뷰로 감싸주는 식으로 사용
- 가장 큰 기기 기준으로 스크롤뷰를 구성하면, 화면이 작은 기기에서 스크롤뷰가 동작

Basic_16_Margin
- 선택한 오브젝트에서 안쪽에 해당하는 개념
- 하나의 뷰에 또 다른 뷰를 추가하고, 상하좌우 간격 모두 0 을 주고 Constrain to margins 체크하면 8 간격이 생긴다
- 바깥에 있는 뷰를 기준으로 마진을 설정한다, Layout Margins 에서 Fixed 로 설정하여 마진 값을 수정할 수 있다

Basic_17_StackView
- Horizontal, Vertical
- Alignment : Fill, Leading, Center, Trailing
- Distribution : Fill, Fill Equally, Fill Proportionally, Equal Spacing, Equal Centering

Basic_18_Button_1_Inset
- Button의 autolayout 설정, 기본적으로 위아래 간격이 있다. (Label 같은 경우 텍스트 크기와 동일하게 크기가 적용된다)
- Button은 Inset을 설정할 수 있다. (사용자가 터치할 수 있게 여유있게 설정)
- Width, Height 자체를 크게 잡을 수도 있지만, 세부적인 안쪽 여백(Inset)을 설정할 수 있다
- Editor 에서 Size to Fit Content 적용 (단축키 cmd =)

Basic_19_Image_Resolution
- 이미지 해상도 : 레티나 디스플레이, 2x, 3x (HIG의 Icons and Images 기종마다 2x, 3x 다른 점 참고)
- 표준 해상도 이미지 비율 1x, 고해상도 이미지 배율은 2x, 3x (이미지 100x100 픽셀은 1x, 200x200 2x, 300x300 3x)

Basic_20_Button_2_Inset
- 이미지와 버튼 같이 사용하는 경우 (버튼 안에 이미지)
- 버튼 안에 이미지를 넣는 경우, 해당 이미지의 크기를 바꾸기는 어렵다. (애초에 알맞은 크기의 이미지 필요)
- Title Insets, Image Insets : 내부 여백 주는 것, 전체 오브젝트의 크기가 저절로 조절되는 것이 아니다
- Content Insets : 오브젝트 자체 크기
- Inset 값은 - 도 가능하다

Basic_21_AutoLayout_Code_Anchor_1
- code로 오브젝트 추가
- 버튼 초기화 및 변수 추가 -> 타이틀 등 세부 설정 -> self.view.addSubview
- 크기나 위치까지 추가해야 된다 (Superview 기준으로 설정)
- translatesAutoresizingMaskIntoConstraints = false
- .isActive = true 까지

Basic_22_AutoLayout_Code_Anchor_2
- iPhoneX 이후 safeAreaLayoutGuide 기준으로 constraint 설정해야 된다



### 섹션2. Calculator - 계산기 앱을 활용한 스택뷰 마스터

Calc_StackView_1
- 계산기 Layout 구성
- 위에는 결과를 보여줄 Label, 아래는 버튼들을 구성하는 하나의 뷰
- 아래 뷰의 버튼들은 한 줄씩 Stack View 로 묶어준다
- 각 스택뷰는 Alignment는 Fill, Distribution은 Fill Equally에 Spacing 10으로
- 가장 아래 스택뷰는 버튼이 2개, Distribution을 Fill
* 예제에서 가장 아래 스택뷰에서 마지막 뷰 설정 시 Equal Widths 설정이 되지 않아 Center Horizontally 로 수정

Calc_StackView_2_Code
- 버튼 UI 라운딩 처리 같은 경우 인터페이스 빌더 Attributes에 없기 때문에 코드로 작성해야 된다
- resultLabel 같은 경우 resultLabel.layer.masksToBounds 값을 True로 해줘야 cornerRadius 값이 적용된다
- resultLabel.clipsToBounds 도 같은 기능
- 화면이 다 정해지기 전에 호출되는 viewDidLoad() 함수에서 화면을 구성하면 정확하지 않을 수 있다
- viewDidAppear() 에서 화면 구성하는 것이 좋다
* 버튼이 정사각형이 아니라서 원이 찌그러짐

Calc_StackView_3_Nested
- 버튼을 정사각형으로 먼저 수정, Aspect Ratio 추가하면 해당 버튼의 가로세로 비율 설정할 수 있음
- Aspect Ratio를 1:1 비율로 설정하고(1만 입력해도 됨), Distribution을 Equal Spacing으로 설정
- 마지막 스택뷰 같은 경우, 마지막 버튼은 다른 버튼들과 동일함, aspect ratio 1:1 설정
- 마지막 스택뷰의 첫번째 뷰는 Trailing 지점을 바로 위 스택 뷰의 Trailing 과 맞추면 된다 (Trailing Edges)
- 그리고 스택뷰들 Vertical 간격도 추가하려면? 다시 하나의 스택뷰로 감싸준다 (그전에 각 스택뷰의 위아래 간격 삭제해준다)
- 이제 스택뷰들의 가로세로 비율이 맞춰진 것. Vertical 간격 추가하는 과정에서 Trailing Edges 설정이 지워질 수 있으므로 다시 추가

Calc_StackView_4_Error_Solution
- 기종마다 크기가 다름
- Top, Bottom 같은 경우 priority를 낮춰서 활용할 수 있다
- resultLabel도 priority를 낮춰서 가변적으로(기종마다 다르게) 화면에 보여줄 수 있다
- Hugging, Resistance까지 추가하면 좀 더 안정적으로 오브젝트들을 화면에 나타낼 수 있다



### 섹션3. Dynamic Font - 올레 인증서를 통한 동적 텍스트 변환

Cert_1_Dynamic_Font
- 실습 자료에 있는 Cert_Sample 기준으로 텍스트의 동적 크기 및 위치 변환이 어떻게 구현되는지 알아본다
- Cert_BG 이미지는 1009 x 1438 픽셀 크기, 2x, 3x 파일이 따로 있는 것도 아님
- 먼저 imageview 스토리보드에 하나 올리고, Scale To Fill, 좌우 간격 20, Vertically in container 정렬
- Scale To Fill 은 비율이 달라져도 원본 크기 유지, 좌우 간격을 20으로 주어 폭은 좁아졌지만 높이는 그대로
- Aspect Fit 해당하는 크기를 넘어서지 않으면서, Constraint 값도 유지, 비율도 유지
- 여기에 Aspect Ratio 제약을 새로 추가하여, 비율을 1009 x 1438로 바꾸면 원본 비율과 같게 유지하게 된다

- 기종마다 텍스트 위치가 다르게 위치
- 다시 이미지와 레이블 추가하여 뷰로 감싸준다
- 이미지를 뷰에 꽉 차게, 뷰의 비율을 이미지 원본인 1009 x 1438로 설정
- 추가한 레이블을 top, bottom 을 뷰에 딱 맞게, vertically 정렬까지, 그리고 bottom multiplier 0.35 쯤이 원하는 위치
- 텍스트 위치를 잡으려면 부모뷰로 감싸준 다음, 비율로 위치를 조절하면 (여기선 multiplier 0.35) 된다

Cert_2_Dynamic_Font
- Autoshrink : Minimum Font Scale(비율), Minimum Font Size(크기) 지정할 수 있음
- “공인인증서” 레이블을 “Cert_BG” 이미지뷰와 Equal Widths 설정 이후, 비율을 0.35 정도로 맞춤
- “홍길동” 이름이 들어가는 레이블도 이미지뷰와 같이 선택하여 top, bottom, vertical 을 맞춘다, bottom 비율은 0.71 정도
- 이름 레이블도 Minimum Font Size 20 정도, 이미지뷰와 Equal Widths 설정 이후 비율은 0.28 정도
- 동일한 방식으로 “발급자” 레이블 추가 (“발급자” 레이블은 이미지뷰와 bottom 비율이 0.9 , “종류”는 1.0, “만료일”은 1.1, 수직 정렬)
- “종류” 레이블 같은 경우 중앙에 위치하는 것이 아닌 바로 위에 위치한 “발급자” 레이블 왼쪽에 맞춰 정렬 
* 순서 : 하나의 뷰로 이미지와 레이블을 감싼다 -> 이미지에 맞춰 레이블 정렬 (top, bottom, vertical) -> 이미지뷰와 Equal Widths
-> 핵심은 이미지뷰와 안에 포함될 레이블 모두 하나의 뷰로 감싸주고, 레이블은 이미지뷰에 맞춰서 위치를 조절



### 섹션4. Custom Keyboard - 나만의 보안 키보드 만들기

Custom_Keyboard_1
- 시스템에서 제공하는 키보드 말고 커스텀 키보드 만들어보기 (은행 앱, 계산기 등에서 많이 사용)
- xib 활용

Custom_Keyboard_2
- CustomKeyboard UIView 추가, 새로운 Storyboard는 Controller만 추가 가능하기 때문에 View 파일 추가 (xib파일)
- xib는 Controller가 아닌 버튼 등의 오브젝트들을 추가하고 싶을 때 사용
- 커스텀 키보드를 위한 버튼 추가, 스택뷰로 구성
- 화면 구성 이후 class 연결 (class CustomKeyboard: UIView)
- Bundle.main.loadNibNamed() 로 xib파일 불러온 뒤에, 배열 형태로 저장되어 있는 것들 중 원하는 오브젝트 불러온다
- 스택뷰로 구성하여 중간에 추가로 비어있는 버튼을 추가하면 보안 키보드와 같은 모습 (user interactions enabled 체크 해제)
- firstTextField.inputView =  myKeyboardView (여기서 inputView로 들어갔기 때문에 크기가 어떻든 기본 키보드 크기)

Custom_Keyboard_3
- CustomKeyboard 클래스에서 키보드 입력 받는 이벤트 추가
- Delegate 패턴 사용. (delegate를 위한 프로토콜 -> delegate 변수를 통해 데이터 전송 -> VC에서 위임 받고 데이터 받으면 끝) 
- firstTextField.text = str , 이제 버튼을 누르면 TextField에 표시



### 섹션5. Expand Cell - 테이블뷰 셀의 동적 높이 변환 이해

Expand_Cell_1
- 스토리보드 테이블뷰, 테이블셀 추가, 셀 구성 (이미지뷰, title Label, description Label)
- 이미지뷰 크기 및 위치 조정, 타이틀은 이미지뷰에 Vertical Centers 정렬, description 위치 모두 고정
- Cell Identifier 지정 (expandCell_ID), class ExpandCell 추가하여 스토리보드와 연결
- Cell 내부 IBOutlet descriptionLabel 스토리보드에 연결
- 테이블뷰 프로토콜 DataSource, Delegate 추가, 스토리보드에 연결, 세부 구현까지

Expand_Cell_2
- 간단한 Model 작성
- 모델 배열로 추가
- didSelectRowAt으로 선택한 row 커지는 효과 추가

Expand_Cell_3_Performance
- Cell 이 커질 때 효과가 튀는 현상
- 테이블뷰 셀에서 Autolayout Performance 문제 해결 방안 4가지
1. heightForRowAt 에서 정확한 높이 지정
2. tableView.reloadData() // 어느 정도 해결
3. tableView.estimatedSectionHeaderHeight = 0 , tableView.estimatedSectionFooterHeight = 0 // 어느 정도 해결
4. 애니메이션 효과 없게, 확실히 해결
<pre>
<code>
        UIView.setAnimationsEnabled(false)
        // 선택한 row의 데이터만 갱신
        tableView.reloadRows(at: [indexPath], with: .automatic)
        UIView.setAnimationsEnabled(true)
</code>
</pre>
