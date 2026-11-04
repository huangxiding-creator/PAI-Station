.class Lcom/amazonaws/mobile/auth/core/IdentityManager$6$1$1;
.super Ljava/lang/Object;
.source "IdentityManager.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/auth/core/IdentityManager$6$1;->onSuccess(Lcom/amazonaws/mobile/auth/core/IdentityProvider;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$2:Lcom/amazonaws/mobile/auth/core/IdentityManager$6$1;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/auth/core/IdentityManager$6$1;)V
    .locals 0
    .param p1, "this$2"    # Lcom/amazonaws/mobile/auth/core/IdentityManager$6$1;

    .line 754
    iput-object p1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager$6$1$1;->this$2:Lcom/amazonaws/mobile/auth/core/IdentityManager$6$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 757
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager$6$1$1;->this$2:Lcom/amazonaws/mobile/auth/core/IdentityManager$6$1;

    iget-object v0, v0, Lcom/amazonaws/mobile/auth/core/IdentityManager$6$1;->this$1:Lcom/amazonaws/mobile/auth/core/IdentityManager$6;

    iget-object v0, v0, Lcom/amazonaws/mobile/auth/core/IdentityManager$6;->val$startupAuthResultHandler:Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;

    new-instance v1, Lcom/amazonaws/mobile/auth/core/StartupAuthResult;

    iget-object v2, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager$6$1$1;->this$2:Lcom/amazonaws/mobile/auth/core/IdentityManager$6$1;

    iget-object v2, v2, Lcom/amazonaws/mobile/auth/core/IdentityManager$6$1;->this$1:Lcom/amazonaws/mobile/auth/core/IdentityManager$6;

    iget-object v2, v2, Lcom/amazonaws/mobile/auth/core/IdentityManager$6;->this$0:Lcom/amazonaws/mobile/auth/core/IdentityManager;

    const/4 v3, 0x0

    invoke-direct {v1, v2, v3}, Lcom/amazonaws/mobile/auth/core/StartupAuthResult;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Lcom/amazonaws/mobile/auth/core/StartupAuthErrorDetails;)V

    invoke-interface {v0, v1}, Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;->onComplete(Lcom/amazonaws/mobile/auth/core/StartupAuthResult;)V

    .line 758
    return-void
.end method
