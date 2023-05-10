{{range .Methods}}
{{if eq .Method "GET"}}
type {{ .FunctionName }}Input struct {
    {{range .Request.Fields }}{{.Name}} {{.Type}}
    {{end}}
}

type {{ .FunctionName }}Output struct {
    {{if .IsListMethod}}List  []interface{} `json:"list"`
	Total int           `json:"total"`
    {{else}}{{range .Response.Fields }}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{ .Name}} {{ .Type}}
    {{end}}{{end}}{{end}}{{end}}
}
{{else if eq .Method "POST"}}
type {{ .FunctionName }}Input struct {
    {{range .Request.Fields }}{{if ne .Name "Id"}}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}} {{.Type}}
    {{end}}{{end}}{{end}}{{end}}{{end}}
}
{{else if eq .Method "PUT"}}
type {{ .FunctionName }}Input struct {
    {{range .Request.Fields }}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}} {{.Type}}
    {{end}}{{end}}{{end}}{{end}}
}
{{else if eq .Method "DELETE"}}
type {{ .FunctionName }}Input struct {
    {{range .Request.Fields }}{{.Name}} {{.Type}}
    {{end}}
}
{{end}}
{{end}}
