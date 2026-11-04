.class public final Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener$DefaultImpls;
.super Ljava/lang/Object;
.source "FileReceiveListener.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
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
.method public static onCancel(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    return-void
.end method

.method public static onComplete(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    return-void
.end method

.method public static onFail(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    .line 11
    return-void
.end method

.method public static onProgressChanged(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;Ljava/lang/String;F)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "progress"    # F

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    return-void
.end method

.method public static onStart(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 8
    return-void
.end method
