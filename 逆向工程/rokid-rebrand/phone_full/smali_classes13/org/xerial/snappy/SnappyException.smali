.class public Lorg/xerial/snappy/SnappyException;
.super Ljava/lang/Exception;
.source "SnappyException.java"


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field private static final serialVersionUID:J = 0x1L


# instance fields
.field public final errorCode:Lorg/xerial/snappy/SnappyErrorCode;


# direct methods
.method public constructor <init>(I)V
    .locals 0

    .line 45
    invoke-static {p1}, Lorg/xerial/snappy/SnappyErrorCode;->getErrorCode(I)Lorg/xerial/snappy/SnappyErrorCode;

    move-result-object p1

    invoke-direct {p0, p1}, Lorg/xerial/snappy/SnappyException;-><init>(Lorg/xerial/snappy/SnappyErrorCode;)V

    .line 46
    return-void
.end method

.method public constructor <init>(Lorg/xerial/snappy/SnappyErrorCode;)V
    .locals 0

    .line 50
    invoke-direct {p0}, Ljava/lang/Exception;-><init>()V

    .line 51
    iput-object p1, p0, Lorg/xerial/snappy/SnappyException;->errorCode:Lorg/xerial/snappy/SnappyErrorCode;

    .line 52
    return-void
.end method

.method public constructor <init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/Exception;)V
    .locals 0

    .line 56
    invoke-direct {p0, p2}, Ljava/lang/Exception;-><init>(Ljava/lang/Throwable;)V

    .line 57
    iput-object p1, p0, Lorg/xerial/snappy/SnappyException;->errorCode:Lorg/xerial/snappy/SnappyErrorCode;

    .line 58
    return-void
.end method

.method public constructor <init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V
    .locals 0

    .line 62
    invoke-direct {p0, p2}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    .line 63
    iput-object p1, p0, Lorg/xerial/snappy/SnappyException;->errorCode:Lorg/xerial/snappy/SnappyErrorCode;

    .line 64
    return-void
.end method

.method public static throwException(I)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xerial/snappy/SnappyException;
        }
    .end annotation

    .line 74
    new-instance v0, Lorg/xerial/snappy/SnappyException;

    invoke-direct {v0, p0}, Lorg/xerial/snappy/SnappyException;-><init>(I)V

    throw v0
.end method


# virtual methods
.method public getErrorCode()Lorg/xerial/snappy/SnappyErrorCode;
    .locals 1

    .line 68
    iget-object v0, p0, Lorg/xerial/snappy/SnappyException;->errorCode:Lorg/xerial/snappy/SnappyErrorCode;

    return-object v0
.end method

.method public getMessage()Ljava/lang/String;
    .locals 2

    .line 80
    iget-object v0, p0, Lorg/xerial/snappy/SnappyException;->errorCode:Lorg/xerial/snappy/SnappyErrorCode;

    invoke-virtual {v0}, Lorg/xerial/snappy/SnappyErrorCode;->name()Ljava/lang/String;

    move-result-object v0

    invoke-super {p0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "[%s] %s"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
