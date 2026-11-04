.class public Lio/minio/messages/DeleteRequest;
.super Ljava/lang/Object;
.source "DeleteRequest.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Delete"
.end annotation


# instance fields
.field private objectList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/messages/DeleteObject;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementList;
        inline = true
        name = "Object"
    .end annotation
.end field

.field private quiet:Z
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Quiet"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/util/List;Z)V
    .locals 1
    .param p2, "quiet"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lio/minio/messages/DeleteObject;",
            ">;Z)V"
        }
    .end annotation

    .line 43
    .local p1, "objectList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    invoke-static {p1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lio/minio/messages/DeleteRequest;->objectList:Ljava/util/List;

    .line 45
    iput-boolean p2, p0, Lio/minio/messages/DeleteRequest;->quiet:Z

    .line 46
    return-void
.end method
