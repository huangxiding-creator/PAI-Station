.class public Lio/minio/errors/ServerException;
.super Lio/minio/errors/MinioException;
.source "ServerException.java"


# static fields
.field private static final serialVersionUID:J = 0x58c051f38e188c99L


# instance fields
.field private statusCode:I


# direct methods
.method public constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "statusCode"    # I
    .param p3, "httpTrace"    # Ljava/lang/String;

    .line 26
    invoke-direct {p0, p1, p3}, Lio/minio/errors/MinioException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 27
    iput p2, p0, Lio/minio/errors/ServerException;->statusCode:I

    .line 28
    return-void
.end method


# virtual methods
.method public statusCode()I
    .locals 1

    .line 31
    iget v0, p0, Lio/minio/errors/ServerException;->statusCode:I

    return v0
.end method
