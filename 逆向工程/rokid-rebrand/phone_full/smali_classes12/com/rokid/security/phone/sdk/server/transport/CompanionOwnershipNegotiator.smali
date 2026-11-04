.class public final Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;
.super Ljava/lang/Object;
.source "CompanionOwnershipNegotiator.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0007\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u001e\n\u0002\u0008\u0002\u0008\u0000\u0018\u0000 \u00142\u00020\u0001:\u0001\u0014B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u0006\u0010\t\u001a\u00020\u0006J\u0012\u0010\n\u001a\u0004\u0018\u00010\u00032\u0006\u0010\u000b\u001a\u00020\u0006H\u0002J\u0010\u0010\u000c\u001a\u0004\u0018\u00010\u00032\u0006\u0010\u000b\u001a\u00020\u0006J\u0006\u0010\r\u001a\u00020\u000eJ\u0018\u0010\u000f\u001a\u0004\u0018\u00010\u00032\u0006\u0010\u0010\u001a\u00020\u00062\u0006\u0010\u000b\u001a\u00020\u0006J \u0010\u0011\u001a\u0004\u0018\u00010\u00032\u000e\u0010\u0012\u001a\n\u0012\u0004\u0012\u00020\u0003\u0018\u00010\u00132\u0006\u0010\u000b\u001a\u00020\u0006R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0007\u001a\u0004\u0018\u00010\u0003X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0015"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;",
        "",
        "capabilityName",
        "",
        "(Ljava/lang/String;)V",
        "foreground",
        "",
        "lastAction",
        "supported",
        "isSupported",
        "nextAction",
        "transportReady",
        "onTransportReady",
        "resetSession",
        "",
        "setForeground",
        "isForeground",
        "updateCapabilities",
        "capabilities",
        "",
        "Companion",
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
.field public static final ACTION_CLAIM:Ljava/lang/String; = "CLAIM"

.field public static final ACTION_RELEASE:Ljava/lang/String; = "RELEASE"

.field public static final Companion:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator$Companion;


# instance fields
.field private final capabilityName:Ljava/lang/String;

.field private foreground:Z

.field private lastAction:Ljava/lang/String;

.field private supported:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->Companion:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator$Companion;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "capabilityName"    # Ljava/lang/String;

    const-string v0, "capabilityName"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 8
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->capabilityName:Ljava/lang/String;

    .line 7
    return-void
.end method

.method private final nextAction(Z)Ljava/lang/String;
    .locals 3
    .param p1, "transportReady"    # Z

    .line 46
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->supported:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    if-nez p1, :cond_0

    goto :goto_1

    .line 47
    :cond_0
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->foreground:Z

    if-eqz v0, :cond_1

    const-string v0, "CLAIM"

    goto :goto_0

    :cond_1
    const-string v0, "RELEASE"

    .line 48
    .local v0, "action":Ljava/lang/String;
    :goto_0
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->lastAction:Ljava/lang/String;

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    return-object v1

    .line 49
    :cond_2
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->lastAction:Ljava/lang/String;

    .line 50
    return-object v0

    .line 46
    .end local v0    # "action":Ljava/lang/String;
    :cond_3
    :goto_1
    return-object v1
.end method


# virtual methods
.method public final declared-synchronized isSupported()Z
    .locals 1

    monitor-enter p0

    .line 43
    :try_start_0
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->supported:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    .line 43
    .end local p0    # "this":Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized onTransportReady(Z)Ljava/lang/String;
    .locals 1
    .param p1, "transportReady"    # Z

    monitor-enter p0

    .line 40
    :try_start_0
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->nextAction(Z)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 40
    .end local p0    # "this":Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;
    .end local p1    # "transportReady":Z
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized resetSession()V
    .locals 1

    monitor-enter p0

    .line 16
    const/4 v0, 0x0

    :try_start_0
    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->supported:Z

    .line 17
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->lastAction:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 18
    monitor-exit p0

    return-void

    .line 15
    .end local p0    # "this":Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized setForeground(ZZ)Ljava/lang/String;
    .locals 1
    .param p1, "isForeground"    # Z
    .param p2, "transportReady"    # Z

    monitor-enter p0

    .line 22
    :try_start_0
    iput-boolean p1, p0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->foreground:Z

    .line 23
    invoke-direct {p0, p2}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->nextAction(Z)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 21
    .end local p0    # "this":Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;
    .end local p1    # "isForeground":Z
    .end local p2    # "transportReady":Z
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized updateCapabilities(Ljava/util/Collection;Z)Ljava/lang/String;
    .locals 3
    .param p1, "capabilities"    # Ljava/util/Collection;
    .param p2, "transportReady"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;Z)",
            "Ljava/lang/String;"
        }
    .end annotation

    monitor-enter p0

    .line 31
    const/4 v0, 0x0

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->capabilityName:Ljava/lang/String;

    invoke-interface {p1, v1}, Ljava/util/Collection;->contains(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    move v0, v2

    goto :goto_0

    .line 30
    .end local p0    # "this":Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;
    .end local p1    # "capabilities":Ljava/util/Collection;
    .end local p2    # "transportReady":Z
    :catchall_0
    move-exception p1

    goto :goto_1

    .line 32
    .local v0, "newSupported":Z
    .restart local p1    # "capabilities":Ljava/util/Collection;
    .restart local p2    # "transportReady":Z
    :cond_0
    :goto_0
    iget-boolean v1, p0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->supported:Z

    if-eq v0, v1, :cond_1

    .line 33
    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->supported:Z

    .line 34
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->lastAction:Ljava/lang/String;

    .line 36
    :cond_1
    invoke-direct {p0, p2}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipNegotiator;->nextAction(Z)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v1

    .line 30
    .end local v0    # "newSupported":Z
    .end local p1    # "capabilities":Ljava/util/Collection;
    .end local p2    # "transportReady":Z
    :goto_1
    monitor-exit p0

    throw p1
.end method
