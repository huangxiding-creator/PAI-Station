.class public final Lcom/rokid/security/sdk/ability/tts/TtsEngine$init$1;
.super Ljava/lang/Object;
.source "TtsEngine.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/tts/TtsEngine;->init(Lcom/rokid/security/sdk/ability/bean/BaseConfig;Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H\u0016J\u0008\u0010\u0004\u001a\u00020\u0003H\u0016J\u0008\u0010\u0005\u001a\u00020\u0003H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u0008H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\t\u001a\u00020\nH\u0016J\u0008\u0010\u000b\u001a\u00020\u0003H\u0016J\u0008\u0010\u000c\u001a\u00020\u0003H\u0016\u00a8\u0006\r"
    }
    d2 = {
        "com/rokid/security/sdk/ability/tts/TtsEngine$init$1",
        "Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;",
        "onClosed",
        "",
        "onClosing",
        "onFailure",
        "onMessage",
        "msg",
        "",
        "byteArray",
        "Lokio/ByteString;",
        "onOpen",
        "onReconnecting",
        "sdk-common-ability_release"
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

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed()V
    .locals 2

    .line 66
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->getTAG()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onClosed-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 67
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->setConnectState(Z)V

    .line 68
    return-void
.end method

.method public onClosing()V
    .locals 2

    .line 56
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->getTAG()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onClosing-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 57
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->setConnectState(Z)V

    .line 58
    return-void
.end method

.method public onFailure()V
    .locals 2

    .line 61
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->getTAG()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onFailure-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 62
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->setConnectState(Z)V

    .line 63
    return-void
.end method

.method public onMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 44
    return-void
.end method

.method public onMessage(Lokio/ByteString;)V
    .locals 1
    .param p1, "byteArray"    # Lokio/ByteString;

    const-string v0, "byteArray"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 48
    return-void
.end method

.method public onOpen()V
    .locals 2

    .line 38
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->getTAG()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onOpen-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 39
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->setConnectState(Z)V

    .line 40
    return-void
.end method

.method public onReconnecting()V
    .locals 2

    .line 51
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->getTAG()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onReconnecting-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 52
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsEngine;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsEngine;->setConnectState(Z)V

    .line 53
    return-void
.end method
