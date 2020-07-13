## iOS AutoLayout 완벽 가이드 - 실무 프로젝트를 위한 실전강의 (인프런 강의)

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
