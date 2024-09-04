# 🚀 flyway
flyway 모듈은 데이터베이스 마이그레이션을 위한 테스크를 정의합니다.

## 관련 테스크 목록

언급된 테스크들 이외에는 기본적으로 비활성화되어 있습니다. 또한 운영 환경에서는 flywayMigration, flywayDomainMigration 테스크도 비활성화되어 있습니다.
- **flywayMigration** : 공통 데이터베이스 마이그레이션을 수행합니다.
- **flywayDomainMigration** : 특정 도메인에 대한 데이터베이스 마이그레이션을 수행합니다.
- generateDslJooq : flyway 테스크는 아니지만 flyway 마이그레이션에 강한 의존성을 가지고 있습니다. 

### 관련 테스크 실행 순서
1. **flywayMigration**
2. **flywayDomainMigration**
3. generateDslJooq 이후 compileJava를 실행하여 변경된 스키마에 대한 코드를 업데이트합니다.

## **flywayMigration**

`common` directory에 위치한 모듈들에 대한 데이터베이스 마이그레이션을 수행할 의도로 만들었습니다. 마이그레이션 스크립트는 `common/flyway/src/main/resources/db/migration` 디렉토리에 위치하며, Flyway가 이 디렉토리를 스캔하여 마이그레이션을 수행합니다.

## **flywayDomainMigration**

`domain` directory에 위치한 모듈들(특정 도메인에 대응하는 비즈니스 로직들)에 대한 데이터베이스 마이그레이션을 수행할 의도로 만들었습니다. 마이그레이션 스크립트는 `extra-resources/flyway/db/migration` 디렉토리에 위치(특정 도메인의 스크립트이기 때문에 모듈 외부에서 설정)하며, Flyway가 이 디렉토리를 스캔하여 마이그레이션을 수행합니다. flywayMigration이 실행된 후 실행됩니다. 그러므로 baselineOnMigrate* 옵션이 true로 설정되어 있습니다.

## **이슈**⚠️
flywayMigration과 flywayDomainMigration은 동일한 데이터베이스에 대해 마이그레이션을 수행합니다. 따라서 동일한 테이블에 대해 두 테스크 모두 마이그레이션 스크립트를 작성하면 충돌이 발생할 수 있습니다. 이를 방지하기 위해 flywayMigration과 flywayDomainMigration은 동일한 테이블에 대해 마이그레이션 스크립트를 작성하지 않도록 주의해야 합니다(혹은 flywayMigration 스크립트만 사용해야 합니다.).

***
- baseLineOnMigrate :스키마 히스토리 테이블이 없는 비어 있지 않은 스키마에 대해 마이그레이션을 실행할 때 자동으로 베이스라인을 호출할지 여부. 이 스키마는 마이그레이션을 실행하기 전에 베이스라인이 지정됩니다 . 그런 다음 위의 마이그레이션만 적용됩니다.
