type s{{$.Name}} struct{}

func {{$.Name}}New() *s{{$.Name}} {
	return &s{{$.Name}}{}
}

func init() {
	service.Register{{$.Name}}({{$.Name}}New())
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
	if err := d.Page(in.Page, in.PageSize).Scan(&list);err != nil {
		return
	}

	return &model.{{ .FunctionName }}Output{
		List: list,
	}, nil
	{{else}}one, err := dao.{{$.Name}}.Ctx(ctx).Where(dao.{{$.Name}}.Columns().Id, in.Id).One()
	if err != nil {
		return
	}
	if one.IsEmpty() {
		return
	}

	if err := one.Struct(&out);err != nil{
		return
	}

	return{{end}}
}

{{else if eq .Method "POST"}}
func (s *s{{$.Name}}) {{.FunctionName}} (ctx context.Context, in *model.{{.FunctionName}}Input) (err error) {
	{{ $.LowerServiceName }} := &do.{{$.Name}}{
        {{range .Request.Fields}}{{if ne .Name "Id"}}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}}: in.{{.Name}},
        {{end}}
		{{end}}
		{{end}}
		{{end}}
		{{end}}
	}
	if _, err = dao.{{$.Name}}.Ctx(ctx).Data({{$.LowerServiceName}}).Insert();err != nil {
		return
	}

	return nil
}

{{else if eq .Method "PUT"}}
func (s *s{{$.Name}}) {{.FunctionName}} (ctx context.Context, in *model.{{.FunctionName}}Input) (err error) {
	{{ $.LowerServiceName }} := &do.{{$.Name}}{
            {{range .Request.Fields}}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}}: in.{{.Name}},
            {{end}}
			{{end}}
			{{end}}
			{{end}}
    	}
	if _, err = dao.{{$.Name}}.Ctx(ctx).Where(dao.{{$.Name}}.Columns().Id, in.Id).Data({{$.LowerServiceName}}).Update();err != nil {
		return
	}

	return nil
}

{{else if eq .Method "DELETE"}}
func (s *s{{$.Name}}) {{.FunctionName}} (ctx context.Context, in *model.{{.FunctionName}}Input) (err error) {
    if _, err = dao.{{$.Name}}.Ctx(ctx).Where(dao.{{$.Name}}.Columns().Id, in.Id).Delete();err != nil {
        return
    }
    return nil
}
{{end}}
{{end}}