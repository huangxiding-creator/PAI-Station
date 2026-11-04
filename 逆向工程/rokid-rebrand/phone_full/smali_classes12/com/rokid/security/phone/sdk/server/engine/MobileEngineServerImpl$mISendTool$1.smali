.class public final Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$mISendTool$1;
.super Ljava/lang/Object;
.source "MobileEngineServerImpl.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/message/ISendTool;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\'\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0012\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0003*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0018\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0016J\u0018\u0010\u0008\u001a\u00020\u00032\u0006\u0010\t\u001a\u00020\n2\u0006\u0010\u0006\u001a\u00020\u0007H\u0016J \u0010\u000b\u001a\u00020\u00032\u0006\u0010\u000c\u001a\u00020\n2\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0016\u00a8\u0006\r"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/engine/MobileEngineServerImpl$mISendTool$1",
        "Lcom/rokid/security/sdk/ability/message/ISendTool;",
        "sendAudioStream",
        "",
        "streamData",
        "",
        "type",
        "",
        "sendMessage",
        "msg",
        "",
        "sendStreamData",
        "tag",
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

    .line 111
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public sendAudioStream([BI)V
    .locals 1
    .param p1, "streamData"    # [B
    .param p2, "type"    # I

    const-string/jumbo v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 118
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->sendClassBTAudioData([B)V

    .line 119
    return-void
.end method

.method public sendMessage(Ljava/lang/String;I)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "type"    # I

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 114
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->sendClassBTTextMessage(Ljava/lang/String;)V

    .line 115
    return-void
.end method

.method public sendStreamData(Ljava/lang/String;[BI)V
    .locals 3
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "streamData"    # [B
    .param p3, "type"    # I

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "streamData"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 122
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    const-string v1, ""

    const/4 v2, 0x0

    invoke-virtual {v0, p1, p2, v1, v2}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->sendStreamData(Ljava/lang/String;[BLjava/lang/String;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V

    .line 123
    return-void
.end method
