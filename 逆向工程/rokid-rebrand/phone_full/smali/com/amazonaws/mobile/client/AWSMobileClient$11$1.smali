.class Lcom/amazonaws/mobile/client/AWSMobileClient$11$1;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/handlers/AuthenticationHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient$11;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$11;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient$11;)V
    .locals 0
    .param p1, "this$1"    # Lcom/amazonaws/mobile/client/AWSMobileClient$11;

    .line 1836
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$11$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$11;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private signalTokensNotAvailable(Ljava/lang/Exception;)V
    .locals 3
    .param p1, "e"    # Ljava/lang/Exception;

    .line 1872
    invoke-static {}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$200()Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "signalTokensNotAvailable"

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1873
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$11$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$11;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$11;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v1, Ljava/lang/Exception;

    const-string v2, "No cached session."

    invoke-direct {v1, v2, p1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-interface {v0, v1}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 1874
    return-void
.end method


# virtual methods
.method public authenticationChallenge(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ChallengeContinuation;)V
    .locals 1
    .param p1, "continuation"    # Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ChallengeContinuation;

    .line 1863
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient$11$1;->signalTokensNotAvailable(Ljava/lang/Exception;)V

    .line 1864
    return-void
.end method

.method public getAuthenticationDetails(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/AuthenticationContinuation;Ljava/lang/String;)V
    .locals 1
    .param p1, "authenticationContinuation"    # Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/AuthenticationContinuation;
    .param p2, "userId"    # Ljava/lang/String;

    .line 1853
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient$11$1;->signalTokensNotAvailable(Ljava/lang/Exception;)V

    .line 1854
    return-void
.end method

.method public getMFACode(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/MultiFactorAuthenticationContinuation;)V
    .locals 1
    .param p1, "continuation"    # Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/MultiFactorAuthenticationContinuation;

    .line 1858
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient$11$1;->signalTokensNotAvailable(Ljava/lang/Exception;)V

    .line 1859
    return-void
.end method

.method public onFailure(Ljava/lang/Exception;)V
    .locals 0
    .param p1, "exception"    # Ljava/lang/Exception;

    .line 1868
    invoke-direct {p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$11$1;->signalTokensNotAvailable(Ljava/lang/Exception;)V

    .line 1869
    return-void
.end method

.method public onSuccess(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoDevice;)V
    .locals 5
    .param p1, "userSession"    # Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;
    .param p2, "newDevice"    # Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoDevice;

    .line 1840
    :try_start_0
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$11$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$11;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$11;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iput-object p1, v0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mCognitoUserSession:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;

    .line 1841
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$11$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$11;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient$11;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v1, Lcom/amazonaws/mobile/client/results/Tokens;

    .line 1842
    invoke-virtual {p1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;->getAccessToken()Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/tokens/CognitoAccessToken;

    move-result-object v2

    invoke-virtual {v2}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/tokens/CognitoAccessToken;->getJWTToken()Ljava/lang/String;

    move-result-object v2

    .line 1843
    invoke-virtual {p1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;->getIdToken()Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/tokens/CognitoIdToken;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/tokens/CognitoIdToken;->getJWTToken()Ljava/lang/String;

    move-result-object v3

    .line 1844
    invoke-virtual {p1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;->getRefreshToken()Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/tokens/CognitoRefreshToken;

    move-result-object v4

    invoke-virtual {v4}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/tokens/CognitoRefreshToken;->getToken()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, v2, v3, v4}, Lcom/amazonaws/mobile/client/results/Tokens;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 1841
    invoke-interface {v0, v1}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1848
    goto :goto_0

    .line 1846
    :catch_0
    move-exception v0

    .line 1847
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$11$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$11;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient$11;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    invoke-interface {v1, v0}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 1849
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method
