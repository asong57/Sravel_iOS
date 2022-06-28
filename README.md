# Sravel 📷

<img src = "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fwkvc1%2FbtrFT2RVLqb%2F4nJh2XS7tIOZsuL2g2dPP0%2Fimg.png" width="15%" height="30%">

### 지도 기반 사진 공유 iOS 앱 프로젝트

<br />

## 🛠사용한 기술
### **MVVM-Clean Architecture**
<img src = "https://blog.kakaocdn.net/dn/ba6gfD/btrroXYwxjv/zz7KOvT1aJ2rGbKZNnxexK/img.png" width="30%" height="30%">

### **MVVM**
  - MVVM을 도입하여 프레젠테이션 로직, 비즈니스 로직을 UI로부터 확실하게 분리하도록 하였습니다.
  - 뷰컨트롤러와 뷰는 화면을 그리는 역할에만 집중하고 데이터 관리, 프레젠테이션 로직의 실행은 뷰모델에서 진행되도록 했습니다.
### **Clean Architecture**
  - ViewModel의 비즈니스 로직들을 UseCase에서, 네트워크나 데이터베이스에 대한 요청은 Repository로 분리해 각 레이어의 역할을 분명하게 나누었습니다.
  - Domain 레이어가 다른 레이어를 참조하지 않도록 Domain 레이어에는 Repository Protocol을 구성하고, DIContainer와 Coordinator패턴을 활용하여 의존관계 주입을 구현하였습니다.
### **Coordinator**
  - 화면 전환에 대한 로직을 ViewController로부터 분리하고 의존성 객체에 대한 주입을 외부에서 처리하도록 하기 위해 Coordinator를 사용했습니다.
### **Input/Output Modeling**
  - 뷰모델을 Input과 Output으로 구성하여 뷰의 이벤트들을 Input에 바인딩하고, 뷰에 보여질 데이터를 Output에 바인딩했습니다.
  
 <br />

## 팀원🌱🌱


|            개발(iOS)             |                 개발(AI)                  |                 디자인                  |                기획                 |
| :----------------------------------: | :---------------------------------------: | :-------------------------------------: | :---------------------------------: |
| [김송아](https://github.com/asong57) | [나영주](https://github.com/YoungjuNa-KR) | [류현지](https://github.com/RyuHyeonji) | [김유리](https://github.com/GlassK) |


<br />  
  
## 👒프로젝트 설명

**S**napshot + T**ravel** = **Sravel**

- 지도상에서 정확한 위치를 지정하고 카테고리, 해시태그, 한 줄 설명과 함께 사진을 업로드합니다. 
- 카테고리별로 사진을 조회할 수 있고, 추천 시스템 기반의 유사한 장소나 근처의 사진을 함께 보며 랜선 여행을 즐길 수 있습니다. 
- 마음에 드는 사진에 좋아요 표시를 해서 사용자 간 소통하고 기억해두고 싶은 장소를 저장할 수 있습니다. 
