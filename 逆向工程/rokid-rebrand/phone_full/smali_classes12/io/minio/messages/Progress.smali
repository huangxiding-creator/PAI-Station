.class public Lio/minio/messages/Progress;
.super Lio/minio/messages/Stats;
.source "Progress.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Progress"
    strict = false
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Lio/minio/messages/Stats;-><init>()V

    return-void
.end method
