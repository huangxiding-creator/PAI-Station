.class public final Lcom/rokid/security/phone/sdk/server/translate/TranslateManager$initTranslate$1;
.super Ljava/lang/Object;
.source "TranslateManager.kt"

# interfaces
.implements Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->initTranslate()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0005*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H\u0016J\u001a\u0010\u0004\u001a\u00020\u00032\u0006\u0010\u0005\u001a\u00020\u00062\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u0008H\u0016J\u0008\u0010\t\u001a\u00020\u0003H\u0016J\u0012\u0010\n\u001a\u00020\u00032\u0008\u0010\u000b\u001a\u0004\u0018\u00010\u0008H\u0016J\u0012\u0010\u000c\u001a\u00020\u00032\u0008\u0010\u000b\u001a\u0004\u0018\u00010\u0008H\u0016\u00a8\u0006\r"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/translate/TranslateManager$initTranslate$1",
        "Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;",
        "onEnd",
        "",
        "onError",
        "code",
        "",
        "message",
        "",
        "onStart",
        "onTranslateFinalResult",
        "text",
        "onTranslateResult",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEnd()V
    .locals 2

    .line 88
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->access$setTranslateStart$p(Z)V

    .line 92
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

    const-string v1, "onEnd"

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->onStartOrEnd(Ljava/lang/String;)V

    .line 94
    return-void
.end method

.method public onError(ILjava/lang/String;)V
    .locals 0
    .param p1, "code"    # I
    .param p2, "message"    # Ljava/lang/String;

    .line 85
    return-void
.end method

.method public onStart()V
    .locals 2

    .line 66
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

    const/4 v0, 0x1

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->access$setTranslateStart$p(Z)V

    .line 67
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

    const-string v1, "onStart"

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->onStartOrEnd(Ljava/lang/String;)V

    .line 68
    return-void
.end method

.method public onTranslateFinalResult(Ljava/lang/String;)V
    .locals 2
    .param p1, "text"    # Ljava/lang/String;

    .line 78
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    move v0, v1

    :goto_1
    if-nez v0, :cond_2

    .line 79
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

    invoke-virtual {v0, p1, v1}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->onTranslate(Ljava/lang/String;Z)V

    .line 81
    :cond_2
    return-void
.end method

.method public onTranslateResult(Ljava/lang/String;)V
    .locals 4
    .param p1, "text"    # Ljava/lang/String;

    .line 72
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    move v0, v1

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    if-nez v0, :cond_2

    .line 73
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {v0, p1, v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->onTranslate$default(Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;Ljava/lang/String;ZILjava/lang/Object;)V

    .line 75
    :cond_2
    return-void
.end method
