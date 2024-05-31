package main

import (
	"context"
	"fmt"

	//"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

type Events struct {
	//Records map[string]*Record
	Records []*Record
}

type Record struct {
	Message string `json:"Message"`
}

func handleRequest(event *Events, ctx context.Context) (string, error) {
	fmt.Print(event, "\n", ctx)
	return "Hello World from Go", nil
}

func main() {
	lambda.Start(handleRequest)
}
