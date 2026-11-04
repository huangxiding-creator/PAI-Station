.class public final Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/collect/api/AbsCollectService;
.source "CollectServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\"\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\t\u001a\u00020\nJ\u0006\u0010\u000b\u001a\u00020\nJ\u0012\u0010\u000c\u001a\u00020\n2\u0008\u0010\r\u001a\u0004\u0018\u00010\u000eH\u0016R\u001b\u0010\u0003\u001a\u00020\u00048BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0007\u0010\u0008\u001a\u0004\u0008\u0005\u0010\u0006\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/collect/api/AbsCollectService;",
        "()V",
        "mCollectManager",
        "Lcom/rokid/security/phone/sdk/server/collect/CollectManager;",
        "getMCollectManager",
        "()Lcom/rokid/security/phone/sdk/server/collect/CollectManager;",
        "mCollectManager$delegate",
        "Lkotlin/Lazy;",
        "init",
        "",
        "release",
        "setProvider",
        "provider",
        "Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;

.field private static final mCollectManager$delegate:Lkotlin/Lazy;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;

    .line 7
    sget-object v0, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl$mCollectManager$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl$mCollectManager$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;->mCollectManager$delegate:Lkotlin/Lazy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/collect/api/AbsCollectService;-><init>()V

    return-void
.end method

.method private final getMCollectManager()Lcom/rokid/security/phone/sdk/server/collect/CollectManager;
    .locals 1

    .line 7
    sget-object v0, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;->mCollectManager$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    return-object v0
.end method


# virtual methods
.method public final init()V
    .locals 1

    .line 12
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;->getMCollectManager()Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->init()V

    .line 13
    return-void
.end method

.method public final release()V
    .locals 1

    .line 16
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;->getMCollectManager()Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->release()V

    .line 17
    return-void
.end method

.method public setProvider(Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;)V
    .locals 1
    .param p1, "provider"    # Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;

    .line 20
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/collect/CollectServiceImpl;->getMCollectManager()Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->setProvider(Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;)V

    .line 21
    return-void
.end method
