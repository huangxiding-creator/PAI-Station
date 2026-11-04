.class public final Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$mServerListener$1;
.super Ljava/lang/Object;
.source "BleServiceImpl.kt"

# interfaces
.implements Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBleServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BleServiceImpl.kt\ncom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$mServerListener$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,85:1\n1855#2,2:86\n1855#2,2:88\n1855#2,2:90\n*S KotlinDebug\n*F\n+ 1 BleServiceImpl.kt\ncom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$mServerListener$1\n*L\n68#1:86,2\n74#1:88,2\n80#1:90,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0019\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H\u0016J\u0008\u0010\u0004\u001a\u00020\u0003H\u0016J\u0010\u0010\u0005\u001a\u00020\u00032\u0006\u0010\u0006\u001a\u00020\u0007H\u0016\u00a8\u0006\u0008"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$mServerListener$1",
        "Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;",
        "onClientConnected",
        "",
        "onClientDisconnected",
        "onDataReceived",
        "data",
        "",
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

    .line 65
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClientConnected()V
    .locals 7

    .line 68
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->access$getMBleServerListeners$p()Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 86
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

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;
    const/4 v5, 0x0

    .line 69
    .local v5, "$i$a$-forEach-BleServiceImpl$mServerListener$1$onClientConnected$1":I
    const/4 v6, 0x1

    invoke-interface {v4, v6}, Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;->onClientConnected(Z)V

    .line 70
    nop

    .line 86
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;
    .end local v5    # "$i$a$-forEach-BleServiceImpl$mServerListener$1$onClientConnected$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 87
    :cond_0
    nop

    .line 71
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onClientDisconnected()V
    .locals 7

    .line 74
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->access$getMBleServerListeners$p()Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 88
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

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;
    const/4 v5, 0x0

    .line 75
    .local v5, "$i$a$-forEach-BleServiceImpl$mServerListener$1$onClientDisconnected$1":I
    const/4 v6, 0x0

    invoke-interface {v4, v6}, Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;->onClientConnected(Z)V

    .line 76
    nop

    .line 88
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;
    .end local v5    # "$i$a$-forEach-BleServiceImpl$mServerListener$1$onClientDisconnected$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 89
    :cond_0
    nop

    .line 77
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onDataReceived(Ljava/lang/String;)V
    .locals 6
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 80
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->access$getMBleServerListeners$p()Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 90
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

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;
    const/4 v5, 0x0

    .line 81
    .local v5, "$i$a$-forEach-BleServiceImpl$mServerListener$1$onDataReceived$1":I
    invoke-interface {v4, p1}, Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;->onTextMessage(Ljava/lang/String;)V

    .line 82
    nop

    .line 90
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;
    .end local v5    # "$i$a$-forEach-BleServiceImpl$mServerListener$1$onDataReceived$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 91
    :cond_0
    nop

    .line 83
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method
