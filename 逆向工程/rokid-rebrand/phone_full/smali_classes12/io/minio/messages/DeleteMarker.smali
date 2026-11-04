.class public Lio/minio/messages/DeleteMarker;
.super Lio/minio/messages/Item;
.source "DeleteMarker.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "DeleteMarker"
    strict = false
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Lio/minio/messages/Item;-><init>()V

    .line 26
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;

    .line 29
    invoke-direct {p0, p1}, Lio/minio/messages/Item;-><init>(Ljava/lang/String;)V

    .line 30
    return-void
.end method
