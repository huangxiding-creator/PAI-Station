.class public final Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1;
.super Ljava/lang/Object;
.source "BinaryOperater.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;-><init>()V
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
        "com/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1",
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


# instance fields
.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAudioStream(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 21
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onAudioStream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/nio/ByteBuffer;)V

    return-void
.end method

.method public onBTStreamDataReceived(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 9
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 32
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;

    const/16 v7, 0x18

    const/4 v8, 0x0

    const/4 v2, 0x1

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v3, p1

    move-object v4, p3

    invoke-static/range {v1 .. v8}, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->sendReceiverResponseExtra$default(Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;ZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;IILjava/lang/Object;)V

    .line 33
    return-void
.end method

.method public onBleTextMessage(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .line 21
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onBleTextMessage(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/lang/String;)V

    return-void
.end method

.method public onClassicBTAudioStream([B)V
    .locals 0
    .param p1, "buffer"    # [B

    .line 21
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onClassicBTAudioStream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;[B)V

    return-void
.end method

.method public onClassicBTTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->access$parseMessage(Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;Ljava/lang/String;)V

    .line 25
    return-void
.end method

.method public onNv21Data([BII)V
    .locals 0
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    .line 21
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onNv21Data(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;[BII)V

    return-void
.end method

.method public onP2PTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;->access$parseMessage(Lcom/rokid/security/phone/sdk/server/msg/binary/BinaryOperater;Ljava/lang/String;)V

    .line 29
    return-void
.end method

.method public onVideoH264Stream(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 21
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onVideoH264Stream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/nio/ByteBuffer;)V

    return-void
.end method
