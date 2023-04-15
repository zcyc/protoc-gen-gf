{{range .Methods}}
{{if eq .Method "GET"}}
type {{ .FunctionName }}Req struct {
	g.Meta `path:"{{.Path}}" method:"{{.Method}}"`
    {{range .Request.Fields }}{{.Name}} {{.Type}}
    {{end}}
}

type {{ .FunctionName }}Res struct {
	g.Meta `mime:"application/json"`
    {{range .Response.Fields }}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{ .Name}} {{ .Type}}
    {{end}}{{end}}{{end}}
}
{{else if eq .Method "POST"}}
type {{ .FunctionName }}Req struct {
	g.Meta `path:"{{.Path}}" method:"{{.Method}}"`
    {{range .Request.Fields }}{{if ne .Name "Id"}}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}} {{.Type}}
    {{end}}{{end}}{{end}}{{end}}{{end}}
}

type {{ .FunctionName }}Res struct {
	g.Meta `mime:"application/json"`
    {{range .Response.Fields }}{{ .Name}} {{ .Type}}
    {{end}}
}
{{else if eq .Method "PUT"}}
type {{ .FunctionName }}Req struct {
	g.Meta `path:"{{.Path}}" method:"{{.Method}}"`
    {{range .Request.Fields }}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}} {{.Type}}
    {{end}}{{end}}{{end}}{{end}}
}

type {{ .FunctionName }}Res struct {
	g.Meta `mime:"application/json"`
    {{range .Response.Fields }}{{ .Name}} {{ .Type}}
    {{end}}
}
{{else if eq .Method "DELETE"}}
type {{ .FunctionName }}Req struct {
	g.Meta `path:"{{.Path}}" method:"{{.Method}}"`
    {{range .Request.Fields }}{{.Name}} {{.Type}}
    {{end}}
}

type {{ .FunctionName }}Res struct {
	g.Meta `mime:"application/json"`
    {{range .Response.Fields }}{{ .Name}} {{ .Type}}
    {{end}}
}
{{end}}
{{end}}
