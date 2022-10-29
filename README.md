# protoc-gen-gf

从 protobuf 文件中生成使用 goframe 的 http 服务

## 介绍

- [protoc-gen-gf-api](https://github.com/zcyc/protoc-gen-gf-api) 用来生成标准路由
- [protoc-gen-gf-controller](https://github.com/zcyc/protoc-gen-gf-controller) 用来生成控制器
- [protoc-gen-gf-logic](https://github.com/zcyc/protoc-gen-gf-logic) 用来生成业务逻辑
- [protoc-gen-gf-client](https://github.com/zcyc/protoc-gen-gf-client) 用来生成接口调用方法

## 环境

### 安装二进制

1. [go 1.16+](https://golang.org/dl/)
2. [protoc](https://github.com/protocolbuffers/protobuf/releases)
3. [protoc-gen-go](https://github.com/protocolbuffers/protobuf-go/releases)

### 下载 proto

1. 在 `$GOPATH/src` 中创建 `google` 目录
2. 将 [googleapis](https://github.com/googleapis/googleapis) 项目的 `google/api` 目录下载到 `$GOPATH/src/google` 中
3. 将 [protobuf](https://github.com/protocolbuffers/protobuf) 项目的 `src/google/protobuf` 目录下载到 `$GOPATH/src/google` 中
4. 此时 `$GOPATH/src/google` 中应该有 `api` 和 `protobuf` 两个文件夹

## 安装

```bash
go install github.com/zcyc/protoc-gen-gf-api@latest
go install github.com/zcyc/protoc-gen-gf-controller@latest
go install github.com/zcyc/protoc-gen-gf-logic@latest
go install github.com/zcyc/protoc-gen-gf-client@latest
```

## 使用

示例项目： [protoc-gen-gf-example](https://github.com/zcyc/protoc-gen-gf-example)

### macOS & Linux

```bash
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
```bash
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

## proto 约定

### method 的命名要用驼峰的"操作+资源"

生成代码时，操作通过以下规则映射到 http 动作，资源作为 http 路径

- `GET, FIND, QUERY, LIST, SEARCH` -> GET
- `POST, CREATE` -> POST
- `PUT, UPDATE` -> PUT
- `DELETE` -> DELETE

```protobuf
service Blog {
  rpc CreateArticle(Article) returns (Article) {}
  // 函数的操作是 Create，映射到 POST 动作，Article 为路径
  // 所以最终生成的 http 路由是 post: /article
}
```

### 使用 option (google.api.http) 指定 http 路由

```protobuf
service Blog {
  rpc GetArticles(GetArticlesRequest) returns (GetArticlesResponse) {
    option (google.api.http) = {
      get: "/v1/articles"
      // 使用 additional_bindings 为一个 rpc 方法指定多个 http 路由
      additional_bindings {
        get: "/v1/author/{author_id}/articles"
      }
    };
  }
}
```

## 灵感来源
- [kratos](https://github.com/go-kratos/kratos/tree/main/cmd/protoc-gen-go-http)
