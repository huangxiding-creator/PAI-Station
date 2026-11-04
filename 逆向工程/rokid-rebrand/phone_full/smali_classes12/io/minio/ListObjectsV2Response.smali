.class public Lio/minio/ListObjectsV2Response;
.super Lio/minio/GenericResponse;
.source "ListObjectsV2Response.java"


# instance fields
.field private result:Lio/minio/messages/ListBucketResultV2;


# direct methods
.method public constructor <init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/ListBucketResultV2;)V
    .locals 1
    .param p1, "headers"    # Lokhttp3/Headers;
    .param p2, "bucket"    # Ljava/lang/String;
    .param p3, "region"    # Ljava/lang/String;
    .param p4, "result"    # Lio/minio/messages/ListBucketResultV2;

    .line 28
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, p3, v0}, Lio/minio/GenericResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 29
    iput-object p4, p0, Lio/minio/ListObjectsV2Response;->result:Lio/minio/messages/ListBucketResultV2;

    .line 30
    return-void
.end method


# virtual methods
.method public result()Lio/minio/messages/ListBucketResultV2;
    .locals 1

    .line 33
    iget-object v0, p0, Lio/minio/ListObjectsV2Response;->result:Lio/minio/messages/ListBucketResultV2;

    return-object v0
.end method
