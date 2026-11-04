.class Lcom/amazonaws/mobile/client/AWSMobileClient$25;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient;->_showSignInHostedUI(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

.field final synthetic val$callback:Lcom/amazonaws/mobile/client/Callback;

.field final synthetic val$callingActivity:Landroid/app/Activity;

.field final synthetic val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;Landroid/app/Activity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 3200
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iput-object p2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;

    iput-object p3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    iput-object p4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->val$callingActivity:Landroid/app/Activity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    .line 3204
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/SignInUIOptions;->getHostedUIOptions()Lcom/amazonaws/mobile/client/HostedUIOptions;

    move-result-object v0

    .line 3207
    .local v0, "hostedUIOptions":Lcom/amazonaws/mobile/client/HostedUIOptions;
    const/4 v1, 0x0

    .line 3209
    .local v1, "hostedUIJSON":Lorg/json/JSONObject;
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v3}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getHostedUIJSONFromJSON()Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v2

    .line 3212
    goto :goto_0

    .line 3210
    :catch_0
    move-exception v2

    .line 3211
    .local v2, "e":Lorg/json/JSONException;
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v4, Ljava/lang/Exception;

    const-string v5, "Could not create OAuth configuration object"

    invoke-direct {v4, v5, v2}, Ljava/lang/Exception;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-interface {v3, v4}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 3214
    .end local v2    # "e":Lorg/json/JSONException;
    :goto_0
    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/HostedUIOptions;->getFederationEnabled()Ljava/lang/Boolean;

    move-result-object v2

    const-string/jumbo v3, "true"

    const-string v4, "isFederationEnabled"

    if-eqz v2, :cond_1

    .line 3215
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v2, v2, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/HostedUIOptions;->getFederationEnabled()Ljava/lang/Boolean;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v5

    if-eqz v5, :cond_0

    goto :goto_1

    :cond_0
    const-string v3, "false"

    :goto_1
    invoke-interface {v2, v4, v3}, Lcom/amazonaws/mobile/client/KeyValueStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 3217
    :cond_1
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v2, v2, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    invoke-interface {v2, v4, v3}, Lcom/amazonaws/mobile/client/KeyValueStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 3220
    :goto_2
    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/HostedUIOptions;->getSignOutQueryParameters()Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_3

    .line 3222
    :try_start_1
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 3223
    .local v2, "signOutParams":Lorg/json/JSONObject;
    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/HostedUIOptions;->getSignOutQueryParameters()Ljava/util/Map;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_3
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Map$Entry;

    .line 3224
    .local v4, "e":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-interface {v4}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-interface {v4}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v6

    invoke-virtual {v2, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 3225
    nop

    .end local v4    # "e":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    goto :goto_3

    .line 3226
    :cond_2
    const-string v3, "SignOutQueryParameters"

    invoke-virtual {v1, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    .line 3230
    nop

    .end local v2    # "signOutParams":Lorg/json/JSONObject;
    goto :goto_4

    .line 3227
    :catch_1
    move-exception v2

    .line 3228
    .local v2, "e1":Lorg/json/JSONException;
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v4, Ljava/lang/Exception;

    const-string v5, "Failed to construct sign-out query parameters"

    invoke-direct {v4, v5, v2}, Ljava/lang/Exception;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-interface {v3, v4}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 3229
    return-void

    .line 3232
    .end local v2    # "e1":Lorg/json/JSONException;
    :cond_3
    :goto_4
    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/HostedUIOptions;->getTokenQueryParameters()Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_5

    .line 3234
    :try_start_2
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 3235
    .local v2, "tokenParams":Lorg/json/JSONObject;
    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/HostedUIOptions;->getTokenQueryParameters()Ljava/util/Map;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_5
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Map$Entry;

    .line 3236
    .restart local v4    # "e":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-interface {v4}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-interface {v4}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v6

    invoke-virtual {v2, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 3237
    nop

    .end local v4    # "e":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    goto :goto_5

    .line 3238
    :cond_4
    const-string v3, "TokenQueryParameters"

    invoke-virtual {v1, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_2

    .line 3242
    nop

    .end local v2    # "tokenParams":Lorg/json/JSONObject;
    goto :goto_6

    .line 3239
    :catch_2
    move-exception v2

    .line 3240
    .local v2, "e1":Lorg/json/JSONException;
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->val$callback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v4, Ljava/lang/Exception;

    const-string v5, "Failed to construct token query parameters"

    invoke-direct {v4, v5, v2}, Ljava/lang/Exception;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-interface {v3, v4}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 3241
    return-void

    .line 3245
    .end local v2    # "e1":Lorg/json/JSONException;
    :cond_5
    :goto_6
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v2, v2, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    const-string v3, "hostedUI"

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Lcom/amazonaws/mobile/client/KeyValueStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 3248
    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/HostedUIOptions;->getScopes()[Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_6

    .line 3249
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    .line 3250
    .local v2, "scopes":Ljava/util/HashSet;, "Ljava/util/HashSet<Ljava/lang/String;>;"
    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/HostedUIOptions;->getScopes()[Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Ljava/util/Collections;->addAll(Ljava/util/Collection;[Ljava/lang/Object;)Z

    goto :goto_7

    .line 3252
    .end local v2    # "scopes":Ljava/util/HashSet;, "Ljava/util/HashSet<Ljava/lang/String;>;"
    :cond_6
    const/4 v2, 0x0

    .line 3255
    .restart local v2    # "scopes":Ljava/util/HashSet;, "Ljava/util/HashSet<Ljava/lang/String;>;"
    :goto_7
    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/HostedUIOptions;->getIdentityProvider()Ljava/lang/String;

    move-result-object v3

    .line 3256
    .local v3, "identityProvider":Ljava/lang/String;
    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/HostedUIOptions;->getIdpIdentifier()Ljava/lang/String;

    move-result-object v4

    .line 3258
    .local v4, "idpIdentifier":Ljava/lang/String;
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v5, v5, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    sget-object v6, Lcom/amazonaws/mobile/client/AWSMobileClient$SignInMode;->HOSTED_UI:Lcom/amazonaws/mobile/client/AWSMobileClient$SignInMode;

    invoke-virtual {v6}, Lcom/amazonaws/mobile/client/AWSMobileClient$SignInMode;->toString()Ljava/lang/String;

    move-result-object v6

    const-string/jumbo v7, "signInMode"

    invoke-interface {v5, v7, v6}, Lcom/amazonaws/mobile/client/KeyValueStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 3260
    const/4 v5, 0x0

    .line 3262
    .local v5, "hostedUIBuilder":Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;
    :try_start_3
    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v6, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getHostedUI(Lorg/json/JSONObject;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v6
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_3

    move-object v5, v6

    .line 3265
    nop

    .line 3267
    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-boolean v6, v6, Lcom/amazonaws/mobile/client/AWSMobileClient;->mIsPersistenceEnabled:Z

    .line 3268
    invoke-virtual {v5, v6}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setPersistenceEnabled(Z)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v6

    new-instance v7, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1;

    invoke-direct {v7, p0}, Lcom/amazonaws/mobile/client/AWSMobileClient$25$1;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient$25;)V

    .line 3269
    invoke-virtual {v6, v7}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setAuthHandler(Lcom/amazonaws/mobileconnectors/cognitoauth/handlers/AuthHandler;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    .line 3324
    if-eqz v2, :cond_7

    .line 3325
    invoke-virtual {v5, v2}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setScopes(Ljava/util/Set;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    .line 3327
    :cond_7
    if-eqz v3, :cond_8

    .line 3328
    invoke-virtual {v5, v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setIdentityProvider(Ljava/lang/String;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    .line 3330
    :cond_8
    if-eqz v4, :cond_9

    .line 3331
    invoke-virtual {v5, v4}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setIdpIdentifier(Ljava/lang/String;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    .line 3333
    :cond_9
    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v5}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->build()Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    move-result-object v7

    iput-object v7, v6, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    .line 3334
    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;

    invoke-virtual {v6}, Lcom/amazonaws/mobile/client/SignInUIOptions;->getBrowserPackage()Ljava/lang/String;

    move-result-object v6

    if-eqz v6, :cond_a

    .line 3335
    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v6, v6, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    iget-object v7, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->val$signInUIOptions:Lcom/amazonaws/mobile/client/SignInUIOptions;

    invoke-virtual {v7}, Lcom/amazonaws/mobile/client/SignInUIOptions;->getBrowserPackage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;->setBrowserPackage(Ljava/lang/String;)V

    .line 3337
    :cond_a
    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->this$0:Lcom/amazonaws/mobile/client/AWSMobileClient;

    iget-object v6, v6, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    iget-object v7, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;->val$callingActivity:Landroid/app/Activity;

    invoke-virtual {v6, v7}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;->getSession(Landroid/app/Activity;)V

    .line 3338
    return-void

    .line 3263
    :catch_3
    move-exception v6

    .line 3264
    .local v6, "e":Lorg/json/JSONException;
    new-instance v7, Ljava/lang/RuntimeException;

    const-string v8, "Failed to construct HostedUI from awsconfiguration.json"

    invoke-direct {v7, v8, v6}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v7
.end method
