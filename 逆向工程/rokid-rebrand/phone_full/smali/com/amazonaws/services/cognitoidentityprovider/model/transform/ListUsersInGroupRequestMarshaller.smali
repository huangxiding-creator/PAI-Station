.class public Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUsersInGroupRequestMarshaller;
.super Ljava/lang/Object;
.source "ListUsersInGroupRequestMarshaller.java"

# interfaces
.implements Lcom/amazonaws/transform/Marshaller;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/amazonaws/transform/Marshaller<",
        "Lcom/amazonaws/Request<",
        "Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;",
        ">;",
        "Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;)Lcom/amazonaws/Request;
    .locals 9
    .param p1, "listUsersInGroupRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;",
            ")",
            "Lcom/amazonaws/Request<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;",
            ">;"
        }
    .end annotation

    .line 46
    if-eqz p1, :cond_5

    .line 51
    new-instance v0, Lcom/amazonaws/DefaultRequest;

    const-string v1, "AmazonCognitoIdentityProvider"

    invoke-direct {v0, p1, v1}, Lcom/amazonaws/DefaultRequest;-><init>(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/lang/String;)V

    .line 53
    .local v0, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;>;"
    const-string v1, "AWSCognitoIdentityProviderService.ListUsersInGroup"

    .line 54
    .local v1, "target":Ljava/lang/String;
    const-string v2, "X-Amz-Target"

    invoke-interface {v0, v2, v1}, Lcom/amazonaws/Request;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 55
    sget-object v2, Lcom/amazonaws/http/HttpMethodName;->POST:Lcom/amazonaws/http/HttpMethodName;

    invoke-interface {v0, v2}, Lcom/amazonaws/Request;->setHttpMethod(Lcom/amazonaws/http/HttpMethodName;)V

    .line 57
    const-string v2, "/"

    .line 58
    .local v2, "uriResourcePath":Ljava/lang/String;
    invoke-interface {v0, v2}, Lcom/amazonaws/Request;->setResourcePath(Ljava/lang/String;)V

    .line 60
    :try_start_0
    new-instance v3, Ljava/io/StringWriter;

    invoke-direct {v3}, Ljava/io/StringWriter;-><init>()V

    .line 61
    .local v3, "stringWriter":Ljava/io/StringWriter;
    invoke-static {v3}, Lcom/amazonaws/util/json/JsonUtils;->getJsonWriter(Ljava/io/Writer;)Lcom/amazonaws/util/json/AwsJsonWriter;

    move-result-object v4

    .line 62
    .local v4, "jsonWriter":Lcom/amazonaws/util/json/AwsJsonWriter;
    invoke-interface {v4}, Lcom/amazonaws/util/json/AwsJsonWriter;->beginObject()Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 64
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_0

    .line 65
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v5

    .line 66
    .local v5, "userPoolId":Ljava/lang/String;
    const-string v6, "UserPoolId"

    invoke-interface {v4, v6}, Lcom/amazonaws/util/json/AwsJsonWriter;->name(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 67
    invoke-interface {v4, v5}, Lcom/amazonaws/util/json/AwsJsonWriter;->value(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 69
    .end local v5    # "userPoolId":Ljava/lang/String;
    :cond_0
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getGroupName()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_1

    .line 70
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getGroupName()Ljava/lang/String;

    move-result-object v5

    .line 71
    .local v5, "groupName":Ljava/lang/String;
    const-string v6, "GroupName"

    invoke-interface {v4, v6}, Lcom/amazonaws/util/json/AwsJsonWriter;->name(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 72
    invoke-interface {v4, v5}, Lcom/amazonaws/util/json/AwsJsonWriter;->value(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 74
    .end local v5    # "groupName":Ljava/lang/String;
    :cond_1
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v5

    if-eqz v5, :cond_2

    .line 75
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v5

    .line 76
    .local v5, "limit":Ljava/lang/Integer;
    const-string v6, "Limit"

    invoke-interface {v4, v6}, Lcom/amazonaws/util/json/AwsJsonWriter;->name(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 77
    invoke-interface {v4, v5}, Lcom/amazonaws/util/json/AwsJsonWriter;->value(Ljava/lang/Number;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 79
    .end local v5    # "limit":Ljava/lang/Integer;
    :cond_2
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getNextToken()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_3

    .line 80
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getNextToken()Ljava/lang/String;

    move-result-object v5

    .line 81
    .local v5, "nextToken":Ljava/lang/String;
    const-string v6, "NextToken"

    invoke-interface {v4, v6}, Lcom/amazonaws/util/json/AwsJsonWriter;->name(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 82
    invoke-interface {v4, v5}, Lcom/amazonaws/util/json/AwsJsonWriter;->value(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 85
    .end local v5    # "nextToken":Ljava/lang/String;
    :cond_3
    invoke-interface {v4}, Lcom/amazonaws/util/json/AwsJsonWriter;->endObject()Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 86
    invoke-interface {v4}, Lcom/amazonaws/util/json/AwsJsonWriter;->close()V

    .line 87
    invoke-virtual {v3}, Ljava/io/StringWriter;->toString()Ljava/lang/String;

    move-result-object v5

    .line 88
    .local v5, "snippet":Ljava/lang/String;
    sget-object v6, Lcom/amazonaws/util/StringUtils;->UTF8:Ljava/nio/charset/Charset;

    invoke-virtual {v5, v6}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v6

    .line 89
    .local v6, "content":[B
    new-instance v7, Lcom/amazonaws/util/StringInputStream;

    invoke-direct {v7, v5}, Lcom/amazonaws/util/StringInputStream;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v7}, Lcom/amazonaws/Request;->setContent(Ljava/io/InputStream;)V

    .line 90
    const-string v7, "Content-Length"

    array-length v8, v6

    invoke-static {v8}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v8

    invoke-interface {v0, v7, v8}, Lcom/amazonaws/Request;->addHeader(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 94
    .end local v3    # "stringWriter":Ljava/io/StringWriter;
    .end local v4    # "jsonWriter":Lcom/amazonaws/util/json/AwsJsonWriter;
    .end local v5    # "snippet":Ljava/lang/String;
    .end local v6    # "content":[B
    nop

    .line 95
    invoke-interface {v0}, Lcom/amazonaws/Request;->getHeaders()Ljava/util/Map;

    move-result-object v3

    const-string v4, "Content-Type"

    invoke-interface {v3, v4}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    .line 96
    const-string v3, "application/x-amz-json-1.1"

    invoke-interface {v0, v4, v3}, Lcom/amazonaws/Request;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 99
    :cond_4
    return-object v0

    .line 91
    :catchall_0
    move-exception v3

    .line 92
    .local v3, "t":Ljava/lang/Throwable;
    new-instance v4, Lcom/amazonaws/AmazonClientException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Unable to marshall request to JSON: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 93
    invoke-virtual {v3}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5, v3}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v4

    .line 47
    .end local v0    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;>;"
    .end local v1    # "target":Ljava/lang/String;
    .end local v2    # "uriResourcePath":Ljava/lang/String;
    .end local v3    # "t":Ljava/lang/Throwable;
    :cond_5
    new-instance v0, Lcom/amazonaws/AmazonClientException;

    const-string v1, "Invalid argument passed to marshall(ListUsersInGroupRequest)"

    invoke-direct {v0, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public bridge synthetic marshall(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 42
    check-cast p1, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;

    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUsersInGroupRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;)Lcom/amazonaws/Request;

    move-result-object p1

    return-object p1
.end method
