# protoc-gen-gf

Generate goframe business via ProtoBuf

## Introduction

- [protoc-gen-gf-api](https://github.com/zcyc/protoc-gen-gf-api) for api
- [protoc-gen-gf-controller](https://github.com/zcyc/protoc-gen-gf-controller) for controller
- [protoc-gen-gf-logic](https://github.com/zcyc/protoc-gen-gf-logic) for logic
- [protoc-gen-gf-client](https://github.com/zcyc/protoc-gen-gf-client) for client

## Environment

### Download clis

1. [go 1.16+](https://golang.org/dl/)
2. [protoc](https://github.com/protocolbuffers/protobuf/releases)
3. [protoc-gen-go](https://github.com/protocolbuffers/protobuf-go/releases)

### Download protos

1. Create directory `google` in `$GOPATH/src`
2. Copy `google/api` in [googleapis](https://github.com/googleapis/googleapis) to `$GOPATH/src/google`
3. Copy `src/google/protobuf` in [protobuf](https://github.com/protocolbuffers/protobuf) to `$GOPATH/src/google`
4. Now, it has `api` and `protobuf` in `$GOPATH/src/google`

## Install

```bash
go install github.com/zcyc/protoc-gen-gf-api@latest
go install github.com/zcyc/protoc-gen-gf-controller@latest
go install github.com/zcyc/protoc-gen-gf-logic@latest
go install github.com/zcyc/protoc-gen-gf-client@latest
```

## Usage

Demo: [protoc-gen-gf-example](https://github.com/zcyc/protoc-gen-gf-example)

### macOS & Linux

```shell
protoc -I ./api -I $GOPATH/src \
 --go_out ./api --go_opt=paths=source_relative \
 --gf-api_out ./api --gf-api_opt=paths=source_relative \
 --gf-controller_out ./api --gf-controller_opt=paths=source_relative \
 --gf-logic_out ./api --gf-logic_opt=paths=source_relative \
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
 --gf-client_out ./api --gf-client_opt=paths=source_relative ^
 ./api/v1/article.proto
```

## Convention

### The method name must be `Action + Resource`, for example: `CreateUser`

When generated, `Action` will be mapped as http method according to the following rules, `Resource` will be used as http path

#### Rules
- `GET, FIND, QUERY, LIST, SEARCH` -> GET
- `POST, CREATE` -> POST
- `PUT, UPDATE` -> PUT
- `DELETE` -> DELETE

#### Example
```protobuf
service Blog {
  rpc CreateArticle(Article) returns (Article) {}
  // Action is Create, mapped to POST, Resource is User
  // So the http route is POST: /article
}
```

### You can use option (google.api.http) to set http method and path

```protobuf
service Blog {
  rpc GetArticles(GetArticlesRequest) returns (GetArticlesResponse) {
    option (google.api.http) = {
      get: "/v1/articles"
      // You can add multiple http routes using additional_bindings
      additional_bindings {
        get: "/v1/author/{author_id}/articles"
      }
    };
  }
}
```

## Thanks
- [kratos](https://github.com/go-kratos/kratos/tree/main/cmd/protoc-gen-go-http)
