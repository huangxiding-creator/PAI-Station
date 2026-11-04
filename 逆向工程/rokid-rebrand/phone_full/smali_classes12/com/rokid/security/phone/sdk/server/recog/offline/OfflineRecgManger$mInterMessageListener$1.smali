.class public final Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1;
.super Ljava/lang/Object;
.source "OfflineRecgManger.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001f\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0005*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J \u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\u0005H\u0016J\u0010\u0010\t\u001a\u00020\u00032\u0006\u0010\n\u001a\u00020\u0005H\u0016J\u0010\u0010\u000b\u001a\u00020\u00032\u0006\u0010\n\u001a\u00020\u0005H\u0016\u00a8\u0006\u000c"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;",
        "onBTStreamDataReceived",
        "",
        "tag",
        "",
        "data",
        "",
        "clientId",
        "onClassicBTTextMessage",
        "msg",
        "onP2PTextMessage",
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

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAudioStream(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 45
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onAudioStream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/nio/ByteBuffer;)V

    return-void
.end method

.method public onBTStreamDataReceived(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 10
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 56
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onBTStreamDataReceived "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    array-length v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "OfflineRecgManger"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 57
    const-string v0, "Offline_Rec_Action"

    const/4 v1, 0x0

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {p1, v0, v1, v2, v3}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 58
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v4

    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;

    invoke-direct {v0, p2, p1, v3}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;-><init>([BLjava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v7, v0

    check-cast v7, Lkotlin/jvm/functions/Function2;

    const/4 v8, 0x3

    const/4 v9, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v4 .. v9}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 83
    :cond_0
    return-void
.end method

.method public onBleTextMessage(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .line 45
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onBleTextMessage(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/lang/String;)V

    return-void
.end method

.method public onClassicBTAudioStream([B)V
    .locals 0
    .param p1, "buffer"    # [B

    .line 45
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onClassicBTAudioStream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;[B)V

    return-void
.end method

.method public onClassicBTTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 48
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->access$parseMessage(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;Ljava/lang/String;)V

    .line 49
    return-void
.end method

.method public onNv21Data([BII)V
    .locals 0
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    .line 45
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onNv21Data(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;[BII)V

    return-void
.end method

.method public onP2PTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->access$parseMessage(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;Ljava/lang/String;)V

    .line 53
    return-void
.end method

.method public onVideoH264Stream(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 45
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onVideoH264Stream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/nio/ByteBuffer;)V

    return-void
.end method
