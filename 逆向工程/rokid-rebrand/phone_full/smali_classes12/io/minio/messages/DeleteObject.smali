.class public Lio/minio/messages/DeleteObject;
.super Ljava/lang/Object;
.source "DeleteObject.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Object"
.end annotation


# instance fields
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
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "name"    # Ljava/lang/String;

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    iput-object p1, p0, Lio/minio/messages/DeleteObject;->name:Ljava/lang/String;

    .line 34
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "versionId"    # Ljava/lang/String;

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    iput-object p1, p0, Lio/minio/messages/DeleteObject;->name:Ljava/lang/String;

    .line 38
    iput-object p2, p0, Lio/minio/messages/DeleteObject;->versionId:Ljava/lang/String;

    .line 39
    return-void
.end method
