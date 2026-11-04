.class public final Lcom/rokid/security/sdk/base/common/ota/SystemResponse;
.super Ljava/lang/Object;
.source "SystemResponse.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0011\n\u0002\u0010\t\n\u0002\u0008\u0008\n\u0002\u0010\u000b\n\u0002\u0008\n\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001e\u0010\u0003\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001e\u0010\t\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001e\u0010\u000c\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008R\u001e\u0010\u000f\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008R\u001e\u0010\u0012\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0006\"\u0004\u0008\u0014\u0010\u0008R\u001e\u0010\u0015\u001a\u00020\u00168\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0017\u0010\u0018\"\u0004\u0008\u0019\u0010\u001aR\u001e\u0010\u001b\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001c\u0010\u0006\"\u0004\u0008\u001d\u0010\u0008R\u001e\u0010\u001e\u001a\u00020\u001f8\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001e\u0010 \"\u0004\u0008!\u0010\"R\u001e\u0010#\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008$\u0010\u0006\"\u0004\u0008%\u0010\u0008R\u001e\u0010&\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\'\u0010\u0006\"\u0004\u0008(\u0010\u0008\u00a8\u0006)"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/ota/SystemResponse;",
        "",
        "()V",
        "authorize",
        "",
        "getAuthorize",
        "()Ljava/lang/String;",
        "setAuthorize",
        "(Ljava/lang/String;)V",
        "changelog",
        "getChangelog",
        "setChangelog",
        "checksum",
        "getChecksum",
        "setChecksum",
        "code",
        "getCode",
        "setCode",
        "errorMessage",
        "getErrorMessage",
        "setErrorMessage",
        "imageSize",
        "",
        "getImageSize",
        "()J",
        "setImageSize",
        "(J)V",
        "imageUrl",
        "getImageUrl",
        "setImageUrl",
        "isForceUpdate",
        "",
        "()Z",
        "setForceUpdate",
        "(Z)V",
        "packageChoice",
        "getPackageChoice",
        "setPackageChoice",
        "version",
        "getVersion",
        "setVersion",
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
.field private authorize:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "authorize"
    .end annotation
.end field

.field private changelog:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "changelog"
    .end annotation
.end field

.field private checksum:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "checksum"
    .end annotation
.end field

.field private code:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "code"
    .end annotation
.end field

.field private errorMessage:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "errorMessage"
    .end annotation
.end field

.field private imageSize:J
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        alternate = {
            "fileSize",
            "packageSize"
        }
        value = "imageSize"
    .end annotation
.end field

.field private imageUrl:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "imageUrl"
    .end annotation
.end field

.field private isForceUpdate:Z
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "isForceUpdate"
    .end annotation
.end field

.field private packageChoice:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "packageChoice"
    .end annotation
.end field

.field private version:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "version"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 13
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->imageUrl:Ljava/lang/String;

    .line 16
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->authorize:Ljava/lang/String;

    .line 19
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->errorMessage:Ljava/lang/String;

    .line 22
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->code:Ljava/lang/String;

    .line 25
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->changelog:Ljava/lang/String;

    .line 28
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->checksum:Ljava/lang/String;

    .line 34
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->version:Ljava/lang/String;

    .line 37
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->packageChoice:Ljava/lang/String;

    .line 9
    return-void
.end method


# virtual methods
.method public final getAuthorize()Ljava/lang/String;
    .locals 1

    .line 16
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->authorize:Ljava/lang/String;

    return-object v0
.end method

.method public final getChangelog()Ljava/lang/String;
    .locals 1

    .line 25
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->changelog:Ljava/lang/String;

    return-object v0
.end method

.method public final getChecksum()Ljava/lang/String;
    .locals 1

    .line 28
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->checksum:Ljava/lang/String;

    return-object v0
.end method

.method public final getCode()Ljava/lang/String;
    .locals 1

    .line 22
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->code:Ljava/lang/String;

    return-object v0
.end method

.method public final getErrorMessage()Ljava/lang/String;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->errorMessage:Ljava/lang/String;

    return-object v0
.end method

.method public final getImageSize()J
    .locals 2

    .line 40
    iget-wide v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->imageSize:J

    return-wide v0
.end method

.method public final getImageUrl()Ljava/lang/String;
    .locals 1

    .line 13
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->imageUrl:Ljava/lang/String;

    return-object v0
.end method

.method public final getPackageChoice()Ljava/lang/String;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->packageChoice:Ljava/lang/String;

    return-object v0
.end method

.method public final getVersion()Ljava/lang/String;
    .locals 1

    .line 34
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->version:Ljava/lang/String;

    return-object v0
.end method

.method public final isForceUpdate()Z
    .locals 1

    .line 31
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->isForceUpdate:Z

    return v0
.end method

.method public final setAuthorize(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 16
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->authorize:Ljava/lang/String;

    return-void
.end method

.method public final setChangelog(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->changelog:Ljava/lang/String;

    return-void
.end method

.method public final setChecksum(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->checksum:Ljava/lang/String;

    return-void
.end method

.method public final setCode(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->code:Ljava/lang/String;

    return-void
.end method

.method public final setErrorMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->errorMessage:Ljava/lang/String;

    return-void
.end method

.method public final setForceUpdate(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 31
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->isForceUpdate:Z

    return-void
.end method

.method public final setImageSize(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 40
    iput-wide p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->imageSize:J

    return-void
.end method

.method public final setImageUrl(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->imageUrl:Ljava/lang/String;

    return-void
.end method

.method public final setPackageChoice(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 37
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->packageChoice:Ljava/lang/String;

    return-void
.end method

.method public final setVersion(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 34
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/SystemResponse;->version:Ljava/lang/String;

    return-void
.end method
