.class public final Lcom/rokid/security/sdk/base/common/FileExtra;
.super Ljava/lang/Object;
.source "FileExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0008\n\u0002\u0010\t\n\u0002\u0008\u0008\n\u0002\u0010\u0007\n\u0002\u0008\u000b\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001c\u0010\t\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000e\u0010\u000f\"\u0004\u0008\u0010\u0010\u0011R\u001a\u0010\u0012\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0006\"\u0004\u0008\u0014\u0010\u0008R\u001a\u0010\u0015\u001a\u00020\u0016X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0017\u0010\u0018\"\u0004\u0008\u0019\u0010\u001aR\u001a\u0010\u001b\u001a\u00020\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001c\u0010\u000f\"\u0004\u0008\u001d\u0010\u0011R\u001a\u0010\u001e\u001a\u00020\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001f\u0010\u000f\"\u0004\u0008 \u0010\u0011\u00a8\u0006!"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/FileExtra;",
        "",
        "()V",
        "fileName",
        "",
        "getFileName",
        "()Ljava/lang/String;",
        "setFileName",
        "(Ljava/lang/String;)V",
        "filePath",
        "getFilePath",
        "setFilePath",
        "fileSize",
        "",
        "getFileSize",
        "()J",
        "setFileSize",
        "(J)V",
        "methodName",
        "getMethodName",
        "setMethodName",
        "progress",
        "",
        "getProgress",
        "()F",
        "setProgress",
        "(F)V",
        "totalBytes",
        "getTotalBytes",
        "setTotalBytes",
        "transferredBytes",
        "getTransferredBytes",
        "setTransferredBytes",
        "sdk-base-common_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private fileName:Ljava/lang/String;

.field private filePath:Ljava/lang/String;

.field private fileSize:J

.field private methodName:Ljava/lang/String;

.field private progress:F

.field private totalBytes:J

.field private transferredBytes:J


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->methodName:Ljava/lang/String;

    .line 25
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->fileName:Ljava/lang/String;

    .line 19
    return-void
.end method


# virtual methods
.method public final getFileName()Ljava/lang/String;
    .locals 1

    .line 25
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->fileName:Ljava/lang/String;

    return-object v0
.end method

.method public final getFilePath()Ljava/lang/String;
    .locals 1

    .line 22
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->filePath:Ljava/lang/String;

    return-object v0
.end method

.method public final getFileSize()J
    .locals 2

    .line 24
    iget-wide v0, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->fileSize:J

    return-wide v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getProgress()F
    .locals 1

    .line 21
    iget v0, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->progress:F

    return v0
.end method

.method public final getTotalBytes()J
    .locals 2

    .line 28
    iget-wide v0, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->totalBytes:J

    return-wide v0
.end method

.method public final getTransferredBytes()J
    .locals 2

    .line 27
    iget-wide v0, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->transferredBytes:J

    return-wide v0
.end method

.method public final setFileName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->fileName:Ljava/lang/String;

    return-void
.end method

.method public final setFilePath(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 22
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->filePath:Ljava/lang/String;

    return-void
.end method

.method public final setFileSize(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 24
    iput-wide p1, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->fileSize:J

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setProgress(F)V
    .locals 0
    .param p1, "<set-?>"    # F

    .line 21
    iput p1, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->progress:F

    return-void
.end method

.method public final setTotalBytes(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 28
    iput-wide p1, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->totalBytes:J

    return-void
.end method

.method public final setTransferredBytes(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 27
    iput-wide p1, p0, Lcom/rokid/security/sdk/base/common/FileExtra;->transferredBytes:J

    return-void
.end method
