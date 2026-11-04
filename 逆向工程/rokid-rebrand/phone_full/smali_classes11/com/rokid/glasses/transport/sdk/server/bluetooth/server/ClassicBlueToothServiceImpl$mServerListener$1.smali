.class public final Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mServerListener$1;
.super Ljava/lang/Object;
.source "ClassicBlueToothServiceImpl.kt"

# interfaces
.implements Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nClassicBlueToothServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ClassicBlueToothServiceImpl.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mServerListener$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,292:1\n1855#2,2:293\n1855#2,2:295\n1855#2,2:297\n1855#2,2:299\n1855#2,2:301\n1855#2,2:303\n1855#2,2:305\n*S KotlinDebug\n*F\n+ 1 ClassicBlueToothServiceImpl.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mServerListener$1\n*L\n171#1:293,2\n184#1:295,2\n196#1:297,2\n208#1:299,2\n220#1:301,2\n232#1:303,2\n243#1:305,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\'\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0002\u0008\u0005*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0018\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0016J\u0010\u0010\u0008\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\t\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\n\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0018\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u000cH\u0016J\u0018\u0010\r\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0016J(\u0010\u000e\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u000f\u001a\u00020\u000c2\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0010\u001a\u00020\u000cH\u0016\u00a8\u0006\u0011"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mServerListener$1",
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;",
        "onAudioDataReceived",
        "",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "data",
        "",
        "onClientConnected",
        "onClientDisconnected",
        "onConnectionRejected",
        "onDataReceived",
        "",
        "onFileDataReceived",
        "onStreamDataReceived",
        "tag",
        "clientId",
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

    .line 159
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAudioDataReceived(Landroid/bluetooth/BluetoothDevice;[B)V
    .locals 6
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "data"    # [B

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 219
    nop

    .line 220
    :try_start_0
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getMBlueToothServerListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 301
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    const/4 v5, 0x0

    .line 221
    .local v5, "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onAudioDataReceived$1":I
    invoke-interface {v4, p1, p2}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;->onAudioDataReceived(Landroid/bluetooth/BluetoothDevice;[B)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 222
    nop

    .line 301
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onAudioDataReceived$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 302
    :cond_0
    nop

    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    goto :goto_1

    .line 223
    :catch_0
    move-exception v0

    .line 224
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 225
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    const-string v2, "\u4e1a\u52a1\u65b9\u5904\u7406\u6d88\u606f\u903b\u8f91\u51fa\u73b0\u5f02\u5e38"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 228
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method public onClientConnected(Landroid/bluetooth/BluetoothDevice;)V
    .locals 6
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 169
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onClientConnected "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 170
    nop

    .line 171
    :try_start_0
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getMBlueToothServerListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 293
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    const/4 v5, 0x0

    .line 172
    .local v5, "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onClientConnected$1":I
    invoke-interface {v4, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;->onClientConnected(Landroid/bluetooth/BluetoothDevice;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 173
    nop

    .line 293
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onClientConnected$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 294
    :cond_0
    nop

    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    goto :goto_1

    .line 174
    :catch_0
    move-exception v0

    .line 175
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 176
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    const-string v2, "\u4e1a\u52a1\u65b9\u5904\u7406\u6d88\u606f\u903b\u8f91\u51fa\u73b0\u5f02\u5e38"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 179
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method public onClientDisconnected(Landroid/bluetooth/BluetoothDevice;)V
    .locals 6
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 194
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onClientDisconnected "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 195
    nop

    .line 196
    :try_start_0
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getMBlueToothServerListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 297
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    const/4 v5, 0x0

    .line 197
    .local v5, "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onClientDisconnected$1":I
    invoke-interface {v4, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;->onClientDisconnected(Landroid/bluetooth/BluetoothDevice;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 198
    nop

    .line 297
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onClientDisconnected$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 298
    :cond_0
    nop

    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    goto :goto_1

    .line 199
    :catch_0
    move-exception v0

    .line 200
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 201
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    const-string v2, "\u4e1a\u52a1\u65b9\u5904\u7406\u6d88\u606f\u903b\u8f91\u51fa\u73b0\u5f02\u5e38"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 204
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method public onConnectionRejected(Landroid/bluetooth/BluetoothDevice;)V
    .locals 6
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 182
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onConnectionRejected "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 183
    nop

    .line 184
    :try_start_0
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getMBlueToothServerListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 295
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    const/4 v5, 0x0

    .line 185
    .local v5, "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onConnectionRejected$1":I
    invoke-interface {v4, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;->onConnectionRejected(Landroid/bluetooth/BluetoothDevice;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 186
    nop

    .line 295
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onConnectionRejected$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 296
    :cond_0
    nop

    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    goto :goto_1

    .line 187
    :catch_0
    move-exception v0

    .line 188
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 189
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    const-string v2, "\u4e1a\u52a1\u65b9\u5904\u7406\u6d88\u606f\u903b\u8f91\u51fa\u73b0\u5f02\u5e38"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 191
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method public onDataReceived(Landroid/bluetooth/BluetoothDevice;Ljava/lang/String;)V
    .locals 6
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "data"    # Ljava/lang/String;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 207
    nop

    .line 208
    :try_start_0
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getMBlueToothServerListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 299
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    const/4 v5, 0x0

    .line 209
    .local v5, "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onDataReceived$1":I
    invoke-interface {v4, p1, p2}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;->onTextMessage(Landroid/bluetooth/BluetoothDevice;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 210
    nop

    .line 299
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onDataReceived$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 300
    :cond_0
    nop

    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    goto :goto_1

    .line 211
    :catch_0
    move-exception v0

    .line 212
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 213
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    const-string v2, "\u4e1a\u52a1\u65b9\u5904\u7406\u6d88\u606f\u903b\u8f91\u51fa\u73b0\u5f02\u5e38"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 216
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method public onFileDataReceived(Landroid/bluetooth/BluetoothDevice;[B)V
    .locals 6
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "data"    # [B

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 242
    nop

    .line 243
    :try_start_0
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getMBlueToothServerListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 305
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    const/4 v5, 0x0

    .line 244
    .local v5, "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onFileDataReceived$1":I
    invoke-interface {v4, p1, p2}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;->onFileDataReceived(Landroid/bluetooth/BluetoothDevice;[B)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 245
    nop

    .line 305
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onFileDataReceived$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 306
    :cond_0
    nop

    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    goto :goto_1

    .line 246
    :catch_0
    move-exception v0

    .line 247
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 248
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    const-string v2, "\u4e1a\u52a1\u65b9\u5904\u7406\u6d88\u606f\u903b\u8f91\u51fa\u73b0\u5f02\u5e38"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 251
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method public onStreamDataReceived(Landroid/bluetooth/BluetoothDevice;Ljava/lang/String;[BLjava/lang/String;)V
    .locals 6
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "data"    # [B
    .param p4, "clientId"    # Ljava/lang/String;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "tag"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 231
    nop

    .line 232
    :try_start_0
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getMBlueToothServerListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 303
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    const/4 v5, 0x0

    .line 233
    .local v5, "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onStreamDataReceived$1":I
    invoke-interface {v4, p1, p2, p3, p4}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;->onStreamDataReceived(Landroid/bluetooth/BluetoothDevice;Ljava/lang/String;[BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 234
    nop

    .line 303
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothServiceImpl$mServerListener$1$onStreamDataReceived$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 304
    :cond_0
    nop

    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    goto :goto_1

    .line 235
    :catch_0
    move-exception v0

    .line 236
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 237
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    const-string v2, "\u4e1a\u52a1\u65b9\u5904\u7406\u6d88\u606f\u903b\u8f91\u51fa\u73b0\u5f02\u5e38"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 239
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method
