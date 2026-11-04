.class public final Lcom/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1;
.super Ljava/lang/Object;
.source "TrackManager.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/track/TrackManager;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\'\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0003*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J \u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\nH\u0016J\u0010\u0010\u000c\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016\u00a8\u0006\r"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;",
        "onClassicBTTextMessage",
        "",
        "msg",
        "",
        "onNv21Data",
        "data",
        "",
        "width",
        "",
        "height",
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
.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    .line 84
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAudioStream(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 84
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onAudioStream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/nio/ByteBuffer;)V

    return-void
.end method

.method public onBTStreamDataReceived(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 0
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    .line 84
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onBTStreamDataReceived(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/lang/String;[BLjava/lang/String;)V

    return-void
.end method

.method public onBleTextMessage(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .line 84
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onBleTextMessage(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/lang/String;)V

    return-void
.end method

.method public onClassicBTAudioStream([B)V
    .locals 0
    .param p1, "buffer"    # [B

    .line 84
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onClassicBTAudioStream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;[B)V

    return-void
.end method

.method public onClassicBTTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 92
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$parseMessage(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Ljava/lang/String;)V

    .line 93
    return-void
.end method

.method public onNv21Data([BII)V
    .locals 1
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 86
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getRecogMode$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)I

    move-result v0

    if-eqz v0, :cond_0

    .line 87
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->setFrameData([B)V

    .line 89
    :cond_0
    return-void
.end method

.method public onP2PTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 96
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$parseMessage(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Ljava/lang/String;)V

    .line 97
    return-void
.end method

.method public onVideoH264Stream(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 84
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;->onVideoH264Stream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/nio/ByteBuffer;)V

    return-void
.end method
