.class Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1$1;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Lcom/amazonaws/mobile/client/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;->onResult(Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;)V
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
.field final synthetic this$3:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;)V
    .locals 0
    .param p1, "this$3"    # Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;

    .line 3156
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1$1;->this$3:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError(Ljava/lang/Exception;)V
    .locals 2
    .param p1, "e"    # Ljava/lang/Exception;

    .line 3167
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1$1;->this$3:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;->this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$24;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$24;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 3168
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getUserStateDetails(Z)Lcom/amazonaws/mobile/client/UserStateDetails;

    move-result-object v0

    .line 3169
    .local v0, "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1$1;->this$3:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;->this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$24;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$24;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    invoke-interface {v1, v0}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V

    .line 3170
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1$1;->this$3:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;->this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$24;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$24;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->setUserState(Lcom/amazonaws/mobile/client/UserStateDetails;)V

    .line 3171
    return-void
.end method

.method public onResult(Lcom/amazonaws/mobile/client/UserStateDetails;)V
    .locals 2
    .param p1, "result"    # Lcom/amazonaws/mobile/client/UserStateDetails;

    .line 3159
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1$1;->this$3:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;->this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$24;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$24;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 3160
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getUserStateDetails(Z)Lcom/amazonaws/mobile/client/UserStateDetails;

    move-result-object v0

    .line 3161
    .local v0, "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1$1;->this$3:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;->this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$24;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$24;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    invoke-interface {v1, v0}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V

    .line 3162
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1$1;->this$3:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1;->this$2:Lcom/amazonaws/mobile/client/AWSMobileClient$24$1;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$24;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$24;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->setUserState(Lcom/amazonaws/mobile/client/UserStateDetails;)V

    .line 3163
    return-void
.end method

.method public bridge synthetic onResult(Ljava/lang/Object;)V
    .locals 0

    .line 3156
    check-cast p1, Lcom/amazonaws/mobile/client/UserStateDetails;

    invoke-virtual {p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$24$1$1$1;->onResult(Lcom/amazonaws/mobile/client/UserStateDetails;)V

    return-void
.end method
