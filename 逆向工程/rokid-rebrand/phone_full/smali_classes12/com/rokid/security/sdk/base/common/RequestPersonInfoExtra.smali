.class public final Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;
.super Ljava/lang/Object;
.source "OfflineRecExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u000b\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;",
        "",
        "()V",
        "extraType",
        "",
        "getExtraType",
        "()Ljava/lang/String;",
        "setExtraType",
        "(Ljava/lang/String;)V",
        "methodName",
        "getMethodName",
        "setMethodName",
        "personnelId",
        "getPersonnelId",
        "setPersonnelId",
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
.field private extraType:Ljava/lang/String;

.field private methodName:Ljava/lang/String;

.field private personnelId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    const-string v0, "RequestPersonInfo"

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;->extraType:Ljava/lang/String;

    .line 37
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;->methodName:Ljava/lang/String;

    .line 38
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;->personnelId:Ljava/lang/String;

    .line 35
    return-void
.end method


# virtual methods
.method public final getExtraType()Ljava/lang/String;
    .locals 1

    .line 36
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;->extraType:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getPersonnelId()Ljava/lang/String;
    .locals 1

    .line 38
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;->personnelId:Ljava/lang/String;

    return-object v0
.end method

.method public final setExtraType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 36
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;->extraType:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 37
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setPersonnelId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 38
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;->personnelId:Ljava/lang/String;

    return-void
.end method
