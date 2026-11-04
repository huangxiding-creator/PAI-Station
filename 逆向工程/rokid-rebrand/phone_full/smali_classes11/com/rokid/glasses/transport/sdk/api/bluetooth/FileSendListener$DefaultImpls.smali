.class public final Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener$DefaultImpls;
.super Ljava/lang/Object;
.source "FileSendListener.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;
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
.method public static onCancel(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    .line 12
    return-void
.end method

.method public static onComplete(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    .line 10
    return-void
.end method

.method public static onFail(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    .line 11
    return-void
.end method

.method public static onProgressChanged(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;F)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;
    .param p1, "progress"    # F

    .line 9
    return-void
.end method

.method public static onStart(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    .line 8
    return-void
.end method
