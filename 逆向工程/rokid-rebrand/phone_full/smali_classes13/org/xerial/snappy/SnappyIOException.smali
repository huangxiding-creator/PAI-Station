.class public Lorg/xerial/snappy/SnappyIOException;
.super Ljava/io/IOException;
.source "SnappyIOException.java"


# instance fields
.field private final errorCode:Lorg/xerial/snappy/SnappyErrorCode;


# direct methods
.method public constructor <init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V
    .locals 0

    .line 15
    invoke-direct {p0, p2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 16
    iput-object p1, p0, Lorg/xerial/snappy/SnappyIOException;->errorCode:Lorg/xerial/snappy/SnappyErrorCode;

    .line 17
    return-void
.end method


# virtual methods
.method public getErrorCode()Lorg/xerial/snappy/SnappyErrorCode;
    .locals 1

    .line 25
    iget-object v0, p0, Lorg/xerial/snappy/SnappyIOException;->errorCode:Lorg/xerial/snappy/SnappyErrorCode;

    return-object v0
.end method

.method public getMessage()Ljava/lang/String;
    .locals 2

    .line 22
    iget-object v0, p0, Lorg/xerial/snappy/SnappyIOException;->errorCode:Lorg/xerial/snappy/SnappyErrorCode;

    invoke-virtual {v0}, Lorg/xerial/snappy/SnappyErrorCode;->name()Ljava/lang/String;

    move-result-object v0

    invoke-super {p0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "[%s] %s"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
