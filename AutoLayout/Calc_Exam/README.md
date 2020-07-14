- [노션 바로가기](https://www.notion.so/Calculator-b27a96a3d7a54b448923b6219325a53c)

## Calculator - 계산기 앱을 활용한 스택뷰 마스터

### Calc_StackView_1
- 계산기 Layout 구성
- 위에는 결과를 보여줄 Label, 아래는 버튼들을 구성하는 하나의 뷰
- 아래 뷰의 버튼들은 한 줄씩 Stack View 로 묶어준다
- 각 스택뷰는 Alignment는 Fill, Distribution은 Fill Equally에 Spacing 10으로
- 가장 아래 스택뷰는 버튼이 2개, Distribution을 Fill
* 예제에서 가장 아래 스택뷰에서 마지막 뷰 설정 시 Equal Widths 설정이 되지 않아 Center Horizontally 로 수정

### Calc_StackView_2_Code
- 버튼 UI 라운딩 처리 같은 경우 인터페이스 빌더 Attributes에 없기 때문에 코드로 작성해야 된다
- resultLabel 같은 경우 resultLabel.layer.masksToBounds 값을 True로 해줘야 cornerRadius 값이 적용된다
- resultLabel.clipsToBounds 도 같은 기능
- 화면이 다 정해지기 전에 호출되는 viewDidLoad() 함수에서 화면을 구성하면 정확하지 않을 수 있다
- viewDidAppear() 에서 화면 구성하는 것이 좋다
* 버튼이 정사각형이 아니라서 원이 찌그러짐

### Calc_StackView_3_Nested
- 버튼을 정사각형으로 먼저 수정, Aspect Ratio 추가하면 해당 버튼의 가로세로 비율 설정할 수 있음
- Aspect Ratio를 1:1 비율로 설정하고(1만 입력해도 됨), Distribution을 Equal Spacing으로 설정
- 마지막 스택뷰 같은 경우, 마지막 버튼은 다른 버튼들과 동일함, aspect ratio 1:1 설정
- 마지막 스택뷰의 첫번째 뷰는 Trailing 지점을 바로 위 스택 뷰의 Trailing 과 맞추면 된다 (Trailing Edges)
- 그리고 스택뷰들 Vertical 간격도 추가하려면? 다시 하나의 스택뷰로 감싸준다 (그전에 각 스택뷰의 위아래 간격 삭제해준다)
- 이제 스택뷰들의 가로세로 비율이 맞춰진 것. Vertical 간격 추가하는 과정에서 Trailing Edges 설정이 지워질 수 있으므로 다시 추가

### Calc_StackView_4_Error_Solution
- 기종마다 크기가 다름
- Top, Bottom 같은 경우 priority를 낮춰서 활용할 수 있다
- resultLabel도 priority를 낮춰서 가변적으로(기종마다 다르게) 화면에 보여줄 수 있다
- Hugging, Resistance까지 추가하면 좀 더 안정적으로 오브젝트들을 화면에 나타낼 수 있다
