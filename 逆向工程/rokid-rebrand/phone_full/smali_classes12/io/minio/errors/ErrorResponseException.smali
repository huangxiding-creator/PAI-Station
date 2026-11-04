.class public Lio/minio/errors/ErrorResponseException;
.super Lio/minio/errors/MinioException;
.source "ErrorResponseException.java"


# static fields
.field private static final serialVersionUID:J = -0x28b4dc5a723e8590L


# instance fields
.field private final errorResponse:Lio/minio/messages/ErrorResponse;

.field private final response:Lokhttp3/Response;


# direct methods
.method public constructor <init>(Lio/minio/messages/ErrorResponse;Lokhttp3/Response;Ljava/lang/String;)V
    .locals 1
    .param p1, "errorResponse"    # Lio/minio/messages/ErrorResponse;
    .param p2, "response"    # Lokhttp3/Response;
    .param p3, "httpTrace"    # Ljava/lang/String;

    .line 38
    invoke-virtual {p1}, Lio/minio/messages/ErrorResponse;->message()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p3}, Lio/minio/errors/MinioException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 39
    iput-object p1, p0, Lio/minio/errors/ErrorResponseException;->errorResponse:Lio/minio/messages/ErrorResponse;

    .line 40
    iput-object p2, p0, Lio/minio/errors/ErrorResponseException;->response:Lokhttp3/Response;

    .line 41
    return-void
.end method


# virtual methods
.method public errorResponse()Lio/minio/messages/ErrorResponse;
    .locals 1

    .line 45
    iget-object v0, p0, Lio/minio/errors/ErrorResponseException;->errorResponse:Lio/minio/messages/ErrorResponse;

    return-object v0
.end method

.method public response()Lokhttp3/Response;
    .locals 1

    .line 49
    iget-object v0, p0, Lio/minio/errors/ErrorResponseException;->response:Lokhttp3/Response;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 6

    .line 54
    iget-object v0, p0, Lio/minio/errors/ErrorResponseException;->response:Lokhttp3/Response;

    invoke-virtual {v0}, Lokhttp3/Response;->request()Lokhttp3/Request;

    move-result-object v0

    .line 55
    .local v0, "request":Lokhttp3/Request;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "error occurred\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lio/minio/errors/ErrorResponseException;->errorResponse:Lio/minio/messages/ErrorResponse;

    .line 56
    invoke-virtual {v2}, Lio/minio/messages/ErrorResponse;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\nrequest={method="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 60
    invoke-virtual {v0}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", url="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 63
    invoke-virtual {v0}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", headers="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 67
    invoke-virtual {v0}, Lokhttp3/Request;->headers()Lokhttp3/Headers;

    move-result-object v3

    .line 68
    invoke-virtual {v3}, Lokhttp3/Headers;->toString()Ljava/lang/String;

    move-result-object v3

    .line 69
    const-string v4, "Signature=([0-9a-f]+)"

    const-string v5, "Signature=*REDACTED*"

    invoke-virtual {v3, v4, v5}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 70
    const-string v4, "Credential=([^/]+)"

    const-string v5, "Credential=*REDACTED*"

    invoke-virtual {v3, v4, v5}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string/jumbo v3, "}\nresponse={code="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lio/minio/errors/ErrorResponseException;->response:Lokhttp3/Response;

    .line 74
    invoke-virtual {v3}, Lokhttp3/Response;->code()I

    move-result v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lio/minio/errors/ErrorResponseException;->response:Lokhttp3/Response;

    .line 77
    invoke-virtual {v2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string/jumbo v2, "}\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 55
    return-object v1
.end method
