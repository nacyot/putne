# Putne
## Project badge
[![Code Climate](https://codeclimate.com/github/nacyot/putne.png)](https://codeclimate.com/github/nacyot/putne)
[![Build Status](https://travis-ci.org/nacyot/putne.png?branch=master)](https://travis-ci.org/nacyot/putne)
[![Coverage Status](https://coveralls.io/repos/nacyot/putne/badge.png)](https://coveralls.io/r/nacyot/putne)
[![Dependency Status](https://gemnasium.com/nacyot/putne.png)](https://gemnasium.com/nacyot/putne)

## Introduction
Putne는 코드 매트릭스 자동화 서버입니다. 

여러 언어에는 다양한 정적 코드 분석 도구들이 존재합니다. Ruby에도 이미 다양한 오픈소스 프로그램들이 존재합니다. Complexity를 분석해주는 flog와 saikuro, 코드 중복을 찾아주는 flay, Code smell을 찾아주는 Roodi, Cane, 이외에도 저장소의 커밋을 분석해 문제가 발생할 소지가 높은 부분을 찾아주는 Churn이나 Bugspot 같은 프로그램이 있습니다.

이러한 도구들을 코드 퀄리티를 관리할 수 있게 도와주고, 하나의 지표로서 현재 코드 상태를 나타내줍니다. 이러한 도구들은 유용하지만 프로그래밍 과정에서 이러한 도구들을 하나 하나 사용하고 정리하는 것은 매우 번거로운 일입니다. Putne는 이러한 번거러움을 줄여보고자 개발된 코드 매트릭스 자동화 서버로, SCM에 작업내용이 push되면 자동으로 현재 코드를 분석해주고 이 결과를 보고해줍니다. 또한 지속적으로 분석 결과가 관리해 코드 퀄리티의 이력을 쫓아갈 수 있게 도와주며, 다양한 시각화를 통해 여러 관점에서 프로젝트를 탐색할 수 있게 도와줍니다. 이러한 분석 결과는 웹 서버를 통해 보다 쉽게 확인할 수 있습니다.

## Feature
Putne는 현재 아래와 같은 코드 메트릭스를 지원합니다.

* Metric_fu
* Complexity : Flog, Saikuro
* Code smell : Reek, Roodi
* Duplication : Flay
* Churn : Churn
* Rails Best Practice 

아래와 같은 코드 메트릭스를 추가적으로 지원할 예정입니다.

* ...

현재 공식적으로 SCM은 Git을 지원하며 언어는 Ruby를 지원합니다. 레포트 부분을 모듈화 과정에 있으며 추후 다른 언어에서 분석한 결과도 지원할 예정입니다.

### Report

### Visualization

## Installation
Putne를 설치하기 위해서는 아래와 같은 것들이 설치되어 있어야 합니다.

* Ubuntu or mac (or similar system)
* Ruby 1.9.3+
* Rails 4
* Bundler
* Redis (Sidekiq)
* Postgresql
* Homebrew (mac)

설치는 다음과 아래 과정으로 이루어집니다.

먼저 putne 사용에 필요한 모듈을 설치합니다.

```
# ubuntu
sudo apt-get install libicu-dev postgresql redis nodejs npm -y
npm install bower

# mac
brew install ... 
```

다음으로 Putne 어플리케이션을 github에서 clone 하고 bundle을 통해 필요한 gem들을 설치합니다.

```
git clone https://github.com/nacyot/putne.git
cd putne
bundle install
bower install
```

다음으로 데이터베이스를 설정해줍니다. Putne에서 사용할 사용자를 등록하고 데이터베이스 생성권한을 부여합니다.

```
# ubuntu
sudo -u postgres psql -d template1

CREATE USER <USERNAME> WITH ENCRYPTED PASSWORD '<PASSWORD>';
CREATE DATABASE <DATABASE_NAME> ENCODING 'UTF8' OWNER <USERNAME>; 
ALTER USER <USERNAME> CREATEDB

# mac
psql -d template1

CREATE USER <USERNAME> WITH ENCRYPTED PASSWORD '<PASSWORD>';
CREATE DATABASE <DATABASE_NAME> ENCODING 'UTF8' OWNER <USERNAME>; 
ALTER USER <USERNAME> CREATEDB

```

다음으로 먼저 레일스의 데이터베이스 설정 샘플 파일을 복사하고, 자신의 환경에 맞도록 설정해줍니다. 추가적으로 데이터베이스를 초기화 해줍니다.

```
cp config/database.yml.sample config/database.yml
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

프로그램을 실행합니다.

```
# sidekiq 서버 실행
bundle exec sidekiq -e development -c 1 

# Putne 서버를 실행합니다.
bundle exec rails server
```

## Documentation
http://rubydoc.info/github/nacyot/putne/

## Usage
```
# Default 아이디 / 패스워드
id : admin@example.com
password : abcd1234
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
