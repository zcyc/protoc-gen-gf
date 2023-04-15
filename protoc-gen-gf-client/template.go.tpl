{{range .Methods}}
{{if eq .Method "GET"}}
func {{.FunctionName}} (ctx context.Context, in *{{.FunctionName}}Input) (out *{{.FunctionName}}Output, err error) {
	server, _ := g.Cfg().Get(ctx, "serverUri.{{$.LowerServiceName}}Server")
	res, err := g.Client().{{.Method}}(
		ctx,
		fmt.Sprintf("%s{{.Path}}", server),
		g.Map{
			{{if .IsListMethod}}"page": in.Page,
			"page_size": in.PageSize,
			{{else}}"id": in.Id,
			{{end}}
		},
	);
	if err != nil {
		g.Log().Errorf(ctx, "s{{$.Name}}Client {{.FunctionName}} Client error %v", err)
		return nil, err
	}

	if err := res.Struct(&out);err != nil{
		return nil, err
	}

	return
}

type {{.FunctionName}}Input struct {
    {{range .Request.Fields}}{{.Name}} {{.Type}}
    {{end}}
}

type {{.FunctionName}}Output struct {
    {{range .Response.Fields}}{{.Name}} {{.Type}}
    {{end}}
}
{{else if eq .Method "POST"}}

{{else if eq .Method "PUT"}}

{{else if eq .Method "DELETE"}}

{{end}}
{{end}}

