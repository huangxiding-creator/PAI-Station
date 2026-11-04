.class public final Lcom/rokid/security/sdk/base/common/TranslateExtra;
.super Ljava/lang/Object;
.source "TranslateExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u000e\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008R\u001a\u0010\u000f\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/TranslateExtra;",
        "",
        "()V",
        "dest",
        "",
        "getDest",
        "()Ljava/lang/String;",
        "setDest",
        "(Ljava/lang/String;)V",
        "methodName",
        "getMethodName",
        "setMethodName",
        "src",
        "getSrc",
        "setSrc",
        "text",
        "getText",
        "setText",
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
.field private dest:Ljava/lang/String;

.field private methodName:Ljava/lang/String;

.field private src:Ljava/lang/String;

.field private text:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/TranslateExtra;->methodName:Ljava/lang/String;

    .line 22
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/TranslateExtra;->text:Ljava/lang/String;

    .line 25
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/TranslateExtra;->src:Ljava/lang/String;

    .line 28
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/TranslateExtra;->dest:Ljava/lang/String;

    .line 18
    return-void
.end method


# virtual methods
.method public final getDest()Ljava/lang/String;
    .locals 1

    .line 28
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/TranslateExtra;->dest:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/TranslateExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getSrc()Ljava/lang/String;
    .locals 1

    .line 25
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/TranslateExtra;->src:Ljava/lang/String;

    return-object v0
.end method

.method public final getText()Ljava/lang/String;
    .locals 1

    .line 22
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/TranslateExtra;->text:Ljava/lang/String;

    return-object v0
.end method

.method public final setDest(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/TranslateExtra;->dest:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/TranslateExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setSrc(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/TranslateExtra;->src:Ljava/lang/String;

    return-void
.end method

.method public final setText(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/TranslateExtra;->text:Ljava/lang/String;

    return-void
.end method
