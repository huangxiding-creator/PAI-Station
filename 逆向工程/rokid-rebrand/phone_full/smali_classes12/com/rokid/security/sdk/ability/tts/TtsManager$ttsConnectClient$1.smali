.class public final Lcom/rokid/security/sdk/ability/tts/TtsManager$ttsConnectClient$1;
.super Ljava/lang/Object;
.source "TtsManager.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/ability/tts/TtsManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0003*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0012\u0010\u0002\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u0008H\u0016J\u0008\u0010\t\u001a\u00020\u0003H\u0016J\u0008\u0010\n\u001a\u00020\u0003H\u0016\u00a8\u0006\u000b"
    }
    d2 = {
        "com/rokid/security/sdk/ability/tts/TtsManager$ttsConnectClient$1",
        "Lcom/rokid/security/sdk/ability/tts/TtsConnectClient$TtsListener;",
        "onAudioStreamResult",
        "",
        "text",
        "",
        "onError",
        "code",
        "",
        "onFinish",
        "onStart",
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

    .line 80
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAudioStreamResult([B)V
    .locals 1
    .param p1, "text"    # [B

    .line 82
    if-eqz p1, :cond_0

    invoke-static {}, Lcom/rokid/security/sdk/ability/tts/TtsManager;->access$isPlaying$p()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 84
    sget-object v0, Lcom/rokid/security/sdk/ability/message/SenderHandler;->INSTANCE:Lcom/rokid/security/sdk/ability/message/SenderHandler;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/message/SenderHandler;->sendAudioStreamData([B)V

    .line 87
    :cond_0
    return-void
.end method

.method public onError(I)V
    .locals 3
    .param p1, "code"    # I

    .line 96
    invoke-static {}, Lcom/rokid/security/sdk/ability/tts/TtsManager;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onError code:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 97
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsManager;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/tts/TtsManager;->handleError(I)V

    .line 98
    return-void
.end method

.method public onFinish()V
    .locals 2

    .line 101
    invoke-static {}, Lcom/rokid/security/sdk/ability/tts/TtsManager;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onFinish"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 102
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsManager;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsManager;->controlTtsEvent(Z)V

    .line 104
    return-void
.end method

.method public onStart()V
    .locals 2

    .line 91
    invoke-static {}, Lcom/rokid/security/sdk/ability/tts/TtsManager;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onStart"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 92
    sget-object v0, Lcom/rokid/security/sdk/ability/tts/TtsManager;->INSTANCE:Lcom/rokid/security/sdk/ability/tts/TtsManager;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/tts/TtsManager;->controlTtsEvent(Z)V

    .line 93
    return-void
.end method
