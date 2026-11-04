.class Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;
.super Ljava/lang/Object;
.source "CognitoUser.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;->verifySoftwareTokenInBackground(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/handlers/RegisterMfaHandler;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

.field final synthetic val$callback:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/handlers/RegisterMfaHandler;

.field final synthetic val$friendlyName:Ljava/lang/String;

.field final synthetic val$sessionToken:Ljava/lang/String;

.field final synthetic val$totpCode:Ljava/lang/String;

.field final synthetic val$user:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/handlers/RegisterMfaHandler;)V
    .locals 0
    .param p1, "this$0"    # Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

    .line 1942
    iput-object p1, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->this$0:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

    iput-object p2, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->val$user:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

    iput-object p3, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->val$sessionToken:Ljava/lang/String;

    iput-object p4, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->val$totpCode:Ljava/lang/String;

    iput-object p5, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->val$friendlyName:Ljava/lang/String;

    iput-object p6, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->val$callback:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/handlers/RegisterMfaHandler;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .line 1945
    new-instance v0, Landroid/os/Handler;

    iget-object v1, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->this$0:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

    invoke-static {v1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;->access$000(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;)Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 1948
    .local v0, "handler":Landroid/os/Handler;
    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->val$user:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

    invoke-virtual {v1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;->getCachedSession()Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;

    move-result-object v1

    .line 1951
    .local v1, "cognitoTokens":Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;
    iget-object v2, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->val$sessionToken:Ljava/lang/String;

    invoke-static {v2}, Lcom/amazonaws/util/StringUtils;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 1952
    iget-object v2, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->this$0:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

    iget-object v3, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->val$sessionToken:Ljava/lang/String;

    iget-object v4, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->val$totpCode:Ljava/lang/String;

    iget-object v5, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->val$friendlyName:Ljava/lang/String;

    invoke-static {v2, v3, v4, v5}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;->access$1300(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;

    move-result-object v2

    .line 1953
    .local v2, "result":Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;
    const/4 v3, 0x1

    .local v3, "useSessionToken":Z
    goto :goto_0

    .line 1955
    .end local v2    # "result":Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;
    .end local v3    # "useSessionToken":Z
    :cond_0
    iget-object v2, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->this$0:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

    iget-object v3, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->val$totpCode:Ljava/lang/String;

    iget-object v4, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;->val$friendlyName:Ljava/lang/String;

    invoke-static {v2, v1, v3, v4}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;->access$1400(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;Ljava/lang/String;Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;

    move-result-object v2

    .line 1956
    .restart local v2    # "result":Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;
    const/4 v3, 0x0

    .line 1958
    .restart local v3    # "useSessionToken":Z
    :goto_0
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;->getSession()Ljava/lang/String;

    move-result-object v4

    .line 1959
    .local v4, "newSessionToken":Ljava/lang/String;
    sget-object v5, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResponseType;->ERROR:Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResponseType;

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;->getStatus()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResponseType;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_2

    .line 1962
    if-eqz v3, :cond_1

    .line 1963
    new-instance v5, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14$1;

    invoke-direct {v5, p0, v4}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14$1;-><init>(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;Ljava/lang/String;)V

    .local v5, "returnCallback":Ljava/lang/Runnable;
    goto :goto_1

    .line 1970
    .end local v5    # "returnCallback":Ljava/lang/Runnable;
    :cond_1
    new-instance v5, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14$2;

    invoke-direct {v5, p0}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14$2;-><init>(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;)V

    .line 1984
    .end local v1    # "cognitoTokens":Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;
    .end local v2    # "result":Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;
    .end local v3    # "useSessionToken":Z
    .end local v4    # "newSessionToken":Ljava/lang/String;
    .restart local v5    # "returnCallback":Ljava/lang/Runnable;
    :goto_1
    goto :goto_2

    .line 1960
    .end local v5    # "returnCallback":Ljava/lang/Runnable;
    .restart local v1    # "cognitoTokens":Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;
    .restart local v2    # "result":Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;
    .restart local v3    # "useSessionToken":Z
    .restart local v4    # "newSessionToken":Ljava/lang/String;
    :cond_2
    new-instance v5, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/exceptions/CognitoInternalErrorException;

    const-string/jumbo v6, "verification failed"

    invoke-direct {v5, v6}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/exceptions/CognitoInternalErrorException;-><init>(Ljava/lang/String;)V

    .end local v0    # "handler":Landroid/os/Handler;
    throw v5
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1977
    .end local v1    # "cognitoTokens":Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;
    .end local v2    # "result":Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;
    .end local v3    # "useSessionToken":Z
    .end local v4    # "newSessionToken":Ljava/lang/String;
    .restart local v0    # "handler":Landroid/os/Handler;
    :catch_0
    move-exception v1

    .line 1978
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14$3;

    invoke-direct {v2, p0, v1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14$3;-><init>(Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser$14;Ljava/lang/Exception;)V

    move-object v5, v2

    .line 1985
    .end local v1    # "e":Ljava/lang/Exception;
    .restart local v5    # "returnCallback":Ljava/lang/Runnable;
    :goto_2
    invoke-virtual {v0, v5}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 1986
    return-void
.end method
