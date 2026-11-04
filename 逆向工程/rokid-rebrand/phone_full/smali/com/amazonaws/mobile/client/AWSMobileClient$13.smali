.class Lcom/amazonaws/mobile/client/AWSMobileClient$13;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient;->_signUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

.field final synthetic val$callback:Lcom/amazonaws/mobile/client/Callback;

.field final synthetic val$clientMetadata:Ljava/util/Map;

.field final synthetic val$password:Ljava/lang/String;

.field final synthetic val$userAttributes:Ljava/util/Map;

.field final synthetic val$username:Ljava/lang/String;

.field final synthetic val$validationData:Ljava/util/Map;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 0
    .param p1, "this$0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 2012
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iput-object p2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$userAttributes:Ljava/util/Map;

    iput-object p3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$username:Ljava/lang/String;

    iput-object p4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$password:Ljava/lang/String;

    iput-object p5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$validationData:Ljava/util/Map;

    iput-object p6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$clientMetadata:Ljava/util/Map;

    iput-object p7, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    .line 2015
    new-instance v0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserAttributes;

    invoke-direct {v0}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserAttributes;-><init>()V

    .line 2016
    .local v0, "cognitoUserAttr":Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserAttributes;
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$userAttributes:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 2017
    .local v2, "key":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$userAttributes:Ljava/util/Map;

    invoke-interface {v3, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserAttributes;->addAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 2018
    .end local v2    # "key":Ljava/lang/String;
    goto :goto_0

    .line 2020
    :cond_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v1, v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpool:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;

    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$username:Ljava/lang/String;

    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$password:Ljava/lang/String;

    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$validationData:Ljava/util/Map;

    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$13;->val$clientMetadata:Ljava/util/Map;

    new-instance v7, Lcom/amazonaws/mobile/client/AWSMobileClient$13$1;

    invoke-direct {v7, p0}, Lcom/amazonaws/mobile/client/AWSMobileClient$13$1;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient$13;)V

    move-object v4, v0

    invoke-virtual/range {v1 .. v7}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;->signUp(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserAttributes;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/handlers/SignUpHandler;)V

    .line 2054
    return-void
.end method
