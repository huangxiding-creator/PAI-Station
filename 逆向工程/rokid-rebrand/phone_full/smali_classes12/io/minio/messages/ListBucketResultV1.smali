.class public Lio/minio/messages/ListBucketResultV1;
.super Lio/minio/messages/ListObjectsResult;
.source "ListBucketResultV1.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "ListBucketResult"
    strict = false
.end annotation


# instance fields
.field private contents:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/messages/Contents;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementList;
        inline = true
        name = "Contents"
        required = false
    .end annotation
.end field

.field private marker:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Marker"
        required = false
    .end annotation
.end field

.field private nextMarker:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "NextMarker"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 32
    invoke-direct {p0}, Lio/minio/messages/ListObjectsResult;-><init>()V

    return-void
.end method


# virtual methods
.method public contents()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/messages/Contents;",
            ">;"
        }
    .end annotation

    .line 52
    iget-object v0, p0, Lio/minio/messages/ListBucketResultV1;->contents:Ljava/util/List;

    invoke-virtual {p0, v0}, Lio/minio/messages/ListBucketResultV1;->emptyIfNull(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public marker()Ljava/lang/String;
    .locals 1

    .line 43
    iget-object v0, p0, Lio/minio/messages/ListBucketResultV1;->marker:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lio/minio/messages/ListBucketResultV1;->decodeIfNeeded(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public nextMarker()Ljava/lang/String;
    .locals 1

    .line 47
    iget-object v0, p0, Lio/minio/messages/ListBucketResultV1;->nextMarker:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lio/minio/messages/ListBucketResultV1;->decodeIfNeeded(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
