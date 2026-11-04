.class Lcom/amazonaws/mobile/client/OAuth2Utils;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"


# instance fields
.field private customTabsCallback:Landroidx/browser/customtabs/CustomTabsCallback;

.field private final mContext:Landroid/content/Context;

.field private mCustomTabsClient:Landroidx/browser/customtabs/CustomTabsClient;

.field private mCustomTabsServiceConnection:Landroidx/browser/customtabs/CustomTabsServiceConnection;

.field private mCustomTabsSession:Landroidx/browser/customtabs/CustomTabsSession;

.field private mError:Ljava/lang/String;

.field private mErrorDescription:Ljava/lang/String;

.field private final mSignInRedirectUri:Landroid/net/Uri;

.field private mState:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroid/content/Context;Landroid/net/Uri;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "signInRedirectUri"    # Landroid/net/Uri;

    .line 3870
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3871
    iput-object p1, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mContext:Landroid/content/Context;

    .line 3872
    iput-object p2, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mSignInRedirectUri:Landroid/net/Uri;

    .line 3873
    new-instance v0, Landroidx/browser/customtabs/CustomTabsCallback;

    invoke-direct {v0}, Landroidx/browser/customtabs/CustomTabsCallback;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->customTabsCallback:Landroidx/browser/customtabs/CustomTabsCallback;

    .line 3874
    return-void
.end method

.method static synthetic access$000(Lcom/amazonaws/mobile/client/OAuth2Utils;)Landroidx/browser/customtabs/CustomTabsClient;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/OAuth2Utils;

    .line 3859
    iget-object v0, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mCustomTabsClient:Landroidx/browser/customtabs/CustomTabsClient;

    return-object v0
.end method

.method static synthetic access$002(Lcom/amazonaws/mobile/client/OAuth2Utils;Landroidx/browser/customtabs/CustomTabsClient;)Landroidx/browser/customtabs/CustomTabsClient;
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/OAuth2Utils;
    .param p1, "x1"    # Landroidx/browser/customtabs/CustomTabsClient;

    .line 3859
    iput-object p1, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mCustomTabsClient:Landroidx/browser/customtabs/CustomTabsClient;

    return-object p1
.end method

.method static synthetic access$102(Lcom/amazonaws/mobile/client/OAuth2Utils;Landroidx/browser/customtabs/CustomTabsSession;)Landroidx/browser/customtabs/CustomTabsSession;
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/OAuth2Utils;
    .param p1, "x1"    # Landroidx/browser/customtabs/CustomTabsSession;

    .line 3859
    iput-object p1, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mCustomTabsSession:Landroidx/browser/customtabs/CustomTabsSession;

    return-object p1
.end method

.method static synthetic access$200(Lcom/amazonaws/mobile/client/OAuth2Utils;)Landroidx/browser/customtabs/CustomTabsCallback;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/OAuth2Utils;

    .line 3859
    iget-object v0, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->customTabsCallback:Landroidx/browser/customtabs/CustomTabsCallback;

    return-object v0
.end method


