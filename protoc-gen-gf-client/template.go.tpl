{{range .Methods}}
{{if eq .Method "GET"}}
func {{.FunctionName}} (ctx context.Context, in *{{.FunctionName}}Input) (out *{{.FunctionName}}Output, err error) {
	server, _ := g.Cfg().Get(ctx, "serverUri.{{$.LowerServiceName}}Server")
	res, err := g.Client().Get(
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

type {{.FunctionName}}Input struct {
    {{range .Request.Fields}}{{.Name}} {{.Type}}
    {{end}}
}

type {{.FunctionName}}Output struct {
    {{range .Response.Fields}}{{.Name}} {{.Type}}
    {{end}}
}
{{else if eq .Method "PUT"}}

type {{.FunctionName}}Input struct {
    {{range .Request.Fields}}{{.Name}} {{.Type}}
    {{end}}
}

type {{.FunctionName}}Output struct {
    {{range .Response.Fields}}{{.Name}} {{.Type}}
    {{end}}
}
{{else if eq .Method "DELETE"}}
func {{.FunctionName}} (ctx context.Context, in *{{.FunctionName}}Input) (out *{{.FunctionName}}Output, err error) {
	server, _ := g.Cfg().Get(ctx, "serverUri.{{$.LowerServiceName}}Server")
	res, err := g.Client().Delete(
		ctx,
		fmt.Sprintf("%s{{.Path}}", server),
		g.Map{
			"id": in.Id,
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
{{end}}
{{end}}

