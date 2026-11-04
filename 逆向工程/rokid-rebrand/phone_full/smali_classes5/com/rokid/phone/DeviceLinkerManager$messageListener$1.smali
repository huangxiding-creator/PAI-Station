.class public final Lcom/rokid/phone/DeviceLinkerManager$messageListener$1;
.super Ljava/lang/Object;
.source "DeviceLinkerManager.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/phone/DeviceLinkerManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001f\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0010\u0012\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0018\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0005H\u0016J \u0010\u0007\u001a\u00020\u00032\u0006\u0010\u0008\u001a\u00020\u00052\u0006\u0010\t\u001a\u00020\n2\u0006\u0010\u0006\u001a\u00020\u0005H\u0016\u00a8\u0006\u000b"
    }
    d2 = {
        "com/rokid/phone/DeviceLinkerManager$messageListener$1",
        "Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;",
        "onClassicBTTextMessage",
        "",
        "msg",
        "",
        "clientId",
        "onBTStreamDataReceived",
        "tag",
        "data",
        "",
        "app_debug"
    }
    k = 0x1
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 79
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAudioStream(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 79
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener$DefaultImpls;->onAudioStream(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;Ljava/nio/ByteBuffer;)V

    return-void
.end method

.method public onBTStreamDataReceived(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 86
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-static {v0, p1, p2}, Lcom/rokid/phone/DeviceLinkerManager;->access$handleAiVisionImage(Lcom/rokid/phone/DeviceLinkerManager;Ljava/lang/String;[B)V

    .line 87
    return-void
.end method

.method public onClassicBTAudioStream([B)V
    .locals 0
    .param p1, "buffer"    # [B

    .line 79
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener$DefaultImpls;->onClassicBTAudioStream(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;[B)V

    return-void
.end method

.method public onClassicBTTextMessage(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "clientId"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 81
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-static {v0, p1}, Lcom/rokid/phone/DeviceLinkerManager;->access$handleAiVisionResult(Lcom/rokid/phone/DeviceLinkerManager;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 82
    :cond_0
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-static {v0, p1}, Lcom/rokid/phone/DeviceLinkerManager;->access$handleSystemInfo(Lcom/rokid/phone/DeviceLinkerManager;Ljava/lang/String;)V

    .line 83
    return-void
.end method

.method public onNv21Data([BII)V
    .locals 0
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    .line 79
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener$DefaultImpls;->onNv21Data(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;[BII)V

    return-void
.end method

.method public onP2PTextMessage(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "clientId"    # Ljava/lang/String;

    .line 79
    invoke-static {p0, p1, p2}, Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener$DefaultImpls;->onP2PTextMessage(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onVideoH264Stream(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 79
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener$DefaultImpls;->onVideoH264Stream(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;Ljava/nio/ByteBuffer;)V

    return-void
.end method
