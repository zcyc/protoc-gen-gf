# protoc-gen-gf

Generate [GoFrame](https://github.com/gogf/gf) business via proto file

## Introduction

- [protoc-gen-gf-api](./protoc-gen-gf-api) for api
- [protoc-gen-gf-controller](./protoc-gen-gf-controller) for controller
- [protoc-gen-gf-logic](./protoc-gen-gf-logic) for logic
- [protoc-gen-gf-model](./protoc-gen-gf-model) for model
- [protoc-gen-gf-client](./protoc-gen-gf-client) for client

## Workflow
- Generate the `proto` file by [mysql-to-proto](https://github.com/zcyc/mysql-to-proto) 
- Adjust the `services` and `messages` in the `proto`, please don't use the `PATCH` method, the generator will generate `CRUD` for it
- Generate the `CRUD` by `protoc-gen-gf`
- Copy the `files` to the `package` you want to place
- Adjust the fields of `Req` and `Res` in the `api`
- Adjust the fields of `Input` and `Output` in the `model`
- Adjust the functions in the `logic`
- Initialize your `DB` and `NoSQL` in the `cmd`
- Initialize your `logic` in the `cmd`
- Initialize your `controller` in the `cmd`
- `Run` and `Test`

## Environment

### Download clis

- [go 1.18+](https://golang.org/dl/)
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
go install github.com/zcyc/protoc-gen-gf/protoc-gen-gf-api@main \
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-controller@main \
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-logic@main \
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-model@main \
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-client@main
```

### Windows

#### PowerShell

```powershell
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && `
go install github.com/zcyc/protoc-gen-gf/protoc-gen-gf-api@main `
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-controller@main `
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-logic@main `
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-model@main `
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-client@main
```

#### CMD

```bash
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && ^
go install github.com/zcyc/protoc-gen-gf/protoc-gen-gf-api@main ^
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-controller@main ^
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-logic@main ^
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-model@main ^
           github.com/zcyc/protoc-gen-gf/protoc-gen-gf-client@main
```

## Usage

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

## Demo

[artcle](./example)

## Thanks

- [kratos](https://github.com/go-kratos/kratos/tree/main/cmd/protoc-gen-go-http)
