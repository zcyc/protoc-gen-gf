{{range .Methods}}
{{if eq .Method "PATCH"}}
type List{{.FunctionName}}Req struct {
	g.Meta `path:"{{.Path}}" method:"GET"`
    Page     int    `json:"page"`
    PageSize int    `json:"page_size"`
    Keyword  string `json:"keyword"`
}

type List{{.FunctionName}}Res struct {
	g.Meta `mime:"application/json"`
    Total int `json:"total"`
    List  any `json:"list"`
}

type Get{{.FunctionName}}Req struct {
	g.Meta `path:"{{.Path}}" method:"GET"`
    Id string `json:"id"`
}

type Get{{.FunctionName}}Res struct {
	g.Meta `mime:"application/json"`
    {{range .Response.Fields }}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}} {{.Type}}
    {{end}}{{end}}{{end}}
}

type Create{{.FunctionName}}Req struct {
	g.Meta `path:"{{.Path}}" method:"{{.Method}}"`
    {{range .Request.Fields }}{{if ne .Name "Id"}}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}} {{.Type}}
    {{end}}{{end}}{{end}}{{end}}{{end}}
}

type Create{{.FunctionName}}Res struct {
	g.Meta `mime:"application/json"`
}

type Update{{.FunctionName}}Req struct {
	g.Meta `path:"{{.Path}}" method:"PUT"`
    {{range .Request.Fields }}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}} {{.Type}}
    {{end}}{{end}}{{end}}{{end}}
}

type Update{{.FunctionName}}Res struct {
	g.Meta `mime:"application/json"`
}

type Delete{{.FunctionName }}Req struct {
	g.Meta `path:"{{.Path}}" method:"DELETE"`
    Id string `json:"id"`
}

type Delete{{.FunctionName}}Res struct {
	g.Meta `mime:"application/json"`
}
{{else}}
type {{.FunctionName}}Req struct {
	g.Meta `path:"{{.Path}}" method:"{{.Method}}"`
    {{range .Request.Fields }}{{.Name}} {{.Type}}
    {{end}}
}

type {{.FunctionName}}Res struct {
	g.Meta `mime:"application/json"`
    {{range .Response.Fields}}{{.Name}} {{.Type}}
    {{end}}
}
{{end}}
{{end}}
