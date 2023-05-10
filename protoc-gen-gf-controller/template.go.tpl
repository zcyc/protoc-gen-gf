var (
	{{$.Name}} = c{{$.Name}}{}
)

type c{{$.Name}} struct{}

{{range .Methods}}
{{if eq .Method "GET"}}
func (c *c{{$.Name}}) {{.FunctionName}}(ctx context.Context, req *v1.{{.FunctionName }}Req) (res *v1.{{.FunctionName}}Res, err error) {
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
{{else if eq .Method "POST"}}
func (c *c{{$.Name}}) {{.FunctionName}}(ctx context.Context, req *v1.{{.FunctionName }}Req) (res *v1.{{.FunctionName}}Res, err error) {
	if err := service.{{$.Name}}().{{.FunctionName}}(ctx, &model.{{.FunctionName}}Input{
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
{{else if eq .Method "PUT"}}
func (c *c{{$.Name}}) {{.FunctionName}}(ctx context.Context, req *v1.{{.FunctionName }}Req) (res *v1.{{.FunctionName}}Res, err error) {
	if err := service.{{$.Name}}().{{.FunctionName}}(ctx, &model.{{.FunctionName}}Input{
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
{{else if eq .Method "DELETE"}}
func (c *c{{$.Name}}) {{.FunctionName}}(ctx context.Context, req *v1.{{.FunctionName }}Req) (res *v1.{{.FunctionName}}Res, err error) {
	if err := service.{{$.Name}}().{{.FunctionName}}(ctx, &model.{{.FunctionName}}Input{
         {{range .Request.Fields}}{{.Name}}: req.{{.Name}},
		 {{end}}
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
{{end}}
{{end}}