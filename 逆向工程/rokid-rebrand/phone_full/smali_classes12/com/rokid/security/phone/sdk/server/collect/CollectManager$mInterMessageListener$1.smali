.class public final Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;
.super Ljava/lang/Object;
.source "CollectManager.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/collect/CollectManager;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001f\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J \u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\u0005H\u0016\u00a8\u0006\t"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;",
        "onBTStreamDataReceived",
        "",
        "tag",
        "",
        "data",
        "",
        "clientId",
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


# instance fields
.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/collect/CollectManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAudioStream(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 23
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

    .line 25
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onBTStreamDataReceived tag = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", size = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v2, p2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 27
    const/4 v0, 0x0

    const-string v1, "COLLECT_ACTION"

    const/4 v2, 0x0

    const/4 v3, 0x2

    invoke-static {p1, v1, v2, v3, v0}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 28
    move-object v4, p1

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v0, 0x1

    new-array v5, v0, [Ljava/lang/String;

    const-string v0, ","

    aput-object v0, v5, v2

    const/4 v8, 0x6

    const/4 v9, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-static/range {v4 .. v9}, Lkotlin/text/StringsKt;->split$default(Ljava/lang/CharSequence;[Ljava/lang/String;ZIILjava/lang/Object;)Ljava/util/List;

    move-result-object v0

    .line 29
    .local v0, "items":Ljava/util/List;
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-ge v1, v3, :cond_0

    .line 30
    return-void

    .line 32
    :cond_0
    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    const-string v2, "1"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x5

    const/4 v4, 0x4

    const/4 v5, 0x6

    if-eqz v1, :cond_3

    .line 33
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-lt v1, v5, :cond_5

    .line 34
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->access$getMProvider$p(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;)Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 35
    sget-object v1, Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;

    invoke-virtual {v1, p2}, Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;->dataToBase64([B)Ljava/lang/String;

    move-result-object v1

    .line 36
    .local v1, "base64Str":Ljava/lang/String;
    if-eqz v1, :cond_2

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    move-object v5, v1

    .local v5, "it":Ljava/lang/String;
    const/4 v6, 0x0

    .line 37
    .local v6, "$i$a$-let-CollectManager$mInterMessageListener$1$onBTStreamDataReceived$1":I
    new-instance v7, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;

    .line 38
    invoke-interface {v0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v4

    .line 39
    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v2

    .line 37
    invoke-direct {v7, v4, v2}, Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;-><init>(FF)V

    move-object v2, v7

    .line 41
    .local v2, "face":Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;
    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->access$getMProvider$p(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;)Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;

    move-result-object v4

    if-eqz v4, :cond_1

    .line 42
    nop

    .line 43
    nop

    .line 44
    new-instance v7, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$1$1;

    invoke-direct {v7, v3, p1}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$1$1;-><init>(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;Ljava/lang/String;)V

    check-cast v7, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    .line 41
    invoke-interface {v4, v1, v2, v7}, Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;->onFaceCollectInfo(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V

    .line 36
    .end local v2    # "face":Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;
    .end local v5    # "it":Ljava/lang/String;
    .end local v6    # "$i$a$-let-CollectManager$mInterMessageListener$1$onBTStreamDataReceived$1":I
    :cond_1
    goto :goto_0

    .end local v1    # "base64Str":Ljava/lang/String;
    :cond_2
    goto :goto_0

    .line 63
    :cond_3
    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    const-string v3, "2"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 64
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-lt v1, v5, :cond_5

    .line 65
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->access$getMProvider$p(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;)Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 66
    sget-object v1, Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;

    invoke-virtual {v1, p2}, Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;->dataToBase64([B)Ljava/lang/String;

    move-result-object v1

    .line 67
    .restart local v1    # "base64Str":Ljava/lang/String;
    if-eqz v1, :cond_4

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    move-object v5, v1

    .restart local v5    # "it":Ljava/lang/String;
    const/4 v6, 0x0

    .line 69
    .local v6, "$i$a$-let-CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2":I
    const/4 v7, 0x3

    invoke-interface {v0, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 70
    invoke-interface {v0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 71
    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 68
    new-instance v8, Lcom/rokid/security/sdk/base/common/outside/LprCollectInfo;

    .line 71
    nop

    .line 69
    nop

    .line 70
    nop

    .line 68
    invoke-direct {v8, v2, v7, v4}, Lcom/rokid/security/sdk/base/common/outside/LprCollectInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    move-object v2, v8

    .line 73
    .local v2, "lpr":Lcom/rokid/security/sdk/base/common/outside/LprCollectInfo;
    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->access$getMProvider$p(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;)Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;

    move-result-object v4

    if-eqz v4, :cond_4

    .line 74
    nop

    .line 75
    nop

    .line 76
    new-instance v7, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2$1;

    invoke-direct {v7, v3, p1}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2$1;-><init>(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;Ljava/lang/String;)V

    check-cast v7, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    .line 73
    invoke-interface {v4, v1, v2, v7}, Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;->onLprCollectInfo(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/LprCollectInfo;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V

    .line 67
    .end local v2    # "lpr":Lcom/rokid/security/sdk/base/common/outside/LprCollectInfo;
    .end local v5    # "it":Ljava/lang/String;
    .end local v6    # "$i$a$-let-CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2":I
    :cond_4
    nop

    .line 98
    .end local v0    # "items":Ljava/util/List;
    .end local v1    # "base64Str":Ljava/lang/String;
    :cond_5
    :goto_0
    return-void
.end method

.method public onBleTextMessage(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .line 23
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onBleTextMessage(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/lang/String;)V

    return-void
.end method

.method public onClassicBTAudioStream([B)V
    .locals 0
    .param p1, "buffer"    # [B

    .line 23
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onClassicBTAudioStream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;[B)V

    return-void
.end method

.method public onClassicBTTextMessage(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .line 23
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onClassicBTTextMessage(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/lang/String;)V

    return-void
.end method

.method public onNv21Data([BII)V
    .locals 0
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    .line 23
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onNv21Data(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;[BII)V

    return-void
.end method

.method public onP2PTextMessage(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .line 23
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onP2PTextMessage(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/lang/String;)V

    return-void
.end method

.method public onVideoH264Stream(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 23
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onVideoH264Stream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/nio/ByteBuffer;)V

    return-void
.end method
