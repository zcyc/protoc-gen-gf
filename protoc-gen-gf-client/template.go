package main

import (
	"bytes"
	_ "embed"
	"fmt"
	"html/template"
	"strings"
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

// hasPathParams 是否包含路由参数
func (m *methodDesc) hasPathParams() bool {
	paths := strings.Split(m.Path, "/")
	for _, p := range paths {
		if len(p) > 0 && (p[0] == '{' && p[len(p)-1] == '}' || p[0] == ':') {
			return true
		}
	}
	return false
}

// initPathParams 转换参数路由 {xx} --> :xx
func (m *methodDesc) initPathParams() {
	paths := strings.Split(m.Path, "/")
	for i, p := range paths {
		if len(p) > 0 && (p[0] == '{' && p[len(p)-1] == '}' || p[0] == ':') {
			paths[i] = ":" + p[1:len(p)-1]
		}
	}
	m.Path = strings.Join(paths, "/")
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

// InterfaceName service interface name
func (s *serviceDesc) InterfaceName() string {
	// return s.Name + "HTTPServer"
	return s.Name
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

// LowerServiceName lower service name
func (s *serviceDesc) LowerServiceName() string {
	return strings.ToLower(s.Name)
}
