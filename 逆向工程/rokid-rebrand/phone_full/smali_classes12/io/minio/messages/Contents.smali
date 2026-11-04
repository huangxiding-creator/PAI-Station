.class public Lio/minio/messages/Contents;
.super Lio/minio/messages/Item;
.source "Contents.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Contents"
    strict = false
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Lio/minio/messages/Item;-><init>()V

    .line 29
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;

    .line 32
    invoke-direct {p0, p1}, Lio/minio/messages/Item;-><init>(Ljava/lang/String;)V

    .line 33
    return-void
.end method
