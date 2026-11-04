.class public Lio/minio/errors/InternalException;
.super Lio/minio/errors/MinioException;
.source "InternalException.java"


# static fields
.field private static final serialVersionUID:J = 0x1eb781ef8c91780L


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "httpTrace"    # Ljava/lang/String;

    .line 27
    invoke-direct {p0, p1, p2}, Lio/minio/errors/MinioException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 28
    return-void
.end method
