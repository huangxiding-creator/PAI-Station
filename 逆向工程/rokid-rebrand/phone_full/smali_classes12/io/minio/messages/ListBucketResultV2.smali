.class public Lio/minio/messages/ListBucketResultV2;
.super Lio/minio/messages/ListObjectsResult;
.source "ListBucketResultV2.java"


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

.field private continuationToken:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ContinuationToken"
        required = false
    .end annotation
.end field

.field private keyCount:I
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "KeyCount"
        required = false
    .end annotation
.end field

.field private nextContinuationToken:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "NextContinuationToken"
        required = false
    .end annotation
.end field

.field private startAfter:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "StartAfter"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 33
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

    .line 72
    iget-object v0, p0, Lio/minio/messages/ListBucketResultV2;->contents:Ljava/util/List;

    invoke-virtual {p0, v0}, Lio/minio/messages/ListBucketResultV2;->emptyIfNull(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public continuationToken()Ljava/lang/String;
    .locals 1

    .line 61
    iget-object v0, p0, Lio/minio/messages/ListBucketResultV2;->continuationToken:Ljava/lang/String;

    return-object v0
.end method

.method public keyCount()I
    .locals 1

    .line 51
    iget v0, p0, Lio/minio/messages/ListBucketResultV2;->keyCount:I

    return v0
.end method

.method public nextContinuationToken()Ljava/lang/String;
    .locals 1

    .line 66
    iget-object v0, p0, Lio/minio/messages/ListBucketResultV2;->nextContinuationToken:Ljava/lang/String;

    return-object v0
.end method

.method public startAfter()Ljava/lang/String;
    .locals 1

    .line 56
    iget-object v0, p0, Lio/minio/messages/ListBucketResultV2;->startAfter:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lio/minio/messages/ListBucketResultV2;->decodeIfNeeded(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