# virtual methods
.method authorize(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 5
    .param p1, "webDomain"    # Ljava/lang/String;
    .param p2, "clientId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 3896
    .local p3, "queryParameterMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-static {}, Lcom/amazonaws/mobileconnectors/cognitoauth/util/Pkce;->generateRandom()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mState:Ljava/lang/String;

    .line 3897
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Uri;->buildUpon()Landroid/net/Uri$Builder;

    move-result-object v0

    .line 3898
    .local v0, "builder":Landroid/net/Uri$Builder;
    invoke-interface {p3}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    .line 3899
    .local v2, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    .line 3900
    .end local v2    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    goto :goto_0

    .line 3901
    :cond_0
    const-string v1, "code"

    invoke-interface {p3, v1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 3902
    const-string v2, "response_type"

    invoke-virtual {v0, v2, v1}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    .line 3904
    :cond_1
    const-string v1, "client_id"

    invoke-interface {p3, v1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 3905
    if-eqz p2, :cond_2

    .line 3906
    invoke-virtual {v0, v1, p2}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    goto :goto_1

    .line 3908
    :cond_2
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Client id must be specified for an authorization request."

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 3911
    :cond_3
    :goto_1
    const-string/jumbo v1, "state"

    iget-object v2, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mState:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    .line 3912
    invoke-virtual {v0}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/amazonaws/mobile/client/OAuth2Utils;->navigate(Landroid/net/Uri;)V

    .line 3913
    return-void
.end method

.method exchangeCode(Ljava/lang/String;)Landroid/net/Uri;
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;

    .line 3951
    const/4 v0, 0x0

    return-object v0
.end method

.method navigate(Landroid/net/Uri;)V
    .locals 4
    .param p1, "uri"    # Landroid/net/Uri;

    .line 3920
    new-instance v0, Landroidx/browser/customtabs/CustomTabsIntent$Builder;

    iget-object v1, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mCustomTabsSession:Landroidx/browser/customtabs/CustomTabsSession;

    invoke-direct {v0, v1}, Landroidx/browser/customtabs/CustomTabsIntent$Builder;-><init>(Landroidx/browser/customtabs/CustomTabsSession;)V

    .line 3921
    .local v0, "builder":Landroidx/browser/customtabs/CustomTabsIntent$Builder;
    invoke-virtual {v0}, Landroidx/browser/customtabs/CustomTabsIntent$Builder;->build()Landroidx/browser/customtabs/CustomTabsIntent;

    move-result-object v1

    .line 3922
    .local v1, "mCustomTabsIntent":Landroidx/browser/customtabs/CustomTabsIntent;
    iget-object v2, v1, Landroidx/browser/customtabs/CustomTabsIntent;->intent:Landroid/content/Intent;

    const-string v3, "com.android.chrome"

    invoke-virtual {v2, v3}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 3923
    iget-object v2, v1, Landroidx/browser/customtabs/CustomTabsIntent;->intent:Landroid/content/Intent;

    const/high16 v3, 0x40000000    # 2.0f

    invoke-virtual {v2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 3924
    iget-object v2, v1, Landroidx/browser/customtabs/CustomTabsIntent;->intent:Landroid/content/Intent;

    const/high16 v3, 0x10000000

    invoke-virtual {v2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 3925
    iget-object v2, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mContext:Landroid/content/Context;

    invoke-virtual {v1, v2, p1}, Landroidx/browser/customtabs/CustomTabsIntent;->launchUrl(Landroid/content/Context;Landroid/net/Uri;)V

    .line 3926
    return-void
.end method

.method parse(Landroid/net/Uri;)Z
    .locals 4
    .param p1, "uri"    # Landroid/net/Uri;

    .line 3930
    invoke-virtual {p1}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mSignInRedirectUri:Landroid/net/Uri;

    invoke-virtual {v1}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 3931
    invoke-virtual {p1}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mSignInRedirectUri:Landroid/net/Uri;

    invoke-virtual {v2}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 3932
    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mSignInRedirectUri:Landroid/net/Uri;

    invoke-virtual {v2}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 3933
    invoke-virtual {p1}, Landroid/net/Uri;->getQueryParameterNames()Ljava/util/Set;

    move-result-object v0

    iget-object v2, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mSignInRedirectUri:Landroid/net/Uri;

    invoke-virtual {v2}, Landroid/net/Uri;->getQueryParameterNames()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/Set;->containsAll(Ljava/util/Collection;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 3934
    const-string v0, "code"

    invoke-virtual {p1, v0}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 3935
    .local v0, "code":Ljava/lang/String;
    const-string/jumbo v2, "state"

    invoke-virtual {p1, v2}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 3936
    .local v2, "state":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mState:Ljava/lang/String;

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 3937
    return v1

    .line 3939
    :cond_0
    const-string v3, "error"

    invoke-virtual {p1, v3}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mError:Ljava/lang/String;

    .line 3940
    const-string v3, "error_description"

    invoke-virtual {p1, v3}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mErrorDescription:Ljava/lang/String;

    .line 3942
    iget-object v3, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mError:Ljava/lang/String;

    if-eqz v3, :cond_1

    .line 3943
    const/4 v1, 0x1

    return v1

    .line 3946
    .end local v0    # "code":Ljava/lang/String;
    .end local v2    # "state":Ljava/lang/String;
    :cond_1
    return v1
.end method

.method preWarm()V
    .locals 3

    .line 3878
    new-instance v0, Lcom/amazonaws/mobile/client/OAuth2Utils$1;

    invoke-direct {v0, p0}, Lcom/amazonaws/mobile/client/OAuth2Utils$1;-><init>(Lcom/amazonaws/mobile/client/OAuth2Utils;)V

    iput-object v0, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mCustomTabsServiceConnection:Landroidx/browser/customtabs/CustomTabsServiceConnection;

    .line 3891
    iget-object v0, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mContext:Landroid/content/Context;

    const-string v1, "com.android.chrome"

    iget-object v2, p0, Lcom/amazonaws/mobile/client/OAuth2Utils;->mCustomTabsServiceConnection:Landroidx/browser/customtabs/CustomTabsServiceConnection;

    invoke-static {v0, v1, v2}, Landroidx/browser/customtabs/CustomTabsClient;->bindCustomTabsService(Landroid/content/Context;Ljava/lang/String;Landroidx/browser/customtabs/CustomTabsServiceConnection;)Z

    .line 3893
    return-void
.end method
