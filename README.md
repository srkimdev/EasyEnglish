## EngIng - 영어학습 및 일기
기존의 읽기 중심 영어 학습에서 벗어나, 영어로 직접 말하고 글을 쓰며 배울 수 있는 앱입니다.
<br/>

## 프로젝트 환경
- 개발 인원:
  - 1명
- 개발 기간:
  - 24.09.12 - 24.10.02 (약 3주)
- 최소 버전:
  - iOS 16.0
<br/>

## 기술 스택 및 라이브러리
- UI:
  - SwiftUI, Shufflelt, Lottie
- Architecture:
  - MVVM
- Reactive:
  - Combine
- Network:
  - Alamofire
- Database:
  - Realm
- Audio:
  - AvFoundation, Google Text-to-Speech  
<br/>

## 핵심 기능
- 주간 학습량 및 출석 체크
- 전체 달성률 확인
- 각 카테고리 별 문장 학습
- 문장 저장 / 음성 듣기
- 영어 일기 작성 / 저장 기능
- 문장 번역 및 음성 듣기
<br/>
 
## 핵심 기술 구현 사항
- network
  - Alamofire의 URLRequestConvertible 프로토콜을 채택한 TargetType 프로토콜과 이를 사용한 라우터 패턴을 정의해 다양한 네트워크 통신을 처리
  - Google TTS와 같이 시간이 오래 걸릴 수 있는 통신에 대응하기 위해 NetworkManager를 비동기로 구현
 
- Google Text-To-Speech
  - 텍스트의 문맥을 고려하고 억양, 속도 등을 조절하여 자연스럽게 구현한 WaveNet 음성 모델을 채택
  - 2.4kHz의 샘플링 주파수를 사용하여 높은 음질을 제공
 
- Architecture
  - Input/Output 패턴과 Combine을 사용하여 MVVM 패턴을 구현
 
- Database
  - 약 400개의 한국어/영어 문장 셋을 저장하고 카테고리-챕터-문장 테이블 간의 1대 다 구조 작업에 용이한 Realm을 사용
  - Realm Repository를 사용하여 여러 테이블에서 사용되는 데이터 처리 로직을 재사용
 
- Charts
  -
  
<br/>

## 트러블 슈팅
### 1. 상위뷰 아래 하위뷰(캘린더뷰, 다이어리뷰) 2개가 동일한 데이터를 처리하고 있는 경우
- 상황
  - 캘린더에서 날짜를 눌렀을 때 캘린더뷰에서는 눌린 날짜에 색을 다르게 하고 다이어리뷰에서는 해당 날짜의 일기를 Realm으로 부터 가져와서 보여주는 역할을 한다.

- 원인 분석
  - 캘린더뷰와 다이어리뷰는 동일한 Input

- 해결
  - 










