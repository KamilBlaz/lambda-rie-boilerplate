
def handler(event, context):
    print(f"Event: {event}")
    print(event["Records"][0]["s3"]["object"]["key"])
