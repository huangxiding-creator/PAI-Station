.class public final Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener$DefaultImpls;
.super Ljava/lang/Object;
.source "FileReceiveV2Listener.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
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
.method public static onCancel(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    return-void
.end method

.method public static onComplete(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    return-void
.end method

.method public static onFail(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    .line 11
    return-void
.end method

.method public static onProgressChanged(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;Ljava/lang/String;F)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "progress"    # F

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    return-void
.end method

.method public static onStart(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 8
    return-void
.end method
