.class public Lio/minio/messages/DeleteError;
.super Lio/minio/messages/ErrorResponse;
.source "DeleteError.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Error"
    strict = false
.end annotation


# static fields
.field private static final serialVersionUID:J = 0x1a707ec87e00a98fL


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Lio/minio/messages/ErrorResponse;-><init>()V

    return-void
.end method
