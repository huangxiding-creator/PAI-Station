.class public Lio/minio/UploadPartResponse;
.super Lio/minio/GenericResponse;
.source "UploadPartResponse.java"


# instance fields
.field private etag:Ljava/lang/String;

.field private partNumber:I

.field private uploadId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p1, "headers"    # Lokhttp3/Headers;
    .param p2, "bucket"    # Ljava/lang/String;
    .param p3, "region"    # Ljava/lang/String;
    .param p4, "object"    # Ljava/lang/String;
    .param p5, "uploadId"    # Ljava/lang/String;
    .param p6, "partNumber"    # I
    .param p7, "etag"    # Ljava/lang/String;

    .line 35
    invoke-direct {p0, p1, p2, p3, p4}, Lio/minio/GenericResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 36
    iput-object p5, p0, Lio/minio/UploadPartResponse;->uploadId:Ljava/lang/String;

    .line 37
    iput p6, p0, Lio/minio/UploadPartResponse;->partNumber:I

    .line 38
    iput-object p7, p0, Lio/minio/UploadPartResponse;->etag:Ljava/lang/String;

    .line 39
    return-void
.end method


# virtual methods
.method public etag()Ljava/lang/String;
    .locals 1

    .line 50
    iget-object v0, p0, Lio/minio/UploadPartResponse;->etag:Ljava/lang/String;

    return-object v0
.end method

.method public partNumber()I
    .locals 1

    .line 46
    iget v0, p0, Lio/minio/UploadPartResponse;->partNumber:I

    return v0
.end method

.method public uploadId()Ljava/lang/String;
    .locals 1

    .line 42
    iget-object v0, p0, Lio/minio/UploadPartResponse;->uploadId:Ljava/lang/String;

    return-object v0
.end method
