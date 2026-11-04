.class public final Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl$mIClassicClientListener$1;
.super Ljava/lang/Object;
.source "BleClientServiceImpl.kt"

# interfaces
.implements Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBleClientServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BleClientServiceImpl.kt\ncom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl$mIClassicClientListener$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,80:1\n1855#2,2:81\n*S KotlinDebug\n*F\n+ 1 BleClientServiceImpl.kt\ncom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl$mIClassicClientListener$1\n*L\n68#1:81,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001f\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u0008H\u0016\u00a8\u0006\t"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl$mIClassicClientListener$1",
        "Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;",
        "onConnect",
        "",
        "isConnected",
        "",
        "onTextMessage",
        "msg",
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

    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onConnect(Z)V
    .locals 6
    .param p1, "isConnected"    # Z

    .line 68
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->access$getMIBleClientListeners$p()Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 81
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

    check-cast v4, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleBTClientListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleBTClientListener;
    const/4 v5, 0x0

    .line 69
    .local v5, "$i$a$-forEach-BleClientServiceImpl$mIClassicClientListener$1$onConnect$1":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleBTClientListener;->onConnect(Z)V

    .line 70
    nop

    .line 81
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleBTClientListener;
    .end local v5    # "$i$a$-forEach-BleClientServiceImpl$mIClassicClientListener$1$onConnect$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 82
    :cond_0
    nop

    .line 71
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 74
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->access$getMIBleMessageListener$p()Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleMessageListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleMessageListener;->onBleTextMessage(Ljava/lang/String;)V

    .line 75
    :cond_0
    return-void
.end method
