.class public final Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/recog/online/api/AbsOnlineRecService;
.source "OnlineRecServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\"\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\t\u001a\u00020\nJ\u0006\u0010\u000b\u001a\u00020\nJ\u0012\u0010\u000c\u001a\u00020\n2\u0008\u0010\r\u001a\u0004\u0018\u00010\u000eH\u0016R\u001b\u0010\u0003\u001a\u00020\u00048BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0007\u0010\u0008\u001a\u0004\u0008\u0005\u0010\u0006\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/recog/online/api/AbsOnlineRecService;",
        "()V",
        "mOnlineRecManager",
        "Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;",
        "getMOnlineRecManager",
        "()Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;",
        "mOnlineRecManager$delegate",
        "Lkotlin/Lazy;",
        "init",
        "",
        "release",
        "setRecProvider",
        "recProvider",
        "Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;

.field private static final mOnlineRecManager$delegate:Lkotlin/Lazy;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;

    .line 10
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl$mOnlineRecManager$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl$mOnlineRecManager$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;->mOnlineRecManager$delegate:Lkotlin/Lazy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/recog/online/api/AbsOnlineRecService;-><init>()V

    return-void
.end method

.method private final getMOnlineRecManager()Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;
    .locals 1

    .line 10
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;->mOnlineRecManager$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    return-object v0
.end method


# virtual methods
.method public final init()V
    .locals 1

    .line 15
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;->getMOnlineRecManager()Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->init()V

    .line 16
    return-void
.end method

.method public final release()V
    .locals 1

    .line 19
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;->getMOnlineRecManager()Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->release()V

    .line 20
    return-void
.end method

.method public setRecProvider(Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;)V
    .locals 1
    .param p1, "recProvider"    # Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;

    .line 23
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecServiceImpl;->getMOnlineRecManager()Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->setRecProvider(Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;)V

    .line 24
    return-void
.end method
