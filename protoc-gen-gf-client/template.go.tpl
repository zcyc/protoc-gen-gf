import (
	"context"
	"fmt"

	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
)

type s{{$.Name}}Client struct{}

func New() *s{{$.Name}}Client {
	return &s{{$.Name}}Client{}
}

func init() {
	service.Register{{$.Name}}Client(New())
}
{{range .Methods}}
{{if eq .Method "GET"}}
func (s *s{{$.Name}}Client) {{ .FunctionName }} (ctx context.Context, in *{{ .FunctionName }}Input) (out *{{ .FunctionName }}Output, err error) {
	server, _ := g.Cfg().Get(ctx, "serverUri.{{$.LowerServiceName}}Server")
	if _, err := g.Client().{{.Method}}(
		ctx,
		fmt.Sprintf("%s{{.Path}}", server),
		g.Map{
			"id": in.Id,
		},
	); err != nil {
		g.Log().Errorf(ctx, "s{{$.Name}}Client {{ .FunctionName }} Client error %v", err)
		return nil, gerror.NewCode(gcode.CodeInternalError, common_consts.MessageSystemBusy)
	}

	return &model.{{ .FunctionName }}Output{}, nil
}

type {{ .FunctionName }}Input struct {
    {{range .Request.Fields }}
        {{ .Name}} {{ .Type}}
    {{end}}
}

type {{ .FunctionName }}Output struct {
    {{range .Response.Fields }}
        {{ .Name}} {{ .Type}}
    {{end}}
}
{{else if eq .Method "POST"}}

{{else if eq .Method "PUT"}}

{{else if eq .Method "DELETE"}}

{{end}}
{{end}}

