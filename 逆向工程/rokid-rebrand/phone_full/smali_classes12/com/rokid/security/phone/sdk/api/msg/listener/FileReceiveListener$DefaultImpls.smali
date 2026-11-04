.class public final Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener$DefaultImpls;
.super Ljava/lang/Object;
.source "FileReceiveListener.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
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
.method public static onCancel(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    .line 14
    return-void
.end method

.method public static onComplete(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    return-void
.end method

.method public static onFail(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    .line 13
    return-void
.end method

.method public static onProgressChanged(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;F)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .param p1, "progress"    # F

    .line 8
    return-void
.end method

.method public static onProgressChanged(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;FJJ)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .param p1, "progress"    # F
    .param p2, "transferredBytes"    # J
    .param p4, "totalBytes"    # J

    .line 10
    invoke-interface {p0, p1}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onProgressChanged(F)V

    .line 11
    return-void
.end method

.method public static onStart(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    .line 7
    return-void
.end method
