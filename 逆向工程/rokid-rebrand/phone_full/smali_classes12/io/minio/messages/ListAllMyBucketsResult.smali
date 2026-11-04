.class public Lio/minio/messages/ListAllMyBucketsResult;
.super Ljava/lang/Object;
.source "ListAllMyBucketsResult.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "ListAllMyBucketsResult"
    strict = false
.end annotation


# instance fields
.field private buckets:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/messages/Bucket;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementList;
        name = "Buckets"
    .end annotation
.end field

.field private owner:Lio/minio/messages/Owner;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Owner"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public buckets()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/messages/Bucket;",
            ">;"
        }
    .end annotation

    .line 50
    iget-object v0, p0, Lio/minio/messages/ListAllMyBucketsResult;->buckets:Ljava/util/List;

    if-nez v0, :cond_0

    .line 51
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0

    .line 54
    :cond_0
    iget-object v0, p0, Lio/minio/messages/ListAllMyBucketsResult;->buckets:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public owner()Lio/minio/messages/Owner;
    .locals 1

    .line 45
    iget-object v0, p0, Lio/minio/messages/ListAllMyBucketsResult;->owner:Lio/minio/messages/Owner;

    return-object v0
.end method
