.class public final Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIAuthListener$1;
.super Ljava/lang/Object;
.source "ClassicBTClientServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nClassicBTClientServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ClassicBTClientServiceImpl.kt\ncom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIAuthListener$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,410:1\n1855#2,2:411\n*S KotlinDebug\n*F\n+ 1 ClassicBTClientServiceImpl.kt\ncom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIAuthListener$1\n*L\n84#1:411,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0017\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016\u00a8\u0006\u0006"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIAuthListener$1",
        "Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;",
        "onDeviceAuth",
        "",
        "isAuthenticated",
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

    .line 80
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDeviceAuth(Z)V
    .locals 7
    .param p1, "isAuthenticated"    # Z

    .line 82
    if-eqz p1, :cond_1

    .line 83
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onDeviceAuth: \u6210\u529f, \u84dd\u7259\u5df2\u8fde\u63a5"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 84
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getMIClassicBTClientListeners$p()Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 411
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

    check-cast v4, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;
    const/4 v5, 0x0

    .line 85
    .local v5, "$i$a$-forEach-ClassicBTClientServiceImpl$mIAuthListener$1$onDeviceAuth$1":I
    const/4 v6, 0x1

    invoke-interface {v4, v6}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;->onConnect(Z)V

    .line 86
    nop

    .line 411
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;
    .end local v5    # "$i$a$-forEach-ClassicBTClientServiceImpl$mIAuthListener$1$onDeviceAuth$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 412
    :cond_0
    nop

    .line 87
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    sget-object v0, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->sendUserInfo()V

    .line 88
    sget-object v0, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->sendAppInfo()V

    .line 89
    sget-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->INSTANCE:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->onAuthenticated()V

    goto :goto_1

    .line 93
    :cond_1
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onDeviceAuth: \u5931\u8d25, \u65ad\u5f00\u84dd\u7259\u8fde\u63a5"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 94
    sget-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->INSTANCE:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->onTransportDisconnected()V

    .line 95
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->disconnect()V

    .line 97
    :goto_1
    return-void
.end method
