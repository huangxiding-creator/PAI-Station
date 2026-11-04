.class public Lio/minio/messages/RequestProgress;
.super Ljava/lang/Object;
.source "RequestProgress.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "RequestProgress"
    strict = false
.end annotation


# instance fields
.field private enabled:Z
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Enabled"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 29
    const/4 v0, 0x1

    iput-boolean v0, p0, Lio/minio/messages/RequestProgress;->enabled:Z

    .line 33
    return-void
.end method
