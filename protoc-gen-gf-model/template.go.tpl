{{range .Methods}}
{{if eq .Method "PATCH"}}
type List{{.FunctionName}}Input struct {
    Page     int
    PageSize int
    Keyword  string
}

type {{.FunctionName}}Output struct {
    List  any `json:"list"`
	Total int `json:"total"`
}

type Get{{.FunctionName}}Input struct {
    Id string
}

type Get{{.FunctionName}}Output struct {
    {{range .Response.Fields }}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{ .Name}} {{ .Type}}
    {{end}}{{end}}{{end}}
}

type Create{{.FunctionName}}Input struct {
    {{range .Request.Fields }}{{if ne .Name "Id"}}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}} {{.Type}}
    {{end}}{{end}}{{end}}{{end}}{{end}}
}

type Update{{.FunctionName}}Input struct {
    {{range .Request.Fields }}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}} {{.Type}}
    {{end}}{{end}}{{end}}{{end}}
}

type Delete{{.FunctionName}}Input struct {
    Id string
}
{{else}}
type {{.FunctionName}}Input struct {
}

type {{.FunctionName}}Output struct {
}
{{end}}
{{end}}
