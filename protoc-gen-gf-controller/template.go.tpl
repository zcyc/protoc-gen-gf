var (
	{{$.Name}} = c{{$.Name}}{}
)

type c{{$.Name}} struct{}

{{range .Methods}}
func (c *c{{$.Name}}) {{.FunctionName}}(ctx context.Context, req *v1.{{.FunctionName }}Req) (res *v1.{{.FunctionName}}Res, err error) {
	// 调用 service 处理请求
	r, err := service.{{$.Name}}().{{.FunctionName}}(ctx, &model.{{.FunctionName}}Input{
         {{range .Request.Fields}}{{.Name}}: req.{{.Name}},
         {{end}}
	})

	// 返回错误消息
	if err != nil {
		return nil, gerror.NewCode(gcode.CodeInternalError, err.Error())
	}

	// 返回成功信息
	g.RequestFromCtx(ctx).Response.WriteJson(&ghttp.DefaultHandlerResponse{
		Code:    gcode.CodeOK.Code(),
		Message: "succeed",
		Data:    r,
	})
	return
}
{{end}}