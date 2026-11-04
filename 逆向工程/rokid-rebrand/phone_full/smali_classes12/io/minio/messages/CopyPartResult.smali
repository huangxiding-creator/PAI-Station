.class public Lio/minio/messages/CopyPartResult;
.super Lio/minio/messages/CopyObjectResult;
.source "CopyPartResult.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "CopyPartResult"
    strict = false
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Lio/minio/messages/CopyObjectResult;-><init>()V

    return-void
.end method
