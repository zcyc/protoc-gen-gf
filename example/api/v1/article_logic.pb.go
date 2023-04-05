// Code generated by protoc-gen-gf-logic. DO NOT EDIT.
// versions:
// - protoc-gen-gf-logic v0.0.1
// - protoc              v3.19.4
// source: v1/article.proto

package v1

// This is a compile-time assertion to ensure that this generated file
// is compatible with the goframe package it is being compiled against.

import (
	"context"
	"fmt"

	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
)

type sBlog struct{}

func New() *sBlog {
	return &sBlog{}
}

func init() {
	service.RegisterBlog(New())
}

func (s *sBlog) GetArticles(ctx context.Context, in *model.GetArticlesInput) (out *model.GetArticlesOutput, err error) {
	var list []*entity.Blog
	d := dao.Blog.Ctx(ctx)

	d = d.Where(dao.Blog.Columns().Title, in.Title)

	d = d.Where(dao.Blog.Columns().Page, in.Page)

	d = d.Where(dao.Blog.Columns().PageSize, in.PageSize)

	d = d.Where(dao.Blog.Columns().AuthorId, in.AuthorId)

	err = d.Scan(&list)
	if err != nil {
		return
	}

	return &model.GetArticlesOutput{
		BlogList: list,
	}, nil
}

func (s *sBlog) CreateArticle(ctx context.Context, in *model.CreateArticleInput) (err error) {
	blog := &do.Blog{

		Title: in.Title,

		Content: in.Content,

		AuthorId: in.AuthorId,
	}
	err = dao.Blog.Ctx(ctx).Data(blog).Insert()
	if err != nil {
		return
	}

	return nil
}
