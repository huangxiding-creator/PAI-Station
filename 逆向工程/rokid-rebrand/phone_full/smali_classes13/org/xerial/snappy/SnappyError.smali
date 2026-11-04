.class public Lorg/xerial/snappy/SnappyError;
.super Ljava/lang/Error;
.source "SnappyError.java"


# static fields
.field private static final serialVersionUID:J = 0x1L


# instance fields
.field public final errorCode:Lorg/xerial/snappy/SnappyErrorCode;


# direct methods
.method public constructor <init>(Lorg/xerial/snappy/SnappyErrorCode;)V
    .locals 0

    .line 44
    invoke-direct {p0}, Ljava/lang/Error;-><init>()V

    .line 45
    iput-object p1, p0, Lorg/xerial/snappy/SnappyError;->errorCode:Lorg/xerial/snappy/SnappyErrorCode;

    .line 46
    return-void
.end method

.method public constructor <init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/Error;)V
    .locals 0

    .line 50
    invoke-direct {p0, p2}, Ljava/lang/Error;-><init>(Ljava/lang/Throwable;)V

    .line 51
    iput-object p1, p0, Lorg/xerial/snappy/SnappyError;->errorCode:Lorg/xerial/snappy/SnappyErrorCode;

    .line 52
    return-void
.end method

.method public constructor <init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V
    .locals 0

    .line 56
    invoke-direct {p0, p2}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    .line 57
    iput-object p1, p0, Lorg/xerial/snappy/SnappyError;->errorCode:Lorg/xerial/snappy/SnappyErrorCode;

    .line 58
    return-void
.end method


# virtual methods
.method public getMessage()Ljava/lang/String;
    .locals 2

    .line 63
    iget-object v0, p0, Lorg/xerial/snappy/SnappyError;->errorCode:Lorg/xerial/snappy/SnappyErrorCode;

    invoke-virtual {v0}, Lorg/xerial/snappy/SnappyErrorCode;->name()Ljava/lang/String;

    move-result-object v0

    invoke-super {p0}, Ljava/lang/Error;->getMessage()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "[%s] %s"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
