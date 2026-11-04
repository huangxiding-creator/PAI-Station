.class Lcom/amazonaws/mobile/client/AWSMobileClient$26;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient;->_showSignInDropInUI(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

.field final synthetic val$callback:Lcom/amazonaws/mobile/client/Callback;

.field final synthetic val$callingActivity:Landroid/app/Activity;

.field final synthetic val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;Lcom/amazonaws/mobile/client/SignInUIOptions;Landroid/app/Activity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 3346
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iput-object p2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    iput-object p3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;

    iput-object p4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$callingActivity:Landroid/app/Activity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    .line 3349
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-static {v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$1300(Lcom/amazonaws/mobile/client/AWSMobileClient;)Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 3350
    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getUserStateDetails(Z)Lcom/amazonaws/mobile/client/UserStateDetails;

    move-result-object v1

    invoke-virtual {v1}, Lcom/amazonaws/mobile/client/UserStateDetails;->getUserState()Lcom/amazonaws/mobile/client/UserState;

    move-result-object v1

    .line 3351
    .local v1, "userState":Lcom/amazonaws/mobile/client/UserState;
    sget-object v3, Lcom/amazonaws/mobile/client/UserState;->SIGNED_IN:Lcom/amazonaws/mobile/client/UserState;

    invoke-virtual {v3, v1}, Lcom/amazonaws/mobile/client/UserState;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 3352
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v3, Ljava/lang/RuntimeException;

    const-string v4, "Called showSignIn while user is already signed-in"

    invoke-direct {v3, v4}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    invoke-interface {v2, v3}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 3353
    monitor-exit v0

    return-void

    .line 3356
    :cond_0
    new-instance v3, Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;

    invoke-direct {v3}, Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;-><init>()V

    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;

    .line 3357
    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/SignInUIOptions;->canCancel()Z

    move-result v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;->canCancel(Z)Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;

    move-result-object v3

    .line 3358
    invoke-virtual {v3, v2}, Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;->isBackgroundColorFullScreen(Z)Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;

    move-result-object v3

    .line 3360
    .local v3, "authUIConfigBuilder":Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;
    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;

    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/SignInUIOptions;->getLogo()Ljava/lang/Integer;

    move-result-object v4

    if-eqz v4, :cond_1

    .line 3361
    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;

    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/SignInUIOptions;->getLogo()Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;->logoResId(I)Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;

    .line 3363
    :cond_1
    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;

    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/SignInUIOptions;->getBackgroundColor()Ljava/lang/Integer;

    move-result-object v4

    if-eqz v4, :cond_2

    .line 3364
    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;

    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/SignInUIOptions;->getBackgroundColor()Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;->backgroundColor(I)Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;

    .line 3367
    :cond_2
    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    const-string v5, "CognitoUserPool"

    invoke-static {v4, v5}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$1400(Lcom/amazonaws/mobile/client/AWSMobileClient;Ljava/lang/String;)Z

    move-result v4

    const/4 v5, 0x1

    if-eqz v4, :cond_3

    .line 3368
    invoke-virtual {v3, v5}, Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;->userPools(Z)Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;

    .line 3371
    :cond_3
    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    const-string v6, "FacebookSignIn"

    invoke-static {v4, v6}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$1400(Lcom/amazonaws/mobile/client/AWSMobileClient;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 3372
    const-class v4, Lcom/amazonaws/mobile/auth/facebook/FacebookButton;

    invoke-virtual {v3, v4}, Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;->signInButton(Ljava/lang/Class;)Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;

    .line 3375
    :cond_4
    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    const-string v6, "GoogleSignIn"

    invoke-static {v4, v6}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$1400(Lcom/amazonaws/mobile/client/AWSMobileClient;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 3376
    const-class v4, Lcom/amazonaws/mobile/auth/google/GoogleButton;

    invoke-virtual {v3, v4}, Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;->signInButton(Ljava/lang/Class;)Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;

    .line 3379
    :cond_5
    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;

    .line 3380
    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/SignInUIOptions;->nextActivity()Ljava/lang/Class;

    move-result-object v4

    if-nez v4, :cond_6

    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$callingActivity:Landroid/app/Activity;

    .line 3381
    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    goto :goto_0

    :cond_6
    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;

    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/SignInUIOptions;->nextActivity()Ljava/lang/Class;

    move-result-object v4

    .line 3382
    .local v4, "nextActivityClass":Ljava/lang/Class;, "Ljava/lang/Class<+Landroid/app/Activity;>;"
    :goto_0
    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v7, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v7, v7, Lcom/amazonaws/mobile/client/AWSMobileClient;->mContext:Landroid/content/Context;

    const-class v8, Lcom/amazonaws/mobile/auth/ui/SignInUI;

    invoke-virtual {v6, v7, v8}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getClient(Landroid/content/Context;Ljava/lang/Class;)Lcom/amazonaws/mobile/config/AWSConfigurable;

    move-result-object v6

    check-cast v6, Lcom/amazonaws/mobile/auth/ui/SignInUI;

    .line 3383
    .local v6, "signin":Lcom/amazonaws/mobile/auth/ui/SignInUI;
    iget-object v7, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$callingActivity:Landroid/app/Activity;

    invoke-virtual {v6, v7, v4}, Lcom/amazonaws/mobile/auth/ui/SignInUI;->login(Landroid/app/Activity;Ljava/lang/Class;)Lcom/amazonaws/mobile/auth/ui/SignInUI$LoginBuilder;

    move-result-object v7

    .line 3384
    invoke-virtual {v3}, Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;->build()Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/amazonaws/mobile/auth/ui/SignInUI$LoginBuilder;->authUIConfiguration(Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration;)Lcom/amazonaws/mobile/auth/ui/SignInUI$LoginBuilder;

    move-result-object v7

    .line 3385
    invoke-virtual {v7, v2}, Lcom/amazonaws/mobile/auth/ui/SignInUI$LoginBuilder;->enableFederation(Z)Lcom/amazonaws/mobile/auth/ui/SignInUI$LoginBuilder;

    move-result-object v7

    .line 3386
    invoke-virtual {v7}, Lcom/amazonaws/mobile/auth/ui/SignInUI$LoginBuilder;->execute()V

    .line 3388
    iget-object v7, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    new-instance v8, Ljava/util/concurrent/CountDownLatch;

    invoke-direct {v8, v5}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    invoke-static {v7, v8}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$402(Lcom/amazonaws/mobile/client/AWSMobileClient;Ljava/util/concurrent/CountDownLatch;)Ljava/util/concurrent/CountDownLatch;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 3390
    :try_start_1
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-static {v5}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$400(Lcom/amazonaws/mobile/client/AWSMobileClient;)Ljava/util/concurrent/CountDownLatch;

    move-result-object v5

    invoke-virtual {v5}, Ljava/util/concurrent/CountDownLatch;->await()V

    .line 3391
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    iget-object v7, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v7, v2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getUserStateDetails(Z)Lcom/amazonaws/mobile/client/UserStateDetails;

    move-result-object v2

    invoke-interface {v5, v2}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V

    .line 3392
    invoke-static {}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$200()Ljava/lang/String;

    move-result-object v2

    const-string v5, "run: showSignIn completed"

    invoke-static {v2, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3395
    goto :goto_1

    .line 3393
    :catch_0
    move-exception v2

    .line 3394
    .local v2, "e":Ljava/lang/InterruptedException;
    :try_start_2
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    invoke-interface {v5, v2}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 3396
    .end local v1    # "userState":Lcom/amazonaws/mobile/client/UserState;
    .end local v2    # "e":Ljava/lang/InterruptedException;
    .end local v3    # "authUIConfigBuilder":Lcom/amazonaws/mobile/auth/ui/AuthUIConfiguration$Builder;
    .end local v4    # "nextActivityClass":Ljava/lang/Class;, "Ljava/lang/Class<+Landroid/app/Activity;>;"
    .end local v6    # "signin":Lcom/amazonaws/mobile/auth/ui/SignInUI;
    :goto_1
    monitor-exit v0

    .line 3397
    return-void

    .line 3396
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1
.end method
