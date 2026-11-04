.class Lcom/amazonaws/mobile/client/AWSMobileClient$25$1;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Lcom/amazonaws/mobileconnectors/cognitoauth/handlers/AuthHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient$25;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field hasSucceededOnce:Z

.field final synthetic this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$25;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient$25;)V
    .locals 1
    .param p1, "this$1"    # Lcom/amazonaws/mobile/client/AWSMobileClient$25;

    .line 3269
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$25;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3270
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1;->hasSucceededOnce:Z

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/Exception;)V
    .locals 2
    .param p1, "e"    # Ljava/lang/Exception;

    .line 3311
    iget-boolean v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1;->hasSucceededOnce:Z

    if-eqz v0, :cond_0

    .line 3312
    invoke-static {}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$200()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onFailure: Ignoring failure because HostedUI has signaled success at least once."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 3314
    return-void

    .line 3316
    :cond_0
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1$3;

    invoke-direct {v1, p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1$3;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient$25$1;Ljava/lang/Exception;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 3321
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 3322
    return-void
.end method

.method public onSignout()V
    .locals 2

    .line 3306
    invoke-static {}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$200()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onSignout: HostedUI signed-out"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 3307
    return-void
.end method

.method public onSuccess(Lcom/amazonaws/mobileconnectors/cognitoauth/AuthUserSession;)V
    .locals 4
    .param p1, "session"    # Lcom/amazonaws/mobileconnectors/cognitoauth/AuthUserSession;

    .line 3274
    invoke-static {}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$200()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onSuccess: HostedUI signed-in"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 3275
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1;->hasSucceededOnce:Z

    .line 3276
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$25;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isFederationEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 3277
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$25;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$25;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpoolsLoginKey:Ljava/lang/String;

    .line 3278
    invoke-virtual {p1}, Lcom/amazonaws/mobileconnectors/cognitoauth/AuthUserSession;->getIdToken()Lcom/amazonaws/mobileconnectors/cognitoauth/tokens/IdToken;

    move-result-object v2

    invoke-virtual {v2}, Lcom/amazonaws/mobileconnectors/cognitoauth/tokens/IdToken;->getJWTToken()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1$1;

    invoke-direct {v3, p0}, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1$1;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient$25$1;)V

    .line 3277
    invoke-virtual {v0, v1, v2, v3}, Lcom/amazonaws/mobile/client/AWSMobileClient;->federatedSignInWithoutAssigningState(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V

    .line 3293
    :cond_0
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1$2;

    invoke-direct {v1, p0}, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1$2;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient$25$1;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 3301
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 3302
    return-void
.end method
