# Ecommerce MSA Backend

### 서비스 별 소스코드
`/api-xxx/sources`

### 도커 실행 설정
`~/docker-compose.yaml` 

### 빌드 명령어
`docker-compose up --build` 

### 설계 
1. 모든 서비스의 Header에 USER-TOKEN 정보가 들어가야된다.
2. CQRS(Command and Query Responsibility Segregation) 패턴 기반으로 조와 명령(이벤트 발생)을 구분하여 서비스 설계
   CUD 이벤트 발생 시 같은 서비스 도메인 DB가 붙어있는경우 직접 작업, 다른 서비스 도메인 DB에 작업해야되면 event 발생(consumer)
3. 본 프로젝트에서는 API GATEWAY 구성을 하지 않고 API 호출 관리가 되지 않아 다른서비스의 데이터 조회를 할 경우 CQRS VIEW를 구성하여 데이터에 접근한다.
   다른 서비스가 장애가 발생했을 때 CQRS VIEW를 통해 조회가 가능하도록 느슨한 관계 설정 

### 서비스
1. 사용자 서비스
2. 알람 서비스 
3. 상품 서비스 

## 기타 
사용 언어 : python  
사용 기술 : flask, sqlalchemy, mongodb, postgres, kafka  
