{{range .Methods}}
type {{ .FunctionName }}Req struct {
	g.Meta `path:"{{.Path}}" method:"{{.Method}}"`
    {{range .Request.Fields }}{{ .Name}} {{ .Type}}
    {{end}}
}

type {{ .FunctionName }}Res struct {
	g.Meta `mime:"application/json"`
    {{range .Response.Fields }}{{ .Name}} {{ .Type}}
    {{end}}
}
{{end}}

