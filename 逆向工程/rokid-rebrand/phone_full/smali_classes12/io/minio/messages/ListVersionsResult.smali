.class public Lio/minio/messages/ListVersionsResult;
.super Lio/minio/messages/ListObjectsResult;
.source "ListVersionsResult.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "ListVersionsResult"
    strict = false
.end annotation


# instance fields
.field private contents:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/messages/Version;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementList;
        inline = true
        name = "Version"
        required = false
    .end annotation
.end field

.field private deleteMarkers:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/messages/DeleteMarker;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementList;
        inline = true
        name = "DeleteMarker"
        required = false
    .end annotation
.end field

.field private keyMarker:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "KeyMarker"
        required = false
    .end annotation
.end field

.field private nextKeyMarker:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "NextKeyMarker"
        required = false
    .end annotation
.end field

.field private nextVersionIdMarker:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "NextVersionIdMarker"
        required = false
    .end annotation
.end field

.field private versionIdMarker:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "VersionIdMarker"
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
            "Lio/minio/messages/Version;",
            ">;"
        }
    .end annotation

    .line 70
    iget-object v0, p0, Lio/minio/messages/ListVersionsResult;->contents:Ljava/util/List;

    invoke-virtual {p0, v0}, Lio/minio/messages/ListVersionsResult;->emptyIfNull(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public deleteMarkers()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/messages/DeleteMarker;",
            ">;"
        }
    .end annotation

    .line 75
    iget-object v0, p0, Lio/minio/messages/ListVersionsResult;->deleteMarkers:Ljava/util/List;

    invoke-virtual {p0, v0}, Lio/minio/messages/ListVersionsResult;->emptyIfNull(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public keyMarker()Ljava/lang/String;
    .locals 1

    .line 53
    iget-object v0, p0, Lio/minio/messages/ListVersionsResult;->keyMarker:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lio/minio/messages/ListVersionsResult;->decodeIfNeeded(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public nextKeyMarker()Ljava/lang/String;
    .locals 1

    .line 57
    iget-object v0, p0, Lio/minio/messages/ListVersionsResult;->nextKeyMarker:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lio/minio/messages/ListVersionsResult;->decodeIfNeeded(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public nextVersionIdMarker()Ljava/lang/String;
    .locals 1

    .line 65
    iget-object v0, p0, Lio/minio/messages/ListVersionsResult;->nextVersionIdMarker:Ljava/lang/String;

    return-object v0
.end method

.method public versionIdMarker()Ljava/lang/String;
    .locals 1

    .line 61
    iget-object v0, p0, Lio/minio/messages/ListVersionsResult;->versionIdMarker:Ljava/lang/String;

    return-object v0
.end method
