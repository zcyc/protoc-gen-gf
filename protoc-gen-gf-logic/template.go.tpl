type s{{$.Name}} struct{}

func New() *s{{$.Name}} {
	return &s{{$.Name}}{}
}

func init() {
	service.Register{{$.Name}}(New())
}

{{range .Methods}}
{{if eq .Method "GET"}}
func (s *s{{$.Name}}) {{.FunctionName}} (ctx context.Context, in *model.{{.FunctionName}}Input) (out *model.{{.FunctionName}}Output, err error) {
	{{if .IsListMethod}}var list []*entity.{{$.Name}}
	d := dao.{{$.Name}}.Ctx(ctx)
	{{range .Request.Fields }}{{if ne .Name "Page"}}{{if ne .Name "PageSize"}}if !g.IsEmpty(in.{{.Name}}) {
		d = d.Where(dao.{{$.Name}}.Columns().{{.Name}}, in.{{.Name}})
	}
    {{end}}
	{{end}}
	{{end}}
	err = d.Page(in.Page, in.PageSize).Scan(&list)
	if err != nil {
		return
	}

	return &model.{{ .FunctionName }}Output{
		{{$.Name}}List: list,
	}, nil
	{{else}}
	one, err := dao.{{$.Name}}.Ctx(ctx).Where(dao.{{$.Name}}.Columns().Id, in.Id).One()
	if err != nil {
		return
	}
	if one.IsEmpty() {
		return
	}

	one.Struct(&out)
	return
	{{end}}
}

{{else if eq .Method "POST"}}
func (s *s{{$.Name}}) {{.FunctionName}} (ctx context.Context, in *model.{{.FunctionName}}Input) (err error) {
	{{ $.LowerServiceName }} := &do.{{$.Name}}{
        {{range .Request.Fields}}{{.Name}}: in.{{.Name}},
        {{end}}
	}
	err = dao.{{$.Name}}.Ctx(ctx).Data({{ $.LowerServiceName }}).Insert()
	if err != nil {
		return
	}

	return nil
}

{{else if eq .Method "PUT"}}
func (s *s{{$.Name}}) {{.FunctionName}} (ctx context.Context, in *model.{{.FunctionName}}Input) (err error) {
	{{ $.LowerServiceName }} := &do.{{$.Name}}{
            {{range .Request.Fields}}{{.Name}}: in.{{.Name}},
            {{end}}
    	}
	err = dao.{{$.Name}}.Ctx(ctx).Where(dao.{{$.Name}}.Columns().Id, in.Id).Data({{$.Name}}).Update()
	if err != nil {
		return
	}

	return nil
}

{{else if eq .Method "DELETE"}}
func (s *s{{$.Name}}) {{.FunctionName}} (ctx context.Context, in *model.{{.FunctionName}}Input) (err error) {
    err = dao.{{$.Name}}.Ctx(ctx).Where(dao.{{$.Name}}.Columns().Id, in.Id).Delete()
    if err != nil {
        return
    }
    return nil
}
{{end}}
{{end}}