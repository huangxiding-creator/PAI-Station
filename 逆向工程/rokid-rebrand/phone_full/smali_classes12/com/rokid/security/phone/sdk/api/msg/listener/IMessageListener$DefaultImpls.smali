.class public final Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener$DefaultImpls;
.super Ljava/lang/Object;
.source "IMessageListener.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "DefaultImpls"
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static onAudioStream(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    return-void
.end method

.method public static onBTStreamDataReceived(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;Ljava/lang/String;[BLjava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 60
    return-void
.end method

.method public static onClassicBTAudioStream(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;[B)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
    .param p1, "buffer"    # [B

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 53
    return-void
.end method

.method public static onClassicBTTextMessage(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "clientId"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 47
    return-void
.end method

.method public static onNv21Data(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;[BII)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 36
    return-void
.end method

.method public static onP2PTextMessage(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "clientId"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 16
    return-void
.end method

.method public static onVideoH264Stream(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    return-void
.end method
