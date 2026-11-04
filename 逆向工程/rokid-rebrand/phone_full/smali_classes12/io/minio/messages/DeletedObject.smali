.class public Lio/minio/messages/DeletedObject;
.super Ljava/lang/Object;
.source "DeletedObject.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Deleted"
    strict = false
.end annotation


# instance fields
.field private deleteMarker:Z
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "DeleteMarker"
        required = false
    .end annotation
.end field

.field private deleteMarkerVersionId:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "DeleteMarkerVersionId"
        required = false
    .end annotation
.end field

.field private name:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Key"
    .end annotation
.end field

.field private versionId:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "VersionId"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public deleteMarker()Z
    .locals 1

    .line 48
    iget-boolean v0, p0, Lio/minio/messages/DeletedObject;->deleteMarker:Z

    return v0
.end method

.method public deleteMarkerVersionId()Ljava/lang/String;
    .locals 1

    .line 52
    iget-object v0, p0, Lio/minio/messages/DeletedObject;->deleteMarkerVersionId:Ljava/lang/String;

    return-object v0
.end method

.method public name()Ljava/lang/String;
    .locals 1

    .line 40
    iget-object v0, p0, Lio/minio/messages/DeletedObject;->name:Ljava/lang/String;

    return-object v0
.end method

.method public versionId()Ljava/lang/String;
    .locals 1

    .line 44
    iget-object v0, p0, Lio/minio/messages/DeletedObject;->versionId:Ljava/lang/String;

    return-object v0
.end method
