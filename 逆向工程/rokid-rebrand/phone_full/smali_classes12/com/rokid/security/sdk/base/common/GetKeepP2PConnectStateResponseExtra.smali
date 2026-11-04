.class public final Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateResponseExtra;
.super Ljava/lang/Object;
.source "ConnectP2PRequestExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0003\u0010\u0005\"\u0004\u0008\u0006\u0010\u0007R\u001a\u0010\u0008\u001a\u00020\tX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u000b\"\u0004\u0008\u000c\u0010\r\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateResponseExtra;",
        "",
        "()V",
        "isOpen",
        "",
        "()Z",
        "setOpen",
        "(Z)V",
        "methodName",
        "",
        "getMethodName",
        "()Ljava/lang/String;",
        "setMethodName",
        "(Ljava/lang/String;)V",
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
.field private isOpen:Z

.field private methodName:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 50
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateResponseExtra;->methodName:Ljava/lang/String;

    .line 49
    return-void
.end method


# virtual methods
.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 50
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateResponseExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final isOpen()Z
    .locals 1

    .line 51
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateResponseExtra;->isOpen:Z

    return v0
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 50
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateResponseExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setOpen(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 51
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateResponseExtra;->isOpen:Z

    return-void
.end method
