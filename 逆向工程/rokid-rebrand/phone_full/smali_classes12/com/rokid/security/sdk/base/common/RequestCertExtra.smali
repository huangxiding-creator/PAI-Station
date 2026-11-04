.class public final Lcom/rokid/security/sdk/base/common/RequestCertExtra;
.super Ljava/lang/Object;
.source "CertExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u000b\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/RequestCertExtra;",
        "",
        "()V",
        "methodName",
        "",
        "getMethodName",
        "()Ljava/lang/String;",
        "setMethodName",
        "(Ljava/lang/String;)V",
        "sm2p10",
        "getSm2p10",
        "setSm2p10",
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
.field private methodName:Ljava/lang/String;

.field private sm2p10:Ljava/lang/String;

.field private sn:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestCertExtra;->methodName:Ljava/lang/String;

    .line 31
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestCertExtra;->sm2p10:Ljava/lang/String;

    .line 32
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestCertExtra;->sn:Ljava/lang/String;

    .line 29
    return-void
.end method


# virtual methods
.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 30
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestCertExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getSm2p10()Ljava/lang/String;
    .locals 1

    .line 31
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestCertExtra;->sm2p10:Ljava/lang/String;

    return-object v0
.end method

.method public final getSn()Ljava/lang/String;
    .locals 1

    .line 32
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestCertExtra;->sn:Ljava/lang/String;

    return-object v0
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 30
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestCertExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setSm2p10(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 31
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestCertExtra;->sm2p10:Ljava/lang/String;

    return-void
.end method

.method public final setSn(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 32
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestCertExtra;->sn:Ljava/lang/String;

    return-void
.end method
