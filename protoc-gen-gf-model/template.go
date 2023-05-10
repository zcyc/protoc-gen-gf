package main

import (
	"bytes"
	_ "embed"
	"fmt"
	"html/template"
	"strings"
	"unicode"
)

//go:embed template.go.tpl
var tpl string

type serviceDesc struct {
	Name      string                 // Greeter
	FullName  string                 // helloworld.Greeter
	FilePath  string                 // api/helloworld/helloworld.proto
	Methods   []*methodDesc          // 方法列表
	MethodSet map[string]*methodDesc // 方法映射表
}

type methodDesc struct {
	// method
	Name         string
	OriginalName string
	HttpPathNum  int
	// message
	Request  *message
	Response *message
	// http
	HasPathVars  bool   // 是否有参数
	Path         string // HTTP 路径
	Method       string // HTTP 动作
	HasBody      bool
	RequestBody  string // 暂时不知道干啥的
	ResponseBody string // 暂时不知道干啥的
}

type message struct {
	Name   string
	Fields []*field
}

type field struct {
	Name string
	Type string
}

func (s *serviceDesc) execute() string {
	if s.MethodSet == nil {
		s.MethodSet = map[string]*methodDesc{}
		for _, m := range s.Methods {
			m := m
			s.MethodSet[m.Name] = m
		}
	}
	buf := new(bytes.Buffer)
	tmpl, err := template.New("http").Parse(strings.TrimSpace(tpl))
	if err != nil {
		panic(err)
	}
	if err := tmpl.Execute(buf, s); err != nil {
		panic(err)
	}
	return buf.String()
}

// FunctionName for func name
func (m *methodDesc) FunctionName() string {
	// 如果方法对应的接口数量大于0个就给方法名后面就上序号
	if m.HttpPathNum > 0 {
		return fmt.Sprintf("%s_%d", m.Name, m.HttpPathNum)
	} else {
		return m.Name
	}
}

// 小驼峰
func (s *serviceDesc) LowerServiceName() string {
	if len(s.Name) == 0 {
		return s.Name
	}
	firstChar := strings.ToLower(string(s.Name[0]))
	return firstChar + s.Name[1:]
}

// 横杠分割
func (s *serviceDesc) KebabServiceName() string {
	var result strings.Builder
	for i, char := range s.Name {
		if i > 0 && unicode.IsUpper(char) {
			result.WriteRune('-')
		}
		result.WriteRune(unicode.ToLower(char))
	}
	return result.String()
}

// 下划线
func (s *serviceDesc) SnakeServiceName() string {
	var result strings.Builder
	for i, char := range s.Name {
		if i > 0 && unicode.IsUpper(char) {
			result.WriteRune('_')
		}
		result.WriteRune(unicode.ToLower(char))
	}
	return result.String()
}

// isListMethod 判断是不是需要 list 接口
func (m *methodDesc) IsListMethod() bool {
	return strings.ToLower(m.Name)[0:4] == "list"
}
