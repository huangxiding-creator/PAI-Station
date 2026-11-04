.class public Lio/minio/ObjectWriteResponse;
.super Lio/minio/GenericResponse;
.source "ObjectWriteResponse.java"


# instance fields
.field private etag:Ljava/lang/String;

.field private versionId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "headers"    # Lokhttp3/Headers;
    .param p2, "bucket"    # Ljava/lang/String;
    .param p3, "region"    # Ljava/lang/String;
    .param p4, "object"    # Ljava/lang/String;
    .param p5, "etag"    # Ljava/lang/String;
    .param p6, "versionId"    # Ljava/lang/String;

    .line 28
    invoke-direct {p0, p1, p2, p3, p4}, Lio/minio/GenericResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 29
    iput-object p5, p0, Lio/minio/ObjectWriteResponse;->etag:Ljava/lang/String;

    .line 30
    iput-object p6, p0, Lio/minio/ObjectWriteResponse;->versionId:Ljava/lang/String;

    .line 31
    return-void
.end method


# virtual methods
.method public etag()Ljava/lang/String;
    .locals 1

    .line 34
    iget-object v0, p0, Lio/minio/ObjectWriteResponse;->etag:Ljava/lang/String;

    return-object v0
.end method

.method public versionId()Ljava/lang/String;
    .locals 1

    .line 38
    iget-object v0, p0, Lio/minio/ObjectWriteResponse;->versionId:Ljava/lang/String;

    return-object v0
.end method
