# protoc-gen-gf

Generate [GoFrame](https://github.com/gogf/gf) business via proto file

## Introduction

- [protoc-gen-gf-api](./protoc-gen-gf-api) for api
- [protoc-gen-gf-controller](./protoc-gen-gf-controller) for controller
- [protoc-gen-gf-logic](./protoc-gen-gf-logic) for logic
- [protoc-gen-gf-model](./protoc-gen-gf-model) for model
- [protoc-gen-gf-client](./protoc-gen-gf-client) for client

## Environment

### Download clis

- [go 1.16+](https://golang.org/dl/)
- [protoc](https://github.com/protocolbuffers/protobuf/releases)

### Download protos

1. Create directory `google` in `$GOPATH/src`
2. Copy `google/api` in [googleapis](https://github.com/googleapis/googleapis) to `$GOPATH/src/google`
3. Copy `src/google/protobuf` in [protobuf](https://github.com/protocolbuffers/protobuf) to `$GOPATH/src/google`
4. Now, it has `api` and `protobuf` in `$GOPATH/src/google`

## Install

### macOS & Linux

```shell
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && \
go install github.com/zcyc/protoc-gen-gf/protoc-gen-gf-api@latest \
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-controller@latest \
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-logic@latest \
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-model@latest \
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-client@latest
```

### Windows

#### PowerShell

```powershell
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && `
go install github.com/zcyc/protoc-gen-gf/protoc-gen-gf-api@latest `
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-controller@latest `
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-logic@latest `
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-model@latest `
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-client@latest
```

#### CMD

```bash
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && ^
go install github.com/zcyc/protoc-gen-gf/protoc-gen-gf-api@latest ^
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-controller@latest ^
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-logic@latest ^
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-model@latest ^
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-client@latest
```

## Usage

Demo: [protoc-gen-gf-example](./example)

### macOS & Linux

```shell
protoc -I ./api -I $GOPATH/src \
       --go_out ./api --go_opt=paths=source_relative \
       --gf-api_out ./api --gf-api_opt=paths=source_relative \
       --gf-controller_out ./api --gf-controller_opt=paths=source_relative \
       --gf-logic_out ./api --gf-logic_opt=paths=source_relative \
       --gf-model_out ./api --gf-model_opt=paths=source_relative \
       --gf-client_out ./api --gf-client_opt=paths=source_relative \
       ./api/v1/article.proto
```

### Windows

#### PowerShell

```powershell
protoc -I ./api -I $env:GOPATH/src `
       --go_out ./api --go_opt=paths=source_relative `
       --gf-api_out ./api --gf-api_opt=paths=source_relative `
       --gf-controller_out ./api --gf-controller_opt=paths=source_relative `
       --gf-logic_out ./api --gf-logic_opt=paths=source_relative `
       --gf-model_out ./api --gf-model_opt=paths=source_relative `
       --gf-client_out ./api --gf-client_opt=paths=source_relative `
       ./api/v1/article.proto
```

#### CMD

```bash
protoc -I ./api -I %GOPATH%/src ^
       --go_out ./api --go_opt=paths=source_relative ^
       --gf-api_out ./api --gf-api_opt=paths=source_relative ^
       --gf-controller_out ./api --gf-controller_opt=paths=source_relative ^
       --gf-logic_out ./api --gf-logic_opt=paths=source_relative ^
       --gf-model_out ./api --gf-model_opt=paths=source_relative ^
       --gf-client_out ./api --gf-client_opt=paths=source_relative ^
       ./api/v1/article.proto
```

## Convention

```protobuf
service Blog {
  rpc GetArticles(GetArticlesRequest) returns (GetArticlesResponse) {
    option (google.api.http) = {
      get: "/v1/articles"
    };
  }
}
```

You can use [mysql-to-proto](https://github.com/zcyc/mysql-to-proto) to generate proto file

## Thanks

- [kratos](https://github.com/go-kratos/kratos/tree/main/cmd/protoc-gen-go-http)
