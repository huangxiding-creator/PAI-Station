.class public Lio/minio/GetObjectResponse;
.super Ljava/io/FilterInputStream;
.source "GetObjectResponse.java"


# instance fields
.field private response:Lio/minio/GenericResponse;


# direct methods
.method public constructor <init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/io/InputStream;)V
    .locals 1
    .param p1, "headers"    # Lokhttp3/Headers;
    .param p2, "bucket"    # Ljava/lang/String;
    .param p3, "region"    # Ljava/lang/String;
    .param p4, "object"    # Ljava/lang/String;
    .param p5, "body"    # Ljava/io/InputStream;

    .line 33
    invoke-direct {p0, p5}, Ljava/io/FilterInputStream;-><init>(Ljava/io/InputStream;)V

    .line 34
    new-instance v0, Lio/minio/GenericResponse;

    invoke-direct {v0, p1, p2, p3, p4}, Lio/minio/GenericResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lio/minio/GetObjectResponse;->response:Lio/minio/GenericResponse;

    .line 35
    return-void
.end method


# virtual methods
.method public bucket()Ljava/lang/String;
    .locals 1

    .line 42
    iget-object v0, p0, Lio/minio/GetObjectResponse;->response:Lio/minio/GenericResponse;

    invoke-virtual {v0}, Lio/minio/GenericResponse;->bucket()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public headers()Lokhttp3/Headers;
    .locals 1

    .line 38
    iget-object v0, p0, Lio/minio/GetObjectResponse;->response:Lio/minio/GenericResponse;

    invoke-virtual {v0}, Lio/minio/GenericResponse;->headers()Lokhttp3/Headers;

    move-result-object v0

    return-object v0
.end method

.method public object()Ljava/lang/String;
    .locals 1

    .line 50
    iget-object v0, p0, Lio/minio/GetObjectResponse;->response:Lio/minio/GenericResponse;

    invoke-virtual {v0}, Lio/minio/GenericResponse;->object()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public region()Ljava/lang/String;
    .locals 1

    .line 46
    iget-object v0, p0, Lio/minio/GetObjectResponse;->response:Lio/minio/GenericResponse;

    invoke-virtual {v0}, Lio/minio/GenericResponse;->region()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
