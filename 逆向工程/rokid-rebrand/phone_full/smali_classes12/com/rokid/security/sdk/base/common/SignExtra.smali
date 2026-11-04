.class public final Lcom/rokid/security/sdk/base/common/SignExtra;
.super Ljava/lang/Object;
.source "DeviceAuthExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u000e\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008R\u001a\u0010\u000f\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/SignExtra;",
        "",
        "()V",
        "methodName",
        "",
        "getMethodName",
        "()Ljava/lang/String;",
        "setMethodName",
        "(Ljava/lang/String;)V",
        "nonceGlassB64",
        "getNonceGlassB64",
        "setNonceGlassB64",
        "noncePhoneB64",
        "getNoncePhoneB64",
        "setNoncePhoneB64",
        "signature",
        "getSignature",
        "setSignature",
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
.field private methodName:Ljava/lang/String;

.field private nonceGlassB64:Ljava/lang/String;

.field private noncePhoneB64:Ljava/lang/String;

.field private signature:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/SignExtra;->methodName:Ljava/lang/String;

    .line 42
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/SignExtra;->nonceGlassB64:Ljava/lang/String;

    .line 43
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/SignExtra;->noncePhoneB64:Ljava/lang/String;

    .line 44
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/SignExtra;->signature:Ljava/lang/String;

    .line 40
    return-void
.end method


# virtual methods
.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 41
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SignExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getNonceGlassB64()Ljava/lang/String;
    .locals 1

    .line 42
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SignExtra;->nonceGlassB64:Ljava/lang/String;

    return-object v0
.end method

.method public final getNoncePhoneB64()Ljava/lang/String;
    .locals 1

    .line 43
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SignExtra;->noncePhoneB64:Ljava/lang/String;

    return-object v0
.end method

.method public final getSignature()Ljava/lang/String;
    .locals 1

    .line 44
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SignExtra;->signature:Ljava/lang/String;

    return-object v0
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 41
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SignExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setNonceGlassB64(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SignExtra;->nonceGlassB64:Ljava/lang/String;

    return-void
.end method

.method public final setNoncePhoneB64(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SignExtra;->noncePhoneB64:Ljava/lang/String;

    return-void
.end method

.method public final setSignature(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 44
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SignExtra;->signature:Ljava/lang/String;

    return-void
.end method
