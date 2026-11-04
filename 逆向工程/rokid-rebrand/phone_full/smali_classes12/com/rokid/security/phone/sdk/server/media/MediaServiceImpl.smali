.class public final Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/camera/AbsMediaService;
.source "MediaServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/camera/IMedia;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl$MyIMessageListener;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001e\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u00012\u00020\u0002:\u0001\tB\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0003J\u0010\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\u0005H\u0016R\u0010\u0010\u0004\u001a\u0004\u0018\u00010\u0005X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\n"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/camera/AbsMediaService;",
        "Lcom/rokid/security/phone/sdk/api/camera/IMedia;",
        "()V",
        "mReceiver",
        "Lcom/rokid/security/phone/sdk/api/camera/IMediaReceiver;",
        "setMediaReceiver",
        "",
        "receiver",
        "MyIMessageListener",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl;

.field private static mReceiver:Lcom/rokid/security/phone/sdk/api/camera/IMediaReceiver;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl;

    .line 21
    nop

    .line 23
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl$MyIMessageListener;

    invoke-direct {v1}, Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl$MyIMessageListener;-><init>()V

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 24
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/camera/AbsMediaService;-><init>()V

    return-void
.end method

.method public static final synthetic access$getMReceiver$p()Lcom/rokid/security/phone/sdk/api/camera/IMediaReceiver;
    .locals 1

    .line 15
    sget-object v0, Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl;->mReceiver:Lcom/rokid/security/phone/sdk/api/camera/IMediaReceiver;

    return-object v0
.end method


# virtual methods
.method public setMediaReceiver(Lcom/rokid/security/phone/sdk/api/camera/IMediaReceiver;)V
    .locals 1
    .param p1, "receiver"    # Lcom/rokid/security/phone/sdk/api/camera/IMediaReceiver;

    const-string v0, "receiver"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 58
    sput-object p1, Lcom/rokid/security/phone/sdk/server/media/MediaServiceImpl;->mReceiver:Lcom/rokid/security/phone/sdk/api/camera/IMediaReceiver;

    .line 59
    return-void
.end method
