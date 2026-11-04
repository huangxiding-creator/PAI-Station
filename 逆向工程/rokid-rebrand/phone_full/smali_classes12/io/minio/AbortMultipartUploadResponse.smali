.class public Lio/minio/AbortMultipartUploadResponse;
.super Lio/minio/GenericResponse;
.source "AbortMultipartUploadResponse.java"


# instance fields
.field private uploadId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "headers"    # Lokhttp3/Headers;
    .param p2, "bucket"    # Ljava/lang/String;
    .param p3, "region"    # Ljava/lang/String;
    .param p4, "object"    # Ljava/lang/String;
    .param p5, "uploadId"    # Ljava/lang/String;

    .line 27
    invoke-direct {p0, p1, p2, p3, p4}, Lio/minio/GenericResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 28
    iput-object p5, p0, Lio/minio/AbortMultipartUploadResponse;->uploadId:Ljava/lang/String;

    .line 29
    return-void
.end method


# virtual methods
.method public uploadId()Ljava/lang/String;
    .locals 1

    .line 32
    iget-object v0, p0, Lio/minio/AbortMultipartUploadResponse;->uploadId:Ljava/lang/String;

    return-object v0
.end method
