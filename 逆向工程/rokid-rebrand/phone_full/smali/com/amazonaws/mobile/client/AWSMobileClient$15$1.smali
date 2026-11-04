.class Lcom/amazonaws/mobile/client/AWSMobileClient$15$1;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/handlers/VerificationHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient$15;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$15;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient$15;)V
    .locals 0
    .param p1, "this$1"    # Lcom/amazonaws/mobile/client/AWSMobileClient$15;

    .line 2227
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$15$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$15;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/Exception;)V
    .locals 1
    .param p1, "exception"    # Ljava/lang/Exception;

    .line 2244
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$15$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$15;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$15;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    invoke-interface {v0, p1}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 2245
    return-void
.end method

.method public onSuccess(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserCodeDeliveryDetails;)V
    .locals 5
    .param p1, "verificationCodeDeliveryMedium"    # Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserCodeDeliveryDetails;

    .line 2230
    new-instance v0, Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;

    .line 2231
    invoke-virtual {p1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserCodeDeliveryDetails;->getDestination()Ljava/lang/String;

    move-result-object v1

    .line 2232
    invoke-virtual {p1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserCodeDeliveryDetails;->getDeliveryMedium()Ljava/lang/String;

    move-result-object v2

    .line 2233
    invoke-virtual {p1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserCodeDeliveryDetails;->getAttributeName()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v1, v2, v3}, Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 2235
    .local v0, "userCodeDeliveryDetails":Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$15$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$15;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$15;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v2, Lcom/amazonaws/mobile/client/results/SignUpResult;

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-direct {v2, v3, v0, v4}, Lcom/amazonaws/mobile/client/results/SignUpResult;-><init>(ZLcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;Ljava/lang/String;)V

    invoke-interface {v1, v2}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V

    .line 2240
    return-void
.end method
