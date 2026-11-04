.class public final Lcom/rokid/security/sdk/ability/message/ICommonMessage$DefaultImpls;
.super Ljava/lang/Object;
.source "ICommonMessage.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/ability/message/ICommonMessage;
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
.method public static onAudioStream(Lcom/rokid/security/sdk/ability/message/ICommonMessage;[BI)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/message/ICommonMessage;
    .param p1, "buffer"    # [B
    .param p2, "type"    # I

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    return-void
.end method

.method public static onMessage(Lcom/rokid/security/sdk/ability/message/ICommonMessage;Ljava/lang/String;I)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/message/ICommonMessage;
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "type"    # I

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 18
    return-void
.end method

.method public static onVideoStream(Lcom/rokid/security/sdk/ability/message/ICommonMessage;[BI)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/message/ICommonMessage;
    .param p1, "buffer"    # [B
    .param p2, "type"    # I

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    return-void
.end method
