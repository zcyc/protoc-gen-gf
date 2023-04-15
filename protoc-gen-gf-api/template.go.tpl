{{range .Methods}}
type {{ .FunctionName }}Req struct {
	g.Meta `path:"{{.Path}}" method:"{{.Method}}"`
    {{range .Request.Fields }}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}} {{.Type}}
    {{end}}
    {{end}}
    {{end}}
    {{end}}
}

type {{ .FunctionName }}Res struct {
	g.Meta `mime:"application/json"`
    {{range .Response.Fields }}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{ .Name}} {{ .Type}}
    {{end}}
    {{end}}
    {{end}}
}
{{end}}

