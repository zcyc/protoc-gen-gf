type s{{$.Name}} struct{}

func {{$.Name}}New() *s{{$.Name}} {
	return &s{{$.Name}}{}
}

func init() {
	service.Register{{$.Name}}({{$.Name}}New())
}

{{range .Methods}}
{{if eq .Method "PATCH"}}
func (s *s{{$.Name}}) List{{.FunctionName}} (ctx context.Context, in *model.List{{.FunctionName}}Input) (out *model.List{{.FunctionName}}Output, err error) {
	var list []*entity.{{$.Name}}
	d := dao.{{$.Name}}.Ctx(ctx)
	// d = d.Where(dao.{{$.Name}}.Columns().Name, in.Keyword)
	count, err := d.Count()
	if err != nil {
		return nil, err
	}
	if count == 0 {
		return
	}
	if err := d.Page(in.Page, in.PageSize).Scan(&list);err != nil {
		return nil, err
	}
	return &model.List{{ .FunctionName }}Output{
		List: list,
		Total: count,
	}, nil

	return
}

func (s *s{{$.Name}}) Get{{.FunctionName}} (ctx context.Context, in *model.Get{{.FunctionName}}Input) (out *model.Get{{.FunctionName}}Output, err error) {
	one, err := dao.{{$.Name}}.Ctx(ctx).Where(dao.{{$.Name}}.Columns().Id, in.Id).One()
	if err != nil {
		return
	}
	if one.IsEmpty() {
		return
	}
	if err := one.Struct(&out);err != nil{
		return nil, err
	}
	return
}

func (s *s{{$.Name}}) Create{{.FunctionName}} (ctx context.Context, in *model.Create{{.FunctionName}}Input) (err error) {
	{{ $.LowerServiceName }} := &do.{{$.Name}}{
        {{range .Request.Fields}}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}}: in.{{.Name}},
        {{end}}{{end}}{{end}}{{end}}
	}
	if _, err := dao.{{$.Name}}.Ctx(ctx).Data({{$.LowerServiceName}}).Insert();err != nil {
		return err
	}
	return
}

func (s *s{{$.Name}}) Update{{.FunctionName}} (ctx context.Context, in *model.Update{{.FunctionName}}Input) (err error) {
	{{ $.LowerServiceName }} := &do.{{$.Name}}{
            {{range .Request.Fields}}{{if ne .Name "Id"}}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}}: in.{{.Name}},
            {{end}}{{end}}{{end}}{{end}}{{end}}
    	}
	if _, err := dao.{{$.Name}}.Ctx(ctx).Where(dao.{{$.Name}}.Columns().Id, in.Id).Data({{$.LowerServiceName}}).Update();err != nil {
		return err
	}
	return
}

func (s *s{{$.Name}}) Delete{{.FunctionName}} (ctx context.Context, in *model.Delete{{.FunctionName}}Input) (err error) {
    if _, err := dao.{{$.Name}}.Ctx(ctx).Where(dao.{{$.Name}}.Columns().Id, in.Id).Delete();err != nil {
        return err
    }
    return
}
{{else}}
func (s *s{{$.Name}}) {{.FunctionName}} (ctx context.Context, in *model.{{.FunctionName}}Input) (out *model.{{.FunctionName}}Output, err error) {
	// TODO 填充逻辑
	return
}
{{end}}
{{end}}
