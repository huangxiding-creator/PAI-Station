.class public final Lcom/rokid/security/sdk/base/common/FileSystemExtra;
.super Ljava/lang/Object;
.source "FileSystemExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0014\n\u0002\u0010\t\n\u0002\u0008\u0008\n\u0002\u0010\u0007\n\u0002\u0008\u0008\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008R\u001a\u0010\u000f\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008R\u001a\u0010\u0012\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0006\"\u0004\u0008\u0014\u0010\u0008R\u001a\u0010\u0015\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0016\u0010\u0006\"\u0004\u0008\u0017\u0010\u0008R\u001a\u0010\u0018\u001a\u00020\u0019X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001a\u0010\u001b\"\u0004\u0008\u001c\u0010\u001dR\u001a\u0010\u001e\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001f\u0010\u0006\"\u0004\u0008 \u0010\u0008R\u001a\u0010!\u001a\u00020\"X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008#\u0010$\"\u0004\u0008%\u0010&R\u001a\u0010\'\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008(\u0010\u0006\"\u0004\u0008)\u0010\u0008\u00a8\u0006*"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/FileSystemExtra;",
        "",
        "()V",
        "deviceMetaJson",
        "",
        "getDeviceMetaJson",
        "()Ljava/lang/String;",
        "setDeviceMetaJson",
        "(Ljava/lang/String;)V",
        "errorMsg",
        "getErrorMsg",
        "setErrorMsg",
        "fileId",
        "getFileId",
        "setFileId",
        "fileMd5",
        "getFileMd5",
        "setFileMd5",
        "filePath",
        "getFilePath",
        "setFilePath",
        "fileUrl",
        "getFileUrl",
        "setFileUrl",
        "lastModifiedTime",
        "",
        "getLastModifiedTime",
        "()J",
        "setLastModifiedTime",
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
        "tag",
        "getTag",
        "setTag",
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
.field private deviceMetaJson:Ljava/lang/String;

.field private errorMsg:Ljava/lang/String;

.field private fileId:Ljava/lang/String;

.field private fileMd5:Ljava/lang/String;

.field private filePath:Ljava/lang/String;

.field private fileUrl:Ljava/lang/String;

.field private lastModifiedTime:J

.field private methodName:Ljava/lang/String;

.field private progress:F

.field private tag:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->methodName:Ljava/lang/String;

    .line 17
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->filePath:Ljava/lang/String;

    .line 20
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->tag:Ljava/lang/String;

    .line 21
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->deviceMetaJson:Ljava/lang/String;

    .line 23
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->fileId:Ljava/lang/String;

    .line 24
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->fileUrl:Ljava/lang/String;

    .line 26
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->errorMsg:Ljava/lang/String;

    .line 27
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->fileMd5:Ljava/lang/String;

    .line 14
    return-void
.end method


# virtual methods
.method public final getDeviceMetaJson()Ljava/lang/String;
    .locals 1

    .line 21
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->deviceMetaJson:Ljava/lang/String;

    return-object v0
.end method

.method public final getErrorMsg()Ljava/lang/String;
    .locals 1

    .line 26
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->errorMsg:Ljava/lang/String;

    return-object v0
.end method

.method public final getFileId()Ljava/lang/String;
    .locals 1

    .line 23
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->fileId:Ljava/lang/String;

    return-object v0
.end method

.method public final getFileMd5()Ljava/lang/String;
    .locals 1

    .line 27
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->fileMd5:Ljava/lang/String;

    return-object v0
.end method

.method public final getFilePath()Ljava/lang/String;
    .locals 1

    .line 17
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->filePath:Ljava/lang/String;

    return-object v0
.end method

.method public final getFileUrl()Ljava/lang/String;
    .locals 1

    .line 24
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->fileUrl:Ljava/lang/String;

    return-object v0
.end method

.method public final getLastModifiedTime()J
    .locals 2

    .line 18
    iget-wide v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->lastModifiedTime:J

    return-wide v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 16
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getProgress()F
    .locals 1

    .line 25
    iget v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->progress:F

    return v0
.end method

.method public final getTag()Ljava/lang/String;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->tag:Ljava/lang/String;

    return-object v0
.end method

.method public final setDeviceMetaJson(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->deviceMetaJson:Ljava/lang/String;

    return-void
.end method

.method public final setErrorMsg(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 26
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->errorMsg:Ljava/lang/String;

    return-void
.end method

.method public final setFileId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 23
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->fileId:Ljava/lang/String;

    return-void
.end method

.method public final setFileMd5(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 27
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->fileMd5:Ljava/lang/String;

    return-void
.end method

.method public final setFilePath(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 17
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->filePath:Ljava/lang/String;

    return-void
.end method

.method public final setFileUrl(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->fileUrl:Ljava/lang/String;

    return-void
.end method

.method public final setLastModifiedTime(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 18
    iput-wide p1, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->lastModifiedTime:J

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 16
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setProgress(F)V
    .locals 0
    .param p1, "<set-?>"    # F

    .line 25
    iput p1, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->progress:F

    return-void
.end method

.method public final setTag(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->tag:Ljava/lang/String;

    return-void
.end method
