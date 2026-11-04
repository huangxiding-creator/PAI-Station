.class public final Lcom/rokid/security/sdk/base/common/FileProperties;
.super Ljava/lang/Object;
.source "FileProperties.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u000e\n\u0002\u0010\u000b\n\u0002\u0008\u0004\n\u0002\u0010\t\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R \u0010\u0003\u001a\u0004\u0018\u00010\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R \u0010\t\u001a\u0004\u0018\u00010\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001e\u0010\u000c\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008R\u001e\u0010\u000f\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008R\u001e\u0010\u0012\u001a\u00020\u00138\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0012\u0010\u0014\"\u0004\u0008\u0015\u0010\u0016R\u001e\u0010\u0017\u001a\u00020\u00188\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0019\u0010\u001a\"\u0004\u0008\u001b\u0010\u001c\u00a8\u0006\u001d"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/FileProperties;",
        "",
        "()V",
        "fileBase64",
        "",
        "getFileBase64",
        "()Ljava/lang/String;",
        "setFileBase64",
        "(Ljava/lang/String;)V",
        "fileExtension",
        "getFileExtension",
        "setFileExtension",
        "fileMd5",
        "getFileMd5",
        "setFileMd5",
        "filePath",
        "getFilePath",
        "setFilePath",
        "isEnd",
        "",
        "()Z",
        "setEnd",
        "(Z)V",
        "totalSize",
        "",
        "getTotalSize",
        "()J",
        "setTotalSize",
        "(J)V",
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
.field private fileBase64:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "fileBase64"
    .end annotation
.end field

.field private fileExtension:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "fileExtension"
    .end annotation
.end field

.field private fileMd5:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "fileMd5"
    .end annotation
.end field

.field private filePath:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "filePath"
    .end annotation
.end field

.field private isEnd:Z
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "isEnd"
    .end annotation
.end field

.field private totalSize:J
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "totalSize"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->filePath:Ljava/lang/String;

    .line 21
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->fileMd5:Ljava/lang/String;

    .line 9
    return-void
.end method


# virtual methods
.method public final getFileBase64()Ljava/lang/String;
    .locals 1

    .line 27
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->fileBase64:Ljava/lang/String;

    return-object v0
.end method

.method public final getFileExtension()Ljava/lang/String;
    .locals 1

    .line 15
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->fileExtension:Ljava/lang/String;

    return-object v0
.end method

.method public final getFileMd5()Ljava/lang/String;
    .locals 1

    .line 21
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->fileMd5:Ljava/lang/String;

    return-object v0
.end method

.method public final getFilePath()Ljava/lang/String;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->filePath:Ljava/lang/String;

    return-object v0
.end method

.method public final getTotalSize()J
    .locals 2

    .line 18
    iget-wide v0, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->totalSize:J

    return-wide v0
.end method

.method public final isEnd()Z
    .locals 1

    .line 24
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->isEnd:Z

    return v0
.end method

.method public final setEnd(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 24
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->isEnd:Z

    return-void
.end method

.method public final setFileBase64(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 27
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->fileBase64:Ljava/lang/String;

    return-void
.end method

.method public final setFileExtension(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 15
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->fileExtension:Ljava/lang/String;

    return-void
.end method

.method public final setFileMd5(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->fileMd5:Ljava/lang/String;

    return-void
.end method

.method public final setFilePath(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->filePath:Ljava/lang/String;

    return-void
.end method

.method public final setTotalSize(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 18
    iput-wide p1, p0, Lcom/rokid/security/sdk/base/common/FileProperties;->totalSize:J

    return-void
.end method
