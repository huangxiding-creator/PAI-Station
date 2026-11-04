.class Lcom/amazonaws/mobile/client/AWSMobileClient$13$1;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/handlers/SignUpHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient$13;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$13;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient$13;)V
    .locals 0
    .param p1, "this$1"    # Lcom/amazonaws/mobile/client/AWSMobileClient$13;

    .line 2020
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$13;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/Exception;)V
    .locals 1
    .param p1, "exception"    # Ljava/lang/Exception;

    .line 2051
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$13;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    invoke-interface {v0, p1}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 2052
    return-void
.end method

.method public onSuccess(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;)V
    .locals 5
    .param p1, "user"    # Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;
    .param p2, "signUpResult"    # Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;

    .line 2025
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$13;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-static {v0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$1002(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;)Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

    .line 2026
    if-nez p2, :cond_0

    .line 2027
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$13;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v1, Ljava/lang/Exception;

    const-string v2, "SignUpResult received is null"

    invoke-direct {v1, v2}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 2028
    return-void

    .line 2034
    :cond_0
    invoke-virtual {p2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;->getCodeDeliveryDetails()Lcom/amazonaws/services/cognitoidentityprovider/model/CodeDeliveryDetailsType;

    move-result-object v0

    if-nez v0, :cond_1

    .line 2035
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$13;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v1, Lcom/amazonaws/mobile/client/results/SignUpResult;

    invoke-virtual {p2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;->getUserConfirmed()Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    .line 2037
    invoke-virtual {p2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;->getUserSub()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-direct {v1, v2, v4, v3}, Lcom/amazonaws/mobile/client/results/SignUpResult;-><init>(ZLcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;Ljava/lang/String;)V

    .line 2035
    invoke-interface {v0, v1}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V

    goto :goto_0

    .line 2039
    :cond_1
    new-instance v0, Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;

    .line 2040
    invoke-virtual {p2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;->getCodeDeliveryDetails()Lcom/amazonaws/services/cognitoidentityprovider/model/CodeDeliveryDetailsType;

    move-result-object v1

    invoke-virtual {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/CodeDeliveryDetailsType;->getDestination()Ljava/lang/String;

    move-result-object v1

    .line 2041
    invoke-virtual {p2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;->getCodeDeliveryDetails()Lcom/amazonaws/services/cognitoidentityprovider/model/CodeDeliveryDetailsType;

    move-result-object v2

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/CodeDeliveryDetailsType;->getDeliveryMedium()Ljava/lang/String;

    move-result-object v2

    .line 2042
    invoke-virtual {p2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;->getCodeDeliveryDetails()Lcom/amazonaws/services/cognitoidentityprovider/model/CodeDeliveryDetailsType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/CodeDeliveryDetailsType;->getAttributeName()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v1, v2, v3}, Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 2043
    .local v0, "userCodeDeliveryDetails":Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$13;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v2, Lcom/amazonaws/mobile/client/results/SignUpResult;

    invoke-virtual {p2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;->getUserConfirmed()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    .line 2045
    invoke-virtual {p2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;->getUserSub()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v3, v0, v4}, Lcom/amazonaws/mobile/client/results/SignUpResult;-><init>(ZLcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;Ljava/lang/String;)V

    .line 2043
    invoke-interface {v1, v2}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V

    .line 2047
    .end local v0    # "userCodeDeliveryDetails":Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;
    :goto_0
    return-void
.end method
