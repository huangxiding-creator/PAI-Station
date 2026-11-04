.class public Lio/minio/CreateMultipartUploadResponse;
.super Lio/minio/GenericResponse;
.source "CreateMultipartUploadResponse.java"


# instance fields
.field private result:Lio/minio/messages/InitiateMultipartUploadResult;


# direct methods
.method public constructor <init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/InitiateMultipartUploadResult;)V
    .locals 0
    .param p1, "headers"    # Lokhttp3/Headers;
    .param p2, "bucket"    # Ljava/lang/String;
    .param p3, "region"    # Ljava/lang/String;
    .param p4, "object"    # Ljava/lang/String;
    .param p5, "result"    # Lio/minio/messages/InitiateMultipartUploadResult;

    .line 32
    invoke-direct {p0, p1, p2, p3, p4}, Lio/minio/GenericResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 33
    iput-object p5, p0, Lio/minio/CreateMultipartUploadResponse;->result:Lio/minio/messages/InitiateMultipartUploadResult;

    .line 34
    return-void
.end method


# virtual methods
.method public result()Lio/minio/messages/InitiateMultipartUploadResult;
    .locals 1

    .line 37
    iget-object v0, p0, Lio/minio/CreateMultipartUploadResponse;->result:Lio/minio/messages/InitiateMultipartUploadResult;

    return-object v0
.end method
