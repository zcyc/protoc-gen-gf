var (
	{{$.Name}} = c{{$.Name}}{}
)

type c{{$.Name}} struct{}

{{range .Methods}}
{{if eq .Method "PATCH"}}
func (c *c{{$.Name}}) List{{.FunctionName}}(ctx context.Context, req *v1.List{{.FunctionName}}Req) (res *v1.List{{.FunctionName}}Res, err error) {
	r, err := service.{{$.Name}}().List{{.FunctionName}}(ctx, &model.List{{.FunctionName}}Input{
		Page:     req.Page,
		PageSize: req.PageSize,
		Keyword:  req.Keyword,
	})

	if err != nil {
		return nil, err
	}

	g.RequestFromCtx(ctx).Response.WriteJson(&ghttp.DefaultHandlerResponse{
		Code:    gcode.CodeOK.Code(),
		Message: "succeed",
		Data:    r,
	})
	return
}

func (c *c{{$.Name}}) Get{{.FunctionName}}(ctx context.Context, req *v1.Get{{.FunctionName}}Req) (res *v1.Get{{.FunctionName}}Res, err error) {
	r, err := service.{{$.Name}}().Get{{.FunctionName}}(ctx, &model.Get{{.FunctionName}}Input{
		Id: req.Id,
	})

	if err != nil {
		return nil, err
	}

	g.RequestFromCtx(ctx).Response.WriteJson(&ghttp.DefaultHandlerResponse{
		Code:    gcode.CodeOK.Code(),
		Message: "succeed",
		Data:    r,
	})
	return
}

func (c *c{{$.Name}}) Create{{.FunctionName}}(ctx context.Context, req *v1.Create{{.FunctionName}}Req) (res *v1.Create{{.FunctionName}}Res, err error) {
	if err := service.{{$.Name}}().Create{{.FunctionName}}(ctx, &model.Create{{.FunctionName}}Input{
         {{range .Request.Fields}}{{if ne .Name "Id"}}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}}: req.{{.Name}},
         {{end}}{{end}}{{end}}{{end}}{{end}}
	});err != nil {
		return nil, err
	}

	g.RequestFromCtx(ctx).Response.WriteJson(&ghttp.DefaultHandlerResponse{
		Code:    gcode.CodeOK.Code(),
		Message: "succeed",
		Data:    nil,
	})
	return
}

func (c *c{{$.Name}}) Update{{.FunctionName}}(ctx context.Context, req *v1.Update{{.FunctionName}}Req) (res *v1.Update{{.FunctionName}}Res, err error) {
	if err := service.{{$.Name}}().Update{{.FunctionName}}(ctx, &model.Update{{.FunctionName}}Input{
         {{range .Request.Fields}}{{if ne .Name "CreatedAt"}}{{if ne .Name "UpdatedAt"}}{{if ne .Name "DeletedAt"}}{{.Name}}: req.{{.Name}},
         {{end}}{{end}}{{end}}{{end}}
	});err != nil {
		return nil, err
	}

	g.RequestFromCtx(ctx).Response.WriteJson(&ghttp.DefaultHandlerResponse{
		Code:    gcode.CodeOK.Code(),
		Message: "succeed",
		Data:    nil,
	})
	return
}

func (c *c{{$.Name}}) Delete{{.FunctionName}}(ctx context.Context, req *v1.Delete{{.FunctionName}}Req) (res *v1.Delete{{.FunctionName}}Res, err error) {
	if err := service.{{$.Name}}().Delete{{.FunctionName}}(ctx, &model.Delete{{.FunctionName}}Input{
		Id: req.Id,
	});err != nil {
		return nil, err
	}

	g.RequestFromCtx(ctx).Response.WriteJson(&ghttp.DefaultHandlerResponse{
		Code:    gcode.CodeOK.Code(),
		Message: "succeed",
		Data:    nil,
	})
	return
}
{{else}}
func (c *c{{$.Name}}) {{.FunctionName}}(ctx context.Context, req *v1.{{.FunctionName}}Req) (res *v1.{{.FunctionName}}Res, err error) {
	r, err := service.{{$.Name}}().{{.FunctionName}}(ctx, &model.{{.FunctionName}}Input{
         {{range .Request.Fields}}{{.Name}}: req.{{.Name}},
         {{end}}
	})

	if err != nil {
		return nil, err
	}

	g.RequestFromCtx(ctx).Response.WriteJson(&ghttp.DefaultHandlerResponse{
		Code:    gcode.CodeOK.Code(),
		Message: "succeed",
		Data:    r,
	})
	return
}
{{end}}
{{end}}