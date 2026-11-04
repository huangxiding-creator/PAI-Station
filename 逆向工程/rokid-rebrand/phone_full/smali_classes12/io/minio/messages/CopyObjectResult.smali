.class public Lio/minio/messages/CopyObjectResult;
.super Ljava/lang/Object;
.source "CopyObjectResult.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "CopyObjectResult"
    strict = false
.end annotation


# instance fields
.field private etag:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ETag"
    .end annotation
.end field

.field private lastModified:Lio/minio/messages/ResponseDate;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "LastModified"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public etag()Ljava/lang/String;
    .locals 1

    .line 42
    iget-object v0, p0, Lio/minio/messages/CopyObjectResult;->etag:Ljava/lang/String;

    return-object v0
.end method

.method public lastModified()Ljava/time/ZonedDateTime;
    .locals 1

    .line 47
    iget-object v0, p0, Lio/minio/messages/CopyObjectResult;->lastModified:Lio/minio/messages/ResponseDate;

    invoke-virtual {v0}, Lio/minio/messages/ResponseDate;->zonedDateTime()Ljava/time/ZonedDateTime;

    move-result-object v0

    return-object v0
.end method
