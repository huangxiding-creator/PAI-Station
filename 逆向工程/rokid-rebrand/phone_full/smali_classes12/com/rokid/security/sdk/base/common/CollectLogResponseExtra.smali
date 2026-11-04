.class public final Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;
.super Ljava/lang/Object;
.source "RequestCollectLogExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0008\n\u0002\u0010\u000b\n\u0002\u0008\n\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u000c\"\u0004\u0008\u0011\u0010\u000eR\u001a\u0010\u0012\u001a\u00020\u0013X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0012\u0010\u0014\"\u0004\u0008\u0015\u0010\u0016R\u001a\u0010\u0017\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0018\u0010\u000c\"\u0004\u0008\u0019\u0010\u000eR\u001a\u0010\u001a\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001b\u0010\u000c\"\u0004\u0008\u001c\u0010\u000e\u00a8\u0006\u001d"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;",
        "",
        "()V",
        "errorCode",
        "",
        "getErrorCode",
        "()I",
        "setErrorCode",
        "(I)V",
        "errorMsg",
        "",
        "getErrorMsg",
        "()Ljava/lang/String;",
        "setErrorMsg",
        "(Ljava/lang/String;)V",
        "filePath",
        "getFilePath",
        "setFilePath",
        "isSuccess",
        "",
        "()Z",
        "setSuccess",
        "(Z)V",
        "methodName",
        "getMethodName",
        "setMethodName",
        "sn",
        "getSn",
        "setSn",
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
.field private errorCode:I

.field private errorMsg:Ljava/lang/String;

.field private filePath:Ljava/lang/String;

.field private isSuccess:Z

.field private methodName:Ljava/lang/String;

.field private sn:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->methodName:Ljava/lang/String;

    .line 17
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->filePath:Ljava/lang/String;

    .line 18
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->sn:Ljava/lang/String;

    .line 20
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->errorMsg:Ljava/lang/String;

    .line 15
    return-void
.end method


# virtual methods
.method public final getErrorCode()I
    .locals 1

    .line 21
    iget v0, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->errorCode:I

    return v0
.end method

.method public final getErrorMsg()Ljava/lang/String;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->errorMsg:Ljava/lang/String;

    return-object v0
.end method

.method public final getFilePath()Ljava/lang/String;
    .locals 1

    .line 17
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->filePath:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 16
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getSn()Ljava/lang/String;
    .locals 1

    .line 18
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->sn:Ljava/lang/String;

    return-object v0
.end method

.method public final isSuccess()Z
    .locals 1

    .line 19
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->isSuccess:Z

    return v0
.end method

.method public final setErrorCode(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 21
    iput p1, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->errorCode:I

    return-void
.end method

.method public final setErrorMsg(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->errorMsg:Ljava/lang/String;

    return-void
.end method

.method public final setFilePath(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 17
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->filePath:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 16
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setSn(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 18
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->sn:Ljava/lang/String;

    return-void
.end method

.method public final setSuccess(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 19
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->isSuccess:Z

    return-void
.end method
