.class Lcom/amazonaws/mobile/client/AWSMobileClient$18$1;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/handlers/GenericHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient$18;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$18;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient$18;)V
    .locals 0
    .param p1, "this$1"    # Lcom/amazonaws/mobile/client/AWSMobileClient$18;

    .line 2468
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$18$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$18;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/Exception;)V
    .locals 1
    .param p1, "exception"    # Ljava/lang/Exception;

    .line 2476
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$18$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$18;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$18;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    invoke-interface {v0, p1}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 2477
    return-void
.end method

.method public onSuccess()V
    .locals 2

    .line 2471
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$18$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$18;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$18;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V

    .line 2472
    return-void
.end method
