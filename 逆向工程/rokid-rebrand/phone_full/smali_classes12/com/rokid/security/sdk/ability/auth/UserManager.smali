.class public final Lcom/rokid/security/sdk/ability/auth/UserManager;
.super Ljava/lang/Object;
.source "UserManager.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0004\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0005\u001a\u00020\u0006J\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u0004J\u000e\u0010\u0008\u001a\u00020\u00062\u0006\u0010\t\u001a\u00020\u0004R\u0010\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\n"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/auth/UserManager;",
        "",
        "()V",
        "mUserInfo",
        "Lcom/rokid/security/sdk/base/common/outside/UserInfo;",
        "clearUserInfo",
        "",
        "getUserInfo",
        "setUserInfo",
        "user",
        "sdk-common-ability_release"
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

.field private static volatile mUserInfo:Lcom/rokid/security/sdk/base/common/outside/UserInfo;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/auth/UserManager;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final clearUserInfo()V
    .locals 1

    .line 17
    const/4 v0, 0x0

    sput-object v0, Lcom/rokid/security/sdk/ability/auth/UserManager;->mUserInfo:Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    .line 18
    return-void
.end method

.method public final getUserInfo()Lcom/rokid/security/sdk/base/common/outside/UserInfo;
    .locals 1

    .line 21
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/UserManager;->mUserInfo:Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    return-object v0
.end method

.method public final setUserInfo(Lcom/rokid/security/sdk/base/common/outside/UserInfo;)V
    .locals 1
    .param p1, "user"    # Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    const-string/jumbo v0, "user"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13
    sput-object p1, Lcom/rokid/security/sdk/ability/auth/UserManager;->mUserInfo:Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    .line 14
    return-void
.end method
