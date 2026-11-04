.class final Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$applyUserCredentialAndRefresh$1;
.super Lkotlin/jvm/internal/Lambda;
.source "SdkTokenManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->applyUserCredentialAndRefresh(Lcom/rokid/security/sdk/base/common/outside/UserInfo;Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function0<",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0008\n\u0000\n\u0002\u0010\u0002\n\u0000\u0010\u0000\u001a\u00020\u0001H\n\u00a2\u0006\u0002\u0008\u0002"
    }
    d2 = {
        "<anonymous>",
        "",
        "invoke"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $deviceInfo:Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

.field final synthetic $userInfo:Lcom/rokid/security/sdk/base/common/outside/UserInfo;

.field final synthetic this$0:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;Lcom/rokid/security/sdk/base/common/outside/UserInfo;Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$applyUserCredentialAndRefresh$1;->this$0:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$applyUserCredentialAndRefresh$1;->$userInfo:Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    iput-object p3, p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$applyUserCredentialAndRefresh$1;->$deviceInfo:Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 72
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$applyUserCredentialAndRefresh$1;->invoke()V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke()V
    .locals 7

    .line 73
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$applyUserCredentialAndRefresh$1;->this$0:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$applyUserCredentialAndRefresh$1;->$userInfo:Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$applyUserCredentialAndRefresh$1;->$deviceInfo:Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    monitor-enter v0

    const/4 v3, 0x0

    .line 74
    .local v3, "$i$a$-synchronized-SdkTokenManager$applyUserCredentialAndRefresh$1$1":I
    :try_start_0
    invoke-static {}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->access$getRefreshGuard$p()Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

    move-result-object v4

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->stop()V

    .line 75
    invoke-static {}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->access$getSdkJob$p()Lkotlinx/coroutines/Job;

    move-result-object v4

    const/4 v5, 0x0

    if-eqz v4, :cond_0

    const/4 v6, 0x1

    invoke-static {v4, v5, v6, v5}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 76
    :cond_0
    sget-object v4, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-static {v5}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->access$setSdkJob$p(Lkotlinx/coroutines/Job;)V

    .line 77
    sget-object v4, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    const-string v4, ""

    invoke-static {v4}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->access$setActiveRefreshKey$p(Ljava/lang/String;)V

    .line 78
    sget-object v4, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v4, v1}, Lcom/rokid/security/sdk/ability/auth/UserManager;->setUserInfo(Lcom/rokid/security/sdk/base/common/outside/UserInfo;)V

    .line 79
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-virtual {v1, v2}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->refreshToken(Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;)V

    .line 80
    nop

    .end local v3    # "$i$a$-synchronized-SdkTokenManager$applyUserCredentialAndRefresh$1$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 73
    monitor-exit v0

    .line 81
    return-void

    .line 73
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method
