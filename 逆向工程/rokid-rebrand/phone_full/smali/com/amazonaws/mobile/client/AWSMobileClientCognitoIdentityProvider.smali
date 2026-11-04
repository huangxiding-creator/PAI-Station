.class Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;
.super Lcom/amazonaws/auth/AWSAbstractCognitoIdentityProvider;
.source "AWSMobileClient.java"


# instance fields
.field isDeveloperAuthenticated:Z


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentity;)V
    .locals 0
    .param p1, "accountId"    # Ljava/lang/String;
    .param p2, "identityPoolId"    # Ljava/lang/String;
    .param p3, "cibClient"    # Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentity;

    .line 3811
    invoke-direct {p0, p1, p2, p3}, Lcom/amazonaws/auth/AWSAbstractCognitoIdentityProvider;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentity;)V

    .line 3812
    return-void
.end method


# virtual methods
.method public getProviderName()Ljava/lang/String;
    .locals 1

    .line 3843
    const-string v0, "Cognito"

    return-object v0
.end method

.method protected getUserAgent()Ljava/lang/String;
    .locals 1

    .line 3816
    const-string v0, "AWSMobileClient"

    return-object v0
.end method

.method public refresh()Ljava/lang/String;
    .locals 1

    .line 3848
    iget-boolean v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;->isDeveloperAuthenticated:Z

    if-eqz v0, :cond_0

    .line 3850
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;->token:Ljava/lang/String;

    return-object v0

    .line 3852
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;->getIdentityId()Ljava/lang/String;

    .line 3853
    const/4 v0, 0x0

    return-object v0
.end method

.method setDeveloperAuthenticated(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "identityId"    # Ljava/lang/String;
    .param p2, "token"    # Ljava/lang/String;

    .line 3828
    invoke-super {p0, p1}, Lcom/amazonaws/auth/AWSAbstractCognitoIdentityProvider;->setIdentityId(Ljava/lang/String;)V

    .line 3829
    invoke-super {p0, p2}, Lcom/amazonaws/auth/AWSAbstractCognitoIdentityProvider;->setToken(Ljava/lang/String;)V

    .line 3830
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;->isDeveloperAuthenticated:Z

    .line 3831
    return-void
.end method

.method setNotDeveloperAuthenticated()V
    .locals 1

    .line 3838
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;->isDeveloperAuthenticated:Z

    .line 3839
    return-void
.end method
