.class public final Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener$DefaultImpls;
.super Ljava/lang/Object;
.source "IClassicBTMessageListener.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;
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
.method public static onBTStreamDataReceived(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;Ljava/lang/String;[BLjava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    return-void
.end method

.method public static onClassicBTAudioStream(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;[B)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;
    .param p1, "buffer"    # [B

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    return-void
.end method

.method public static onClassicBTTextMessage(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 14
    return-void
.end method
