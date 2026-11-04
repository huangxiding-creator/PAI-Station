.class Lcom/amazonaws/mobile/client/AWSMobileClient$9;
.super Lcom/amazonaws/mobile/client/internal/ReturningRunnable;
.source "AWSMobileClient.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient;->_signOut(Lcom/amazonaws/mobile/client/SignOutOptions;)Lcom/amazonaws/mobile/client/internal/ReturningRunnable;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/amazonaws/mobile/client/internal/ReturningRunnable<",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

.field final synthetic val$signOutOptions:Lcom/amazonaws/mobile/client/SignOutOptions;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/SignOutOptions;)V
    .locals 0
    .param p1, "this$0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 1534
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iput-object p2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->val$signOutOptions:Lcom/amazonaws/mobile/client/SignOutOptions;

    invoke-direct {p0}, Lcom/amazonaws/mobile/client/internal/ReturningRunnable;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic run()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1534
    invoke-virtual {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->run()Ljava/lang/Void;

    move-result-object v0

    return-object v0
.end method

.method public run()Ljava/lang/Void;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1537
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->val$signOutOptions:Lcom/amazonaws/mobile/client/SignOutOptions;

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/SignOutOptions;->isSignOutGlobally()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1538
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;

    invoke-direct {v0}, Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;-><init>()V

    .line 1539
    .local v0, "globalSignOutRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getTokens()Lcom/amazonaws/mobile/client/results/Tokens;

    move-result-object v1

    invoke-virtual {v1}, Lcom/amazonaws/mobile/client/results/Tokens;->getAccessToken()Lcom/amazonaws/mobile/client/results/Token;

    move-result-object v1

    invoke-virtual {v1}, Lcom/amazonaws/mobile/client/results/Token;->getTokenString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;->setAccessToken(Ljava/lang/String;)V

    .line 1541
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpoolLL:Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProvider;

    invoke-interface {v1, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProvider;->globalSignOut(Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutResult;

    .line 1543
    .end local v0    # "globalSignOutRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->val$signOutOptions:Lcom/amazonaws/mobile/client/SignOutOptions;

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/SignOutOptions;->isInvalidateTokens()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_6

    .line 1544
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    if-eqz v0, :cond_2

    .line 1545
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->val$signOutOptions:Lcom/amazonaws/mobile/client/SignOutOptions;

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/SignOutOptions;->getBrowserPackage()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 1546
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->val$signOutOptions:Lcom/amazonaws/mobile/client/SignOutOptions;

    invoke-virtual {v2}, Lcom/amazonaws/mobile/client/SignOutOptions;->getBrowserPackage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;->setBrowserPackage(Ljava/lang/String;)V

    .line 1548
    :cond_1
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    invoke-virtual {v0}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;->signOut()V

    goto/16 :goto_1

    .line 1549
    :cond_2
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v0, v0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mOAuth2Client:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

    if-eqz v0, :cond_6

    .line 1550
    new-instance v0, Ljava/util/concurrent/CountDownLatch;

    const/4 v2, 0x1

    invoke-direct {v0, v2}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    .line 1551
    .local v0, "latch":Ljava/util/concurrent/CountDownLatch;
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v3}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getHostedUIJSON()Lorg/json/JSONObject;

    move-result-object v3

    .line 1552
    .local v3, "hostedUIJSON":Lorg/json/JSONObject;
    const-string v4, "SignOutURI"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 1553
    .local v4, "signOutUriString":Ljava/lang/String;
    invoke-static {v4}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v5

    invoke-virtual {v5}, Landroid/net/Uri;->buildUpon()Landroid/net/Uri$Builder;

    move-result-object v5

    .line 1554
    .local v5, "uriBuilder":Landroid/net/Uri$Builder;
    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v6}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getHostedUIJSON()Lorg/json/JSONObject;

    move-result-object v6

    const-string v7, "SignOutRedirectURI"

    invoke-virtual {v6, v7, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    if-eqz v6, :cond_3

    .line 1555
    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v6}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getHostedUIJSON()Lorg/json/JSONObject;

    move-result-object v6

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v7, "redirect_uri"

    invoke-virtual {v5, v7, v6}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    .line 1558
    :cond_3
    const-string v6, "SignOutQueryParameters"

    invoke-virtual {v3, v6}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v6

    .line 1560
    .local v6, "signOutQueryParametersJSON":Lorg/json/JSONObject;
    if-eqz v6, :cond_4

    .line 1561
    invoke-virtual {v6}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v7

    .line 1562
    .local v7, "keysIterator":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    :goto_0
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_4

    .line 1563
    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .line 1564
    .local v8, "key":Ljava/lang/String;
    invoke-virtual {v6, v8}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v5, v8, v9}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    .line 1565
    .end local v8    # "key":Ljava/lang/String;
    goto :goto_0

    .line 1567
    .end local v7    # "keysIterator":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/lang/String;>;"
    :cond_4
    new-array v2, v2, [Ljava/lang/Exception;

    .line 1568
    .local v2, "signOutError":[Ljava/lang/Exception;
    iget-object v7, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v7, v7, Lcom/amazonaws/mobile/client/AWSMobileClient;->mOAuth2Client:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

    invoke-virtual {v5}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v8

    new-instance v9, Lcom/amazonaws/mobile/client/AWSMobileClient$9$1;

    invoke-direct {v9, p0, v0, v2}, Lcom/amazonaws/mobile/client/AWSMobileClient$9$1;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient$9;Ljava/util/concurrent/CountDownLatch;[Ljava/lang/Exception;)V

    invoke-virtual {v7, v8, v9}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->signOut(Landroid/net/Uri;Lcom/amazonaws/mobile/client/Callback;)V

    .line 1580
    invoke-virtual {v0}, Ljava/util/concurrent/CountDownLatch;->await()V

    .line 1581
    const/4 v7, 0x0

    aget-object v8, v2, v7

    if-nez v8, :cond_5

    goto :goto_1

    .line 1582
    :cond_5
    aget-object v1, v2, v7

    throw v1

    .line 1586
    .end local v0    # "latch":Ljava/util/concurrent/CountDownLatch;
    .end local v2    # "signOutError":[Ljava/lang/Exception;
    .end local v3    # "hostedUIJSON":Lorg/json/JSONObject;
    .end local v4    # "signOutUriString":Ljava/lang/String;
    .end local v5    # "uriBuilder":Landroid/net/Uri$Builder;
    .end local v6    # "signOutQueryParametersJSON":Lorg/json/JSONObject;
    :cond_6
    :goto_1
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->signOut()V

    .line 1587
    return-object v1
.end method
