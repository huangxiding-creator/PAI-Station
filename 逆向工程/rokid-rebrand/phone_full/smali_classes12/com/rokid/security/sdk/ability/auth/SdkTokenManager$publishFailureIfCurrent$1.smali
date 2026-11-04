.class final Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishFailureIfCurrent$1;
.super Lkotlin/jvm/internal/Lambda;
.source "SdkTokenManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->publishFailureIfCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;Lkotlin/jvm/functions/Function0;)V
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

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nSdkTokenManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 SdkTokenManager.kt\ncom/rokid/security/sdk/ability/auth/SdkTokenManager$publishFailureIfCurrent$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,525:1\n1#2:526\n*E\n"
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
.field final synthetic $failureLease:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;

.field final synthetic this$0:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishFailureIfCurrent$1;->this$0:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishFailureIfCurrent$1;->$failureLease:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public final invoke()Ljava/lang/Boolean;
    .locals 4

    .line 488
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishFailureIfCurrent$1;->this$0:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishFailureIfCurrent$1;->$failureLease:Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;

    monitor-enter v0

    .line 526
    const/4 v2, 0x0

    .line 488
    .local v2, "$i$a$-synchronized-SdkTokenManager$publishFailureIfCurrent$1$1":I
    :try_start_0
    invoke-static {}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->access$getRefreshGuard$p()Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;

    move-result-object v3

    invoke-virtual {v3, v1}, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;->isCurrent(Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;)Z

    move-result v1

    .end local v2    # "$i$a$-synchronized-SdkTokenManager$publishFailureIfCurrent$1$1":I
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 486
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager$publishFailureIfCurrent$1;->invoke()Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method
