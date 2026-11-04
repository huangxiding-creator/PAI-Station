.class public final Lcom/rokid/security/sdk/ability/asr/AsrEngine$init$1;
.super Ljava/lang/Object;
.source "AsrEngine.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/asr/AsrEngine;->init(Lcom/rokid/security/sdk/ability/bean/BaseConfig;Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;)V
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
        "com/rokid/security/sdk/ability/asr/AsrEngine$init$1",
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

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed()V
    .locals 2

    .line 78
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->getTAG()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onClosed-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 79
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->getConnectState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 80
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->setConnectState(Z)V

    .line 82
    :cond_0
    return-void
.end method

.method public onClosing()V
    .locals 2

    .line 62
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->getTAG()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onClosing-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 63
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->getConnectState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 64
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->setConnectState(Z)V

    .line 66
    :cond_0
    return-void
.end method

.method public onFailure()V
    .locals 2

    .line 70
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->getTAG()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onFailure-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 71
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->getConnectState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 72
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->setConnectState(Z)V

    .line 74
    :cond_0
    return-void
.end method

.method public onMessage(Ljava/lang/String;)V
    .locals 3
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 44
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->getTAG()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onMessage chars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 45
    return-void
.end method

.method public onMessage(Lokio/ByteString;)V
    .locals 1
    .param p1, "byteArray"    # Lokio/ByteString;

    const-string v0, "byteArray"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 49
    return-void
.end method

.method public onOpen()V
    .locals 2

    .line 38
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->getTAG()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onOpen-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 39
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->setConnectState(Z)V

    .line 40
    return-void
.end method

.method public onReconnecting()V
    .locals 2

    .line 53
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->getTAG()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onReconnecting-->"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 54
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->getConnectState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 55
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrEngine;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/asr/AsrEngine;->setConnectState(Z)V

    .line 58
    :cond_0
    return-void
.end method
