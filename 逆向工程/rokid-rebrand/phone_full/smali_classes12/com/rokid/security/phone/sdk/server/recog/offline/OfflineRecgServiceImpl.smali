.class public final Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/recog/offline/api/AbsOfflineRecService;
.source "OfflineRecgServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0003\u001a\u00020\u0004J\u0006\u0010\u0005\u001a\u00020\u0004J\u0012\u0010\u0006\u001a\u00020\u00042\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u0008H\u0016\u00a8\u0006\t"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/recog/offline/api/AbsOfflineRecService;",
        "()V",
        "init",
        "",
        "release",
        "setRecProvider",
        "recProvider",
        "Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgServiceImpl;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgServiceImpl;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/recog/offline/api/AbsOfflineRecService;-><init>()V

    return-void
.end method


# virtual methods
.method public final init()V
    .locals 1

    .line 9
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->init()V

    .line 10
    return-void
.end method

.method public final release()V
    .locals 1

    .line 13
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->release()V

    .line 14
    return-void
.end method

.method public setRecProvider(Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;)V
    .locals 1
    .param p1, "recProvider"    # Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;

    .line 18
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->setRecProvider(Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;)V

    .line 19
    return-void
.end method
