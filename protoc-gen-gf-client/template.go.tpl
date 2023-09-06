{{range .Methods}}
{{if eq .Method "PATCH"}}
func List{{.FunctionName}} (ctx context.Context, in *List{{.FunctionName}}Input) (out *List{{.FunctionName}}Output, err error) {
	server, _ := g.Cfg().Get(ctx, "serverUri.{{$.LowerServiceName}}Server")
	res, err := g.Client().Get(
		ctx,
		fmt.Sprintf("%s{{.Path}}", server),
		g.Map{
			"page": in.Page,
			"page_size": in.PageSize,
		},
	);
	if err != nil {
		return nil, err
	}

	if err := res.Struct(&out);err != nil{
		return nil, err
	}

	return
}

type List{{.FunctionName}}Input struct {
	Page     int
	PageSize int
	Keyword  string
}

type List{{.FunctionName}}Output struct {
	Total int
	List  []*Get{{.FunctionName}}Output
}

func Get{{.FunctionName}} (ctx context.Context, in *Get{{.FunctionName}}Input) (out *Get{{.FunctionName}}Output, err error) {
	server, _ := g.Cfg().Get(ctx, "serverUri.{{$.LowerServiceName}}Server")
	res, err := g.Client().Get(
		ctx,
		fmt.Sprintf("%s{{.Path}}", server),
		g.Map{
			"id": in.Id,
		},
	);
	if err != nil {
		return nil, err
	}

	if err := res.Struct(&out);err != nil{
		return nil, err
	}

	return
}

type Get{{.FunctionName}}Input struct {
    {{range .Request.Fields}}{{.Name}} {{.Type}}
    {{end}}
}

type Get{{.FunctionName}}Output struct {
    {{range .Response.Fields }}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{ .Name}} {{ .Type}}
    {{end}}{{end}}{{end}}
}

type Create{{.FunctionName}}Input struct {
    {{range .Request.Fields}}{{.Name}} {{.Type}}
    {{end}}
}

type Create{{.FunctionName}}Output struct {
    {{range .Response.Fields}}{{.Name}} {{.Type}}
    {{end}}
}

type Update{{.FunctionName}}Input struct {
    {{range .Request.Fields}}{{.Name}} {{.Type}}
    {{end}}
}

type Update{{.FunctionName}}Output struct {
    {{range .Response.Fields}}{{.Name}} {{.Type}}
    {{end}}
}

func Delete{{.FunctionName}} (ctx context.Context, in *Delete{{.FunctionName}}Input) (err error) {
	server, _ := g.Cfg().Get(ctx, "serverUri.{{$.LowerServiceName}}Server")
	res, err := g.Client().Delete(
		ctx,
		fmt.Sprintf("%s{{.Path}}", server),
		g.Map{
			"id": in.Id,
		},
	);
	if err != nil {
		return err
	}
	return
}

type Delete{{.FunctionName}}Input struct {
    Id string
}
{{else}}
func {{.FunctionName}} (ctx context.Context, in *{{.FunctionName}}Input) (out *{{.FunctionName}}Output, err error) {
	server, _ := g.Cfg().Get(ctx, "serverUri.{{$.LowerServiceName}}Server")
	res, err := g.Client().Get(
		ctx,
		fmt.Sprintf("%s{{.Path}}", server),
		g.Map{},
	);
	if err != nil {
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

