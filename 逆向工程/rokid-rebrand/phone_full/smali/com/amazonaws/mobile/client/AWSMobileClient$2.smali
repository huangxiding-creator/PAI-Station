.class Lcom/amazonaws/mobile/client/AWSMobileClient$2;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient;->_initialize(Landroid/content/Context;Lcom/amazonaws/mobile/config/AWSConfiguration;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

.field final synthetic val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

.field final synthetic val$callback:Lcom/amazonaws/mobile/client/Callback;

.field final synthetic val$context:Landroid/content/Context;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;Lcom/amazonaws/mobile/config/AWSConfiguration;Landroid/content/Context;)V
    .locals 0
    .param p1, "this$0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 457
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iput-object p2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    iput-object p3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    iput-object p4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$context:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 14

    .line 459
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-static {v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$000(Lcom/amazonaws/mobile/client/AWSMobileClient;)Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 460
    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    .line 461
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v3, v2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getUserStateDetails(Z)Lcom/amazonaws/mobile/client/UserStateDetails;

    move-result-object v2

    invoke-interface {v1, v2}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V

    .line 462
    monitor-exit v0

    return-void

    .line 465
    :cond_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iput-boolean v2, v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->mIsPersistenceEnabled:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 469
    :try_start_1
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    const-string v3, "Auth"

    invoke-virtual {v1, v3}, Lcom/amazonaws/mobile/config/AWSConfiguration;->optJsonObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    const-string v3, "Auth"

    .line 470
    invoke-virtual {v1, v3}, Lcom/amazonaws/mobile/config/AWSConfiguration;->optJsonObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    const-string v3, "Persistence"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 471
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    const-string v4, "Auth"

    .line 472
    invoke-virtual {v3, v4}, Lcom/amazonaws/mobile/config/AWSConfiguration;->optJsonObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    const-string v4, "Persistence"

    .line 473
    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v3

    iput-boolean v3, v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->mIsPersistenceEnabled:Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 479
    :cond_1
    nop

    .line 481
    :try_start_2
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-virtual {v3}, Lcom/amazonaws/mobile/config/AWSConfiguration;->getUserAgentOverride()Ljava/lang/String;

    move-result-object v3

    iput-object v3, v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->userAgentOverride:Ljava/lang/String;

    .line 482
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$context:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    iput-object v3, v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->mContext:Landroid/content/Context;

    .line 483
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    new-instance v3, Lcom/amazonaws/mobile/client/AWSMobileClientStore;

    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-direct {v3, v4}, Lcom/amazonaws/mobile/client/AWSMobileClientStore;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;)V

    iput-object v3, v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    .line 485
    new-instance v1, Lcom/amazonaws/mobile/auth/core/IdentityManager;

    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v3, v3, Lcom/amazonaws/mobile/client/AWSMobileClient;->mContext:Landroid/content/Context;

    invoke-direct {v1, v3}, Lcom/amazonaws/mobile/auth/core/IdentityManager;-><init>(Landroid/content/Context;)V

    .line 486
    .local v1, "identityManager":Lcom/amazonaws/mobile/auth/core/IdentityManager;
    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->enableFederation(Z)V

    .line 487
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-virtual {v1, v3}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->setConfiguration(Lcom/amazonaws/mobile/config/AWSConfiguration;)V

    .line 488
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-boolean v3, v3, Lcom/amazonaws/mobile/client/AWSMobileClient;->mIsPersistenceEnabled:Z

    invoke-virtual {v1, v3}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->setPersistenceEnabled(Z)V

    .line 489
    invoke-static {v1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->setDefaultIdentityManager(Lcom/amazonaws/mobile/auth/core/IdentityManager;)V

    .line 490
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-static {v3, v4}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$100(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/config/AWSConfiguration;)V

    .line 491
    new-instance v3, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;

    invoke-direct {v3, p0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient$2$1;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient$2;Lcom/amazonaws/mobile/auth/core/IdentityManager;)V

    invoke-virtual {v1, v3}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->addSignInStateChangeListener(Lcom/amazonaws/mobile/auth/core/SignInStateChangeListener;)V

    .line 524
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    const-string v4, "CredentialsProvider"

    invoke-virtual {v3, v4}, Lcom/amazonaws/mobile/config/AWSConfiguration;->optJsonObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    if-eqz v3, :cond_4

    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    const-string v4, "CredentialsProvider"

    .line 525
    invoke-virtual {v3, v4}, Lcom/amazonaws/mobile/config/AWSConfiguration;->optJsonObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    const-string v4, "CognitoIdentity"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-eqz v3, :cond_4

    .line 527
    :try_start_3
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    const-string v4, "CredentialsProvider"

    invoke-virtual {v3, v4}, Lcom/amazonaws/mobile/config/AWSConfiguration;->optJsonObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    const-string v4, "CognitoIdentity"

    .line 528
    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-virtual {v4}, Lcom/amazonaws/mobile/config/AWSConfiguration;->getConfiguration()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3

    .line 529
    .local v3, "identityPoolJSON":Lorg/json/JSONObject;
    const-string v4, "PoolId"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 530
    .local v4, "poolId":Ljava/lang/String;
    const-string v5, "Region"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 531
    .local v5, "regionStr":Ljava/lang/String;
    new-instance v6, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v6}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    .line 532
    .local v6, "clientConfig":Lcom/amazonaws/ClientConfiguration;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "AWSMobileClient "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-virtual {v8}, Lcom/amazonaws/mobile/config/AWSConfiguration;->getUserAgent()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lcom/amazonaws/ClientConfiguration;->setUserAgent(Ljava/lang/String;)V

    .line 533
    iget-object v7, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v7, v7, Lcom/amazonaws/mobile/client/AWSMobileClient;->userAgentOverride:Ljava/lang/String;

    if-eqz v7, :cond_2

    .line 534
    iget-object v7, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v7, v7, Lcom/amazonaws/mobile/client/AWSMobileClient;->userAgentOverride:Ljava/lang/String;

    invoke-virtual {v6, v7}, Lcom/amazonaws/ClientConfiguration;->setUserAgentOverride(Ljava/lang/String;)V

    .line 536
    :cond_2
    new-instance v7, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;

    new-instance v8, Lcom/amazonaws/auth/AnonymousAWSCredentials;

    invoke-direct {v8}, Lcom/amazonaws/auth/AnonymousAWSCredentials;-><init>()V

    invoke-direct {v7, v8, v6}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/ClientConfiguration;)V

    .line 538
    .local v7, "cibClient":Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;
    invoke-static {v5}, Lcom/amazonaws/regions/Region;->getRegion(Ljava/lang/String;)Lcom/amazonaws/regions/Region;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->setRegion(Lcom/amazonaws/regions/Region;)V

    .line 539
    iget-object v8, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    new-instance v9, Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;

    const/4 v10, 0x0

    invoke-direct {v9, v10, v4, v7}, Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentity;)V

    iput-object v9, v8, Lcom/amazonaws/mobile/client/AWSMobileClient;->provider:Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;

    .line 541
    iget-object v8, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    new-instance v9, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    iget-object v10, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v10, v10, Lcom/amazonaws/mobile/client/AWSMobileClient;->mContext:Landroid/content/Context;

    iget-object v11, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v11, v11, Lcom/amazonaws/mobile/client/AWSMobileClient;->provider:Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;

    .line 542
    invoke-static {v5}, Lcom/amazonaws/regions/Regions;->fromName(Ljava/lang/String;)Lcom/amazonaws/regions/Regions;

    move-result-object v12

    invoke-direct {v9, v10, v11, v12}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;-><init>(Landroid/content/Context;Lcom/amazonaws/auth/AWSCognitoIdentityProvider;Lcom/amazonaws/regions/Regions;)V

    iput-object v9, v8, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    .line 543
    iget-object v8, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v8, v8, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    iget-object v9, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-boolean v9, v9, Lcom/amazonaws/mobile/client/AWSMobileClient;->mIsPersistenceEnabled:Z

    invoke-virtual {v8, v9}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->setPersistenceEnabled(Z)V

    .line 544
    iget-object v8, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v8, v8, Lcom/amazonaws/mobile/client/AWSMobileClient;->userAgentOverride:Ljava/lang/String;

    if-eqz v8, :cond_3

    .line 545
    iget-object v8, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v8, v8, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    iget-object v9, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v9, v9, Lcom/amazonaws/mobile/client/AWSMobileClient;->userAgentOverride:Ljava/lang/String;

    invoke-virtual {v8, v9}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->setUserAgentOverride(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 550
    .end local v3    # "identityPoolJSON":Lorg/json/JSONObject;
    .end local v4    # "poolId":Ljava/lang/String;
    .end local v5    # "regionStr":Ljava/lang/String;
    .end local v6    # "clientConfig":Lcom/amazonaws/ClientConfiguration;
    .end local v7    # "cibClient":Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;
    :cond_3
    goto :goto_0

    .line 547
    :catch_0
    move-exception v2

    .line 548
    .local v2, "e":Ljava/lang/Exception;
    :try_start_4
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v4, Ljava/lang/RuntimeException;

    const-string v5, "Failed to initialize Cognito Identity; please check your awsconfiguration.json"

    invoke-direct {v4, v5, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-interface {v3, v4}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 549
    monitor-exit v0

    return-void

    .line 553
    .end local v2    # "e":Ljava/lang/Exception;
    :cond_4
    :goto_0
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    const-string v4, "CognitoUserPool"

    invoke-virtual {v3, v4}, Lcom/amazonaws/mobile/config/AWSConfiguration;->optJsonObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v3
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 554
    .local v3, "userPoolJSON":Lorg/json/JSONObject;
    if-eqz v3, :cond_6

    .line 556
    :try_start_5
    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    const-string v5, "PoolId"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v4, Lcom/amazonaws/mobile/client/AWSMobileClient;->mUserPoolPoolId:Ljava/lang/String;

    .line 557
    const-string v4, "AppClientId"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 558
    .local v8, "clientId":Ljava/lang/String;
    const-string v4, "AppClientSecret"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 559
    .local v9, "clientSecret":Ljava/lang/String;
    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$context:Landroid/content/Context;

    const-string v5, "PinpointAppId"

    invoke-virtual {v3, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/CognitoPinpointSharedContext;->getPinpointEndpoint(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 561
    .local v11, "pinpointEndpointId":Ljava/lang/String;
    new-instance v4, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v4}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    .line 562
    .local v4, "clientConfig":Lcom/amazonaws/ClientConfiguration;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "AWSMobileClient "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-virtual {v6}, Lcom/amazonaws/mobile/config/AWSConfiguration;->getUserAgent()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/amazonaws/ClientConfiguration;->setUserAgent(Ljava/lang/String;)V

    .line 563
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v5, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->userAgentOverride:Ljava/lang/String;

    if-eqz v5, :cond_5

    .line 564
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v5, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->userAgentOverride:Ljava/lang/String;

    invoke-virtual {v4, v5}, Lcom/amazonaws/ClientConfiguration;->setUserAgentOverride(Ljava/lang/String;)V

    .line 566
    :cond_5
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    new-instance v6, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;

    new-instance v7, Lcom/amazonaws/auth/AnonymousAWSCredentials;

    invoke-direct {v7}, Lcom/amazonaws/auth/AnonymousAWSCredentials;-><init>()V

    invoke-direct {v6, v7, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/ClientConfiguration;)V

    iput-object v6, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpoolLL:Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProvider;

    .line 568
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v5, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpoolLL:Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProvider;

    const-string v6, "Region"

    invoke-virtual {v3, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/amazonaws/regions/Regions;->fromName(Ljava/lang/String;)Lcom/amazonaws/regions/Regions;

    move-result-object v6

    invoke-static {v6}, Lcom/amazonaws/regions/Region;->getRegion(Lcom/amazonaws/regions/Regions;)Lcom/amazonaws/regions/Region;

    move-result-object v6

    invoke-interface {v5, v6}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProvider;->setRegion(Lcom/amazonaws/regions/Region;)V

    .line 570
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    const-string v6, "cognito-idp.%s.amazonaws.com/%s"

    const-string v7, "Region"

    invoke-virtual {v3, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v10, "PoolId"

    invoke-virtual {v3, v10}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    filled-new-array {v7, v10}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpoolsLoginKey:Ljava/lang/String;

    .line 572
    iget-object v12, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    new-instance v13, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;

    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v6, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->mContext:Landroid/content/Context;

    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v7, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->mUserPoolPoolId:Ljava/lang/String;

    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v10, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpoolLL:Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProvider;

    move-object v5, v13

    invoke-direct/range {v5 .. v11}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProvider;Ljava/lang/String;)V

    iput-object v13, v12, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpool:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;

    .line 573
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v5, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpool:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;

    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-boolean v6, v6, Lcom/amazonaws/mobile/client/AWSMobileClient;->mIsPersistenceEnabled:Z

    invoke-virtual {v5, v6}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;->setPersistenceEnabled(Z)V

    .line 575
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    new-instance v6, Lcom/amazonaws/mobile/client/DeviceOperations;

    iget-object v7, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v10, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v10, v10, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpoolLL:Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProvider;

    invoke-direct {v6, v7, v10}, Lcom/amazonaws/mobile/client/DeviceOperations;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProvider;)V

    iput-object v6, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->mDeviceOperations:Lcom/amazonaws/mobile/client/DeviceOperations;
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 580
    .end local v4    # "clientConfig":Lcom/amazonaws/ClientConfiguration;
    .end local v8    # "clientId":Ljava/lang/String;
    .end local v9    # "clientSecret":Ljava/lang/String;
    .end local v11    # "pinpointEndpointId":Ljava/lang/String;
    goto :goto_1

    .line 577
    :catch_1
    move-exception v2

    .line 578
    .restart local v2    # "e":Ljava/lang/Exception;
    :try_start_6
    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v5, Ljava/lang/RuntimeException;

    const-string v6, "Failed to initialize Cognito Userpool; please check your awsconfiguration.json"

    invoke-direct {v5, v6, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-interface {v4, v5}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 579
    monitor-exit v0

    return-void

    .line 583
    .end local v2    # "e":Ljava/lang/Exception;
    :cond_6
    :goto_1
    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-virtual {v4, v5}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getHostedUIJSON(Lcom/amazonaws/mobile/config/AWSConfiguration;)Lorg/json/JSONObject;

    move-result-object v4
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 584
    .local v4, "hostedUIJSON":Lorg/json/JSONObject;
    if-eqz v4, :cond_8

    .line 587
    :try_start_7
    const-string v5, "TokenURI"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_7

    .line 588
    invoke-static {}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$200()Ljava/lang/String;

    move-result-object v5

    const-string v6, "initialize: OAuth2 client detected"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 589
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    new-instance v6, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

    iget-object v7, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v7, v7, Lcom/amazonaws/mobile/client/AWSMobileClient;->mContext:Landroid/content/Context;

    iget-object v8, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-direct {v6, v7, v8}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;-><init>(Landroid/content/Context;Lcom/amazonaws/mobile/client/AWSMobileClient;)V

    iput-object v6, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->mOAuth2Client:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

    .line 590
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v5, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->mOAuth2Client:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-boolean v6, v6, Lcom/amazonaws/mobile/client/AWSMobileClient;->mIsPersistenceEnabled:Z

    invoke-virtual {v5, v6}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->setPersistenceEnabled(Z)V

    .line 591
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v5, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->mOAuth2Client:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v6, v6, Lcom/amazonaws/mobile/client/AWSMobileClient;->userAgentOverride:Ljava/lang/String;

    invoke-virtual {v5, v6}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->setUserAgentOverride(Ljava/lang/String;)V

    goto :goto_2

    .line 593
    :cond_7
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-static {v5, v4}, Lcom/amazonaws/mobile/client/AWSMobileClient;->access$500(Lcom/amazonaws/mobile/client/AWSMobileClient;Lorg/json/JSONObject;)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 597
    :goto_2
    goto :goto_3

    .line 595
    :catch_2
    move-exception v5

    .line 596
    .local v5, "e":Ljava/lang/Exception;
    :try_start_8
    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v7, Ljava/lang/RuntimeException;

    const-string v8, "Failed to initialize OAuth, please check your awsconfiguration.json"

    invoke-direct {v7, v8, v5}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-interface {v6, v7}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 600
    .end local v5    # "e":Ljava/lang/Exception;
    :cond_8
    :goto_3
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v5, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    if-nez v5, :cond_9

    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v5, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpool:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;

    if-nez v5, :cond_9

    .line 601
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v5, Ljava/lang/RuntimeException;

    const-string v6, "Neither Cognito Identity or Cognito UserPool was used. At least one must be present to use AWSMobileClient."

    invoke-direct {v5, v6}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    invoke-interface {v2, v5}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 604
    monitor-exit v0

    return-void

    .line 607
    :cond_9
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    iput-object v6, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 609
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v5, v2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getUserStateDetails(Z)Lcom/amazonaws/mobile/client/UserStateDetails;

    move-result-object v2

    .line 610
    .local v2, "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    invoke-interface {v5, v2}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V

    .line 611
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v5, v2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->setUserState(Lcom/amazonaws/mobile/client/UserStateDetails;)V

    .line 612
    .end local v1    # "identityManager":Lcom/amazonaws/mobile/auth/core/IdentityManager;
    .end local v2    # "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    .end local v3    # "userPoolJSON":Lorg/json/JSONObject;
    .end local v4    # "hostedUIJSON":Lorg/json/JSONObject;
    monitor-exit v0

    .line 613
    return-void

    .line 475
    :catch_3
    move-exception v1

    .line 477
    .local v1, "ex":Ljava/lang/Exception;
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v3, Ljava/lang/RuntimeException;

    const-string v4, "Failed to initialize AWSMobileClient; please check your awsconfiguration.json"

    invoke-direct {v3, v4, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-interface {v2, v3}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 478
    monitor-exit v0

    return-void

    .line 612
    .end local v1    # "ex":Ljava/lang/Exception;
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    throw v1
.end method
