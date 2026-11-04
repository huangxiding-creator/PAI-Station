.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener$DefaultImpls;
.super Ljava/lang/Object;
.source "SocketServerChannel.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;
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
.method public static onClose(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    .line 190
    return-void
.end method

.method public static onError(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;Ljava/lang/Exception;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;
    .param p1, "e"    # Ljava/lang/Exception;

    const-string v0, "e"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 192
    return-void
.end method

.method public static onOpen(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    .line 189
    return-void
.end method

.method public static onStart(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    .line 188
    return-void
.end method
