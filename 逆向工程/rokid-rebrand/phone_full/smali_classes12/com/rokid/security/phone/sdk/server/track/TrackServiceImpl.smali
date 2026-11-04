.class public final Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/track/api/AbsTrackService;
.source "TrackServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000&\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\nH\u0016J\u0008\u0010\u000b\u001a\u00020\u0008H\u0016J\u0008\u0010\u000c\u001a\u00020\u0008H\u0016J\u0010\u0010\r\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\nH\u0016R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/track/api/AbsTrackService;",
        "()V",
        "TAG",
        "",
        "mTrackManager",
        "Lcom/rokid/security/phone/sdk/server/track/TrackManager;",
        "addTrackListener",
        "",
        "listener",
        "Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;",
        "init",
        "release",
        "removeTrackListener",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;

.field private static final TAG:Ljava/lang/String; = "TrackServiceImpl"

.field private static final mTrackManager:Lcom/rokid/security/phone/sdk/server/track/TrackManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;

    .line 11
    new-instance v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;->mTrackManager:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/track/api/AbsTrackService;-><init>()V

    return-void
.end method


# virtual methods
.method public addTrackListener(Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 18
    sget-object v0, Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;->mTrackManager:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->addTrackListener(Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;)V

    .line 19
    return-void
.end method

.method public init()V
    .locals 1

    .line 14
    sget-object v0, Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;->mTrackManager:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->init()V

    .line 15
    return-void
.end method

.method public release()V
    .locals 1

    .line 27
    sget-object v0, Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;->mTrackManager:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->release()V

    .line 28
    return-void
.end method

.method public removeTrackListener(Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    sget-object v0, Lcom/rokid/security/phone/sdk/server/track/TrackServiceImpl;->mTrackManager:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->removeTrackListener(Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;)V

    .line 23
    return-void
.end method
