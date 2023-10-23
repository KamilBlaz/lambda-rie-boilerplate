
Pre-requisites
--------------
- [Docker](https://www.docker.com/)
- [docker-compose](https://docs.docker.com/compose/)
- [AWS CLI](https://aws.amazon.com/cli/) - optional
- Curl/Postman or any other HTTP client

Many times, I was required to test or create AWS Lambda services. 
I was looking for a solution that would help me do this in a efficient way. 
I found the AWS Lambda Runtime Interface Emulator (RIE), which is a tool that you can use to test Lambda functions locally. 
It is a small web server that exposes the Lambda runtime HTTP server via a REST API.

II find the combination of AWS Lambda RIE, Docker, and watchexec to be incredibly powerful
For more information about watchexec, you can visit the project's github page at https://github.com/watchexec/watchexec

As a part of this post, I will demonstrate how to develop an AWS lambda


Build  our Docker image for Lambda RIE
```
make build
```

After building the image, you can run the container with the Lambda RIE server.
```
make local-lambda
```

Now you can test your lambda function via curl or postman.
I am sending a request to the lambda function via curl
What is important you can change the code in your IDE and Lambda will automatically rebuild your python code.

Open another console and perform the following command
```
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" \
     -d @event.json
```

You should obtain response from lambda function

**Note**:
The important thing is that watchexec is configured under python so if you would like to develop it in another language, you need to change the watchexec command in the entrypoint

