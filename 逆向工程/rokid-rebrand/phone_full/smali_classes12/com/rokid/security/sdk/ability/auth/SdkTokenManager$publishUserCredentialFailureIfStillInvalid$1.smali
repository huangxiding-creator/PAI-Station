.class final Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishUserCredentialFailureIfStillInvalid$1;
.super Lkotlin/jvm/internal/Lambda;
.source "SdkTokenManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->publishUserCredentialFailureIfStillInvalid()Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function0<",
        "Ljava/lang/Boolean;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\u0010\u0000\u001a\u00020\u0001H\n\u00a2\u0006\u0004\u0008\u0002\u0010\u0003"
    }
    d2 = {
        "<anonymous>",
        "",
        "invoke",
        "()Ljava/lang/Boolean;"
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
.field final synthetic this$0:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishUserCredentialFailureIfStillInvalid$1;->this$0:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public final invoke()Ljava/lang/Boolean;
    .locals 4

    .line 117
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishUserCredentialFailureIfStillInvalid$1;->this$0:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    monitor-enter v0

    const/4 v1, 0x0

    .line 118
    .local v1, "$i$a$-synchronized-SdkTokenManager$publishUserCredentialFailureIfStillInvalid$1$1":I
    :try_start_0
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->getAuthState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v2

    invoke-interface {v2}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v2

    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;->INVALID:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$AuthState;

    if-ne v2, v3, :cond_0

    sget-object v2, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/auth/UserManager;->getUserInfo()Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    move-result-object v2

    if-nez v2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    .end local v1    # "$i$a$-synchronized-SdkTokenManager$publishUserCredentialFailureIfStillInvalid$1$1":I
    :goto_0
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 117
    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 115
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishUserCredentialFailureIfStillInvalid$1;->invoke()Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method
