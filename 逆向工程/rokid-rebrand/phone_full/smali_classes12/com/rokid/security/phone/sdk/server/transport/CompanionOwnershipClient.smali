.class public final Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;
.super Ljava/lang/Object;
.source "CompanionOwnershipClient.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00000\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u001e\n\u0002\u0008\u0007\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010\u0008\u001a\u00020\tH\u0002J\u0006\u0010\n\u001a\u00020\u000bJ\u0016\u0010\u000c\u001a\u00020\u000b2\u000e\u0010\r\u001a\n\u0012\u0004\u0012\u00020\u0004\u0018\u00010\u000eJ\u0006\u0010\u000f\u001a\u00020\u000bJ\u0006\u0010\u0010\u001a\u00020\u000bJ\u0012\u0010\u0011\u001a\u00020\u000b2\u0008\u0010\u0012\u001a\u0004\u0018\u00010\u0004H\u0002J\u000e\u0010\u0013\u001a\u00020\u000b2\u0006\u0010\u0014\u001a\u00020\tR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0007X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0015"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;",
        "",
        "()V",
        "MESSAGE_TYPE",
        "",
        "TAG",
        "negotiation",
        "Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;",
        "isTransportReady",
        "",
        "onAuthenticated",
        "",
        "onCapabilitiesReceived",
        "capabilities",
        "",
        "onTransportDisconnected",
        "onTransportSessionStarted",
        "send",
        "action",
        "setAppForeground",
        "isForeground",
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


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;

.field private static final MESSAGE_TYPE:Ljava/lang/String; = "COMPANION_SESSION_CONTROL"

.field private static final TAG:Ljava/lang/String; = "CompanionOwnership"

.field private static final negotiation:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->INSTANCE:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;

    .line 14
    new-instance v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;

    .line 15
    nop

    .line 14
    const-string v1, "companion_session_control_v1"

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->negotiation:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final isTransportReady()Z
    .locals 1

    .line 46
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->isAuthenticated()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private final send(Ljava/lang/String;)V
    .locals 8
    .param p1, "action"    # Ljava/lang/String;

    .line 49
    if-nez p1, :cond_0

    return-void

    .line 50
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    .line 51
    nop

    .line 52
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    const-string v2, "action"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move-result-object v1

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v1, "JSONObject().put(\"action\", action).toString()"

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 50
    const/16 v6, 0x1c

    const/4 v7, 0x0

    const-string v1, "COMPANION_SESSION_CONTROL"

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v0 .. v7}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 54
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ownership control sent action="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "CompanionOwnership"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 55
    return-void
.end method


# virtual methods
.method public final onAuthenticated()V
    .locals 2

    .line 42
    sget-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->negotiation:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->isTransportReady()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->onTransportReady(Z)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->send(Ljava/lang/String;)V

    .line 43
    return-void
.end method

.method public final onCapabilitiesReceived(Ljava/util/Collection;)V
    .locals 3
    .param p1, "capabilities"    # Ljava/util/Collection;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 32
    sget-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->negotiation:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->isTransportReady()Z

    move-result v1

    invoke-virtual {v0, p1, v1}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->updateCapabilities(Ljava/util/Collection;Z)Ljava/lang/String;

    move-result-object v0

    .line 34
    .local v0, "action":Ljava/lang/String;
    nop

    .line 35
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ownership capability supported="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->negotiation:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->isSupported()Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " count="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 36
    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/Collection;->size()I

    move-result v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    .line 35
    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .line 33
    const-string v2, "CompanionOwnership"

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 38
    invoke-direct {p0, v0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->send(Ljava/lang/String;)V

    .line 39
    return-void
.end method

.method public final onTransportDisconnected()V
    .locals 1

    .line 28
    sget-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->negotiation:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->resetSession()V

    .line 29
    return-void
.end method

.method public final onTransportSessionStarted()V
    .locals 2

    .line 23
    sget-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->negotiation:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->resetSession()V

    .line 24
    const-string v0, "ownership capability reset reason=session_started"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "CompanionOwnership"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 25
    return-void
.end method

.method public final setAppForeground(Z)V
    .locals 2
    .param p1, "isForeground"    # Z

    .line 19
    sget-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->negotiation:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->isTransportReady()Z

    move-result v1

    invoke-virtual {v0, p1, v1}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->setForeground(ZZ)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->send(Ljava/lang/String;)V

    .line 20
    return-void
.end method
