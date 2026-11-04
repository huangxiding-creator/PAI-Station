.class Lcom/amazonaws/mobile/client/AWSMobileClient$2$1$1;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Lcom/amazonaws/mobile/client/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;->onUserSignedIn()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/amazonaws/mobile/client/Callback<",
        "Lcom/amazonaws/mobile/client/UserStateDetails;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;)V
    .locals 0
    .param p1, "this$2"    # Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;

    .line 499
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1$1;->this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError(Ljava/lang/Exception;)V
    .locals 3
    .param p1, "e"    # Ljava/lang/Exception;

    .line 509
    invoke-static {}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$200()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onError: User sign-in had errors from drop-in UI"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 510
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1$1;->this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$2;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1$1;->this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$2;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getUserStateDetails(Z)Lcom/amazonaws/mobile/client/UserStateDetails;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->setUserState(Lcom/amazonaws/mobile/client/UserStateDetails;)V

    .line 511
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1$1;->this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$2;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getSignInUILatch()Ljava/util/concurrent/CountDownLatch;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    .line 512
    return-void
.end method

.method public onResult(Lcom/amazonaws/mobile/client/UserStateDetails;)V
    .locals 3
    .param p1, "result"    # Lcom/amazonaws/mobile/client/UserStateDetails;

    .line 502
    invoke-static {}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$200()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onResult: showSignIn federated"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 503
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1$1;->this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$2;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1$1;->this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$2;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getUserStateDetails(Z)Lcom/amazonaws/mobile/client/UserStateDetails;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->setUserState(Lcom/amazonaws/mobile/client/UserStateDetails;)V

    .line 504
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1$1;->this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$2;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getSignInUILatch()Ljava/util/concurrent/CountDownLatch;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    .line 505
    return-void
.end method

.method public bridge synthetic onResult(Ljava/lang/Object;)V
    .locals 0

    .line 499
    check-cast p1, Lcom/amazonaws/mobile/client/UserStateDetails;

    invoke-virtual {p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1$1;->onResult(Lcom/amazonaws/mobile/client/UserStateDetails;)V

    return-void
.end method
