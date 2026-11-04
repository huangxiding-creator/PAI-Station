.class public Lio/minio/errors/InsufficientDataException;
.super Lio/minio/errors/MinioException;
.source "InsufficientDataException.java"


# static fields
.field private static final serialVersionUID:J = -0x167a661d04487436L


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;

    .line 27
    invoke-direct {p0, p1}, Lio/minio/errors/MinioException;-><init>(Ljava/lang/String;)V

    .line 28
    return-void
.end method
