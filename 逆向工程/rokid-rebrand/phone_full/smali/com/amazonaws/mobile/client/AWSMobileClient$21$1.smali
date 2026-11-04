.class Lcom/amazonaws/mobile/client/AWSMobileClient$21$1;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/handlers/VerificationHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient$21;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$21;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient$21;)V
    .locals 0
    .param p1, "this$1"    # Lcom/amazonaws/mobile/client/AWSMobileClient$21;

    .line 2698
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$21$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$21;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/Exception;)V
    .locals 1
    .param p1, "exception"    # Ljava/lang/Exception;

    .line 2710
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$21$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$21;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$21;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    invoke-interface {v0, p1}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 2711
    return-void
.end method

.method public onSuccess(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserCodeDeliveryDetails;)V
    .locals 5
    .param p1, "verificationCodeDeliveryMedium"    # Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserCodeDeliveryDetails;

    .line 2701
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$21$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$21;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$21;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v1, Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;

    .line 2702
    invoke-virtual {p1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserCodeDeliveryDetails;->getDestination()Ljava/lang/String;

    move-result-object v2

    .line 2703
    invoke-virtual {p1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserCodeDeliveryDetails;->getDeliveryMedium()Ljava/lang/String;

    move-result-object v3

    .line 2704
    invoke-virtual {p1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserCodeDeliveryDetails;->getAttributeName()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, v2, v3, v4}, Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 2701
    invoke-interface {v0, v1}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V

    .line 2706
    return-void
.end method
