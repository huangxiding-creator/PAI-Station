.class public final Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/log/api/AbsSdkLogService;
.source "SdkLogServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000&\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\t\u001a\u00020\nJ\u0006\u0010\u000b\u001a\u00020\nJ\u0016\u0010\u000c\u001a\u00020\n2\u000c\u0010\r\u001a\u0008\u0012\u0004\u0012\u00020\u000f0\u000eH\u0016R\u001b\u0010\u0003\u001a\u00020\u00048BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0007\u0010\u0008\u001a\u0004\u0008\u0005\u0010\u0006\u00a8\u0006\u0010"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/log/api/AbsSdkLogService;",
        "()V",
        "mSdkLogManager",
        "Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;",
        "getMSdkLogManager",
        "()Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;",
        "mSdkLogManager$delegate",
        "Lkotlin/Lazy;",
        "init",
        "",
        "release",
        "uploadSDKLog",
        "callback",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
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


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;

.field private static final mSdkLogManager$delegate:Lkotlin/Lazy;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;

    .line 11
    sget-object v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl$mSdkLogManager$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl$mSdkLogManager$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;->mSdkLogManager$delegate:Lkotlin/Lazy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/log/api/AbsSdkLogService;-><init>()V

    return-void
.end method

.method private final getMSdkLogManager()Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;
    .locals 1

    .line 11
    sget-object v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;->mSdkLogManager$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;

    return-object v0
.end method


# virtual methods
.method public final init()V
    .locals 1

    .line 16
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;->getMSdkLogManager()Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->init()V

    .line 17
    return-void
.end method

.method public final release()V
    .locals 1

    .line 24
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;->getMSdkLogManager()Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->release()V

    .line 25
    return-void
.end method

.method public uploadSDKLog(Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
    .locals 1
    .param p1, "callback"    # Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    const-string v0, "callback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogServiceImpl;->getMSdkLogManager()Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->uploadSDKLog(Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V

    .line 21
    return-void
.end method
