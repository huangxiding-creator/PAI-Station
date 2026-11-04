.class public Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;
.super Ljava/lang/Object;
.source "OAuth2Client.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;
    }
.end annotation


# static fields
.field public static final CREATE_DATE:Ljava/lang/String; = "createDate"

.field public static final CUSTOM_TABS_PACKAGE_NAME:Ljava/lang/String; = "com.android.chrome"

.field private static final REFRESH_THRESHOLD:J = 0xea60L

.field public static final SHARED_PREFERENCES_KEY:Ljava/lang/String; = "com.amazonaws.mobile.client.oauth2"

.field public static final SIGN_IN_REDIRECT_URI_KEY:Ljava/lang/String; = "signInRedirectUri"

.field public static final SIGN_OUT_REDIRECT_URI_KEY:Ljava/lang/String; = "signOutRedirectUri"

.field public static final TAG:Ljava/lang/String;

.field public static final TOKEN_URI_KEY:Ljava/lang/String; = "tokenUri"


# instance fields
.field mAuthorizeCallback:Lcom/amazonaws/mobile/client/Callback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;",
            ">;"
        }
    .end annotation
.end field

.field private mAuthorizeOrSignOutRedirectReceived:Z

.field private mClientId:Ljava/lang/String;

.field final mContext:Landroid/content/Context;

.field mCustomTabsCallback:Landroidx/browser/customtabs/CustomTabsCallback;

.field mCustomTabsClient:Landroidx/browser/customtabs/CustomTabsClient;

.field final mCustomTabsServiceConnection:Landroidx/browser/customtabs/CustomTabsServiceConnection;

.field mCustomTabsSession:Landroidx/browser/customtabs/CustomTabsSession;

.field private mError:Ljava/lang/String;

.field private mErrorDescription:Ljava/lang/String;

.field private mErrorUriString:Ljava/lang/String;

.field mIsPersistenceEnabled:Z

.field final mMobileClient:Lcom/amazonaws/mobile/client/AWSMobileClient;

.field mPKCEMode:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;

.field private mSignOutCallback:Lcom/amazonaws/mobile/client/Callback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/amazonaws/mobile/client/Callback<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation
.end field

.field mState:Ljava/lang/String;

.field private final mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

.field private userAgentOverride:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 46
    const-class v0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/amazonaws/mobile/client/AWSMobileClient;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "mobileClient"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 75
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 60
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mIsPersistenceEnabled:Z

    .line 76
    iput-object p2, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mMobileClient:Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 77
    iput-object p1, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mContext:Landroid/content/Context;

    .line 78
    sget-object v0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;->S256:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;

    iput-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mPKCEMode:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;

    .line 79
    new-instance v0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    invoke-direct {v0, p0}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;-><init>(Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;)V

    iput-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    .line 80
    new-instance v0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$1;

    invoke-direct {v0, p0}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$1;-><init>(Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;)V

    iput-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mCustomTabsCallback:Landroidx/browser/customtabs/CustomTabsCallback;

    .line 96
    new-instance v0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$2;

    invoke-direct {v0, p0}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$2;-><init>(Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;)V

    iput-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mCustomTabsServiceConnection:Landroidx/browser/customtabs/CustomTabsServiceConnection;

    .line 110
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mContext:Landroid/content/Context;

    const-string v1, "com.android.chrome"

    iget-object v2, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mCustomTabsServiceConnection:Landroidx/browser/customtabs/CustomTabsServiceConnection;

    invoke-static {v0, v1, v2}, Landroidx/browser/customtabs/CustomTabsClient;->bindCustomTabsService(Landroid/content/Context;Ljava/lang/String;Landroidx/browser/customtabs/CustomTabsServiceConnection;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 112
    sget-object v0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->TAG:Ljava/lang/String;

    const-string v1, "OAuth2Client: Failed to pre-warm custom tab, first page load may be slower"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 115
    :cond_0
    return-void
.end method

.method static synthetic access$000(Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;)Z
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

    .line 45
    iget-boolean v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mAuthorizeOrSignOutRedirectReceived:Z

    return v0
.end method

.method static synthetic access$100(Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;)Lcom/amazonaws/mobile/client/Callback;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

    .line 45
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mSignOutCallback:Lcom/amazonaws/mobile/client/Callback;

    return-object v0
.end method

.method static synthetic access$102(Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;Lcom/amazonaws/mobile/client/Callback;)Lcom/amazonaws/mobile/client/Callback;
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;
    .param p1, "x1"    # Lcom/amazonaws/mobile/client/Callback;

    .line 45
    iput-object p1, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mSignOutCallback:Lcom/amazonaws/mobile/client/Callback;

    return-object p1
.end method


# virtual methods
.method public authorize(Landroid/net/Uri;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 7
    .param p1, "authorizeUri"    # Landroid/net/Uri;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/net/Uri;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;",
            ">;)V"
        }
    .end annotation

    .line 173
    .local p2, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;>;"
    const-string v0, "response_type"

    const-string/jumbo v1, "state"

    iput-object p2, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mAuthorizeCallback:Lcom/amazonaws/mobile/client/Callback;

    .line 175
    :try_start_0
    invoke-virtual {p1}, Landroid/net/Uri;->buildUpon()Landroid/net/Uri$Builder;

    move-result-object v2

    .line 177
    .local v2, "authorizeUriBuilder":Landroid/net/Uri$Builder;
    sget-object v3, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$3;->$SwitchMap$com$amazonaws$mobile$client$internal$oauth2$OAuth2Client$PKCEMode:[I

    iget-object v4, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mPKCEMode:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;

    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;->ordinal()I

    move-result v4

    aget v3, v3, v4

    packed-switch v3, :pswitch_data_0

    .line 191
    new-instance v0, Ljava/lang/IllegalArgumentException;

    goto/16 :goto_1

    .line 189
    :pswitch_0
    goto :goto_0

    .line 179
    :pswitch_1
    invoke-static {}, Lcom/amazonaws/mobileconnectors/cognitoauth/util/Pkce;->generateRandom()Ljava/lang/String;

    move-result-object v3

    .line 180
    .local v3, "proofKey":Ljava/lang/String;
    invoke-static {v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/util/Pkce;->generateHash(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 181
    .local v4, "proofKeyHash":Ljava/lang/String;
    iget-object v5, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    const-string v6, "proofKey"

    invoke-virtual {v5, v6, v3}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 182
    iget-object v5, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    const-string v6, "proofKeyHash"

    invoke-virtual {v5, v6, v4}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 183
    const-string v5, "code_challenge_method"

    iget-object v6, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mPKCEMode:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;

    .line 184
    invoke-virtual {v6}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v5, v6}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v5

    const-string v6, "code_challenge"

    .line 185
    invoke-virtual {v5, v6, v4}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v5

    .line 186
    invoke-virtual {v5}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    .line 187
    nop

    .line 195
    .end local v3    # "proofKey":Ljava/lang/String;
    .end local v4    # "proofKeyHash":Ljava/lang/String;
    :goto_0
    invoke-virtual {v2}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v3

    .line 196
    .local v3, "validating":Landroid/net/Uri;
    const-string v4, "client_id"

    invoke-virtual {v3, v4}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mClientId:Ljava/lang/String;

    .line 197
    iget-object v4, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mClientId:Ljava/lang/String;

    if-eqz v4, :cond_3

    .line 200
    const-string v4, "redirect_uri"

    invoke-virtual {v3, v4}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 201
    .local v4, "redirectUri":Ljava/lang/String;
    if-eqz v4, :cond_2

    .line 204
    iget-object v5, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    const-string/jumbo v6, "signInRedirectUri"

    invoke-virtual {v5, v6, v4}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 205
    invoke-static {v4}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    .line 206
    invoke-virtual {v3, v0}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    if-nez v5, :cond_0

    .line 207
    const-string v5, "code"

    .line 208
    invoke-virtual {v2, v0, v5}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v0

    .line 209
    invoke-virtual {v0}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    .line 211
    :cond_0
    invoke-virtual {v3, v1}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mState:Ljava/lang/String;

    .line 212
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mState:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 213
    invoke-static {}, Lcom/amazonaws/mobileconnectors/cognitoauth/util/Pkce;->generateRandom()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mState:Ljava/lang/String;

    .line 214
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mState:Ljava/lang/String;

    .line 215
    invoke-virtual {v2, v1, v0}, Landroid/net/Uri$Builder;->appendQueryParameter(Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v0

    .line 216
    invoke-virtual {v0}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    .line 218
    :cond_1
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    iget-object v5, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mState:Ljava/lang/String;

    invoke-virtual {v0, v1, v5}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 219
    invoke-virtual {v2}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->open(Landroid/net/Uri;)V

    .line 222
    .end local v2    # "authorizeUriBuilder":Landroid/net/Uri$Builder;
    .end local v3    # "validating":Landroid/net/Uri;
    .end local v4    # "redirectUri":Ljava/lang/String;
    goto :goto_2

    .line 202
    .restart local v2    # "authorizeUriBuilder":Landroid/net/Uri$Builder;
    .restart local v3    # "validating":Landroid/net/Uri;
    .restart local v4    # "redirectUri":Ljava/lang/String;
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The authorize URI must contain a redirect_uri"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .end local p1    # "authorizeUri":Landroid/net/Uri;
    .end local p2    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;>;"
    throw v0

    .line 198
    .end local v4    # "redirectUri":Ljava/lang/String;
    .restart local p1    # "authorizeUri":Landroid/net/Uri;
    .restart local p2    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;>;"
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The authorize URI must contain a client_id"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .end local p1    # "authorizeUri":Landroid/net/Uri;
    .end local p2    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;>;"
    throw v0

    .line 191
    .end local v3    # "validating":Landroid/net/Uri;
    .restart local p1    # "authorizeUri":Landroid/net/Uri;
    .restart local p2    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;>;"
    :goto_1
    const-string v1, "Unsupported PKCE mode was chosen, please choose another"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .end local p1    # "authorizeUri":Landroid/net/Uri;
    .end local p2    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;>;"
    throw v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 220
    .end local v2    # "authorizeUriBuilder":Landroid/net/Uri$Builder;
    .restart local p1    # "authorizeUri":Landroid/net/Uri;
    .restart local p2    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;>;"
    :catch_0
    move-exception v0

    .line 221
    .local v0, "e":Ljava/lang/Exception;
    invoke-interface {p2, v0}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 223
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_2
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public getTokens(Lcom/amazonaws/mobile/client/Callback;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;",
            ">;)V"
        }
    .end annotation

    .line 372
    .local p1, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;>;"
    :try_start_0
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->getTokens()Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;

    move-result-object v0

    .line 375
    .local v0, "tokens":Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;
    iget-object v1, v0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;->expiresIn:Ljava/lang/Long;

    if-eqz v1, :cond_1

    .line 376
    iget-object v1, v0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;->createDate:Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    iget-object v3, v0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;->expiresIn:Ljava/lang/Long;

    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    add-long/2addr v1, v3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sub-long/2addr v1, v3

    .line 377
    .local v1, "timeToExpiry":J
    const-wide/32 v3, 0xea60

    cmp-long v3, v1, v3

    if-gez v3, :cond_1

    .line 379
    iget-object v3, v0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;->refreshToken:Ljava/lang/String;

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    const-string/jumbo v4, "tokenUri"

    invoke-virtual {v3, v4}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    move-object v4, v3

    .local v4, "tokenUriString":Ljava/lang/String;
    if-eqz v3, :cond_0

    .line 380
    invoke-static {v4}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    new-instance v5, Ljava/util/HashMap;

    invoke-direct {v5}, Ljava/util/HashMap;-><init>()V

    new-instance v6, Ljava/util/HashMap;

    invoke-direct {v6}, Ljava/util/HashMap;-><init>()V

    invoke-virtual {p0, v3, v5, v6, p1}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->refresh(Landroid/net/Uri;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V

    goto :goto_0

    .line 382
    .end local v4    # "tokenUriString":Ljava/lang/String;
    :cond_0
    new-instance v3, Ljava/lang/Exception;

    const-string v4, "No cached tokens available, refresh not available."

    invoke-direct {v3, v4}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    invoke-interface {p1, v3}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 386
    .end local v1    # "timeToExpiry":J
    :cond_1
    :goto_0
    invoke-interface {p1, v0}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 389
    .end local v0    # "tokens":Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;
    goto :goto_1

    .line 387
    :catch_0
    move-exception v0

    .line 388
    .local v0, "e":Ljava/lang/Exception;
    invoke-interface {p1, v0}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 390
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method public handleRedirect(Landroid/net/Uri;)Z
    .locals 13
    .param p1, "uri"    # Landroid/net/Uri;

    .line 236
    const/4 v0, 0x0

    if-nez p1, :cond_0

    .line 237
    return v0

    .line 239
    :cond_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    const-string/jumbo v2, "signInRedirectUri"

    invoke-virtual {v1, v2}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 240
    .local v1, "signInRedirectUriString":Ljava/lang/String;
    iget-object v2, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    const-string/jumbo v3, "signOutRedirectUri"

    invoke-virtual {v2, v3}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 241
    .local v2, "signOutRedirectUriString":Ljava/lang/String;
    const/4 v3, 0x0

    const/4 v4, 0x1

    if-eqz v1, :cond_6

    .line 242
    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v5

    .line 243
    .local v5, "signInRedirectUri":Landroid/net/Uri;
    invoke-virtual {p1}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_6

    .line 244
    invoke-virtual {p1}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_6

    .line 245
    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_6

    .line 246
    invoke-virtual {p1}, Landroid/net/Uri;->getQueryParameterNames()Ljava/util/Set;

    move-result-object v6

    invoke-virtual {v5}, Landroid/net/Uri;->getQueryParameterNames()Ljava/util/Set;

    move-result-object v7

    invoke-interface {v6, v7}, Ljava/util/Set;->containsAll(Ljava/util/Collection;)Z

    move-result v6

    if-eqz v6, :cond_6

    .line 247
    const-string v6, "code"

    invoke-virtual {p1, v6}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 248
    .local v6, "code":Ljava/lang/String;
    const-string/jumbo v7, "state"

    invoke-virtual {p1, v7}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 249
    .local v8, "state":Ljava/lang/String;
    iget-object v9, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    invoke-virtual {v9, v7}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_1

    .line 250
    return v0

    .line 252
    :cond_1
    const-string v7, "error"

    invoke-virtual {p1, v7}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    iput-object v7, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mError:Ljava/lang/String;

    .line 253
    const-string v7, "error_description"

    invoke-virtual {p1, v7}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    iput-object v7, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mErrorDescription:Ljava/lang/String;

    .line 254
    const-string v7, "error_uri"

    invoke-virtual {p1, v7}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    iput-object v7, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mErrorUriString:Ljava/lang/String;

    .line 255
    iput-boolean v4, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mAuthorizeOrSignOutRedirectReceived:Z

    .line 257
    iget-object v7, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mError:Ljava/lang/String;

    if-eqz v7, :cond_3

    .line 258
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mAuthorizeCallback:Lcom/amazonaws/mobile/client/Callback;

    if-eqz v0, :cond_2

    .line 259
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mAuthorizeCallback:Lcom/amazonaws/mobile/client/Callback;

    new-instance v7, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Exception;

    iget-object v9, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mError:Ljava/lang/String;

    iget-object v10, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mErrorDescription:Ljava/lang/String;

    iget-object v11, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mErrorUriString:Ljava/lang/String;

    const-string v12, "Authorization call failed with response from authorization server"

    invoke-direct {v7, v12, v9, v10, v11}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Exception;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {v0, v7}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 262
    iput-object v3, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mAuthorizeCallback:Lcom/amazonaws/mobile/client/Callback;

    .line 264
    :cond_2
    return v4

    .line 265
    :cond_3
    if-eqz v6, :cond_5

    .line 266
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mAuthorizeCallback:Lcom/amazonaws/mobile/client/Callback;

    if-eqz v0, :cond_4

    .line 267
    new-instance v0, Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;-><init>()V

    .line 268
    .local v0, "result":Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;
    iput-object v6, v0, Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;->code:Ljava/lang/String;

    .line 269
    iput-object p1, v0, Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;->responseUri:Landroid/net/Uri;

    .line 270
    iget-object v7, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mAuthorizeCallback:Lcom/amazonaws/mobile/client/Callback;

    invoke-interface {v7, v0}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V

    .line 271
    iput-object v3, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mAuthorizeCallback:Lcom/amazonaws/mobile/client/Callback;

    .line 273
    .end local v0    # "result":Lcom/amazonaws/mobile/client/internal/oauth2/AuthorizeResponse;
    :cond_4
    return v4

    .line 275
    :cond_5
    return v0

    .line 278
    .end local v5    # "signInRedirectUri":Landroid/net/Uri;
    .end local v6    # "code":Ljava/lang/String;
    .end local v8    # "state":Ljava/lang/String;
    :cond_6
    if-eqz v2, :cond_8

    .line 279
    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v5

    .line 280
    .local v5, "signOutRedirectUri":Landroid/net/Uri;
    invoke-virtual {p1}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_8

    .line 281
    invoke-virtual {p1}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_8

    .line 282
    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_8

    .line 283
    invoke-virtual {p1}, Landroid/net/Uri;->getQueryParameterNames()Ljava/util/Set;

    move-result-object v6

    invoke-virtual {v5}, Landroid/net/Uri;->getQueryParameterNames()Ljava/util/Set;

    move-result-object v7

    invoke-interface {v6, v7}, Ljava/util/Set;->containsAll(Ljava/util/Collection;)Z

    move-result v6

    if-eqz v6, :cond_8

    .line 284
    iput-boolean v4, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mAuthorizeOrSignOutRedirectReceived:Z

    .line 285
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mSignOutCallback:Lcom/amazonaws/mobile/client/Callback;

    if-eqz v0, :cond_7

    .line 286
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mSignOutCallback:Lcom/amazonaws/mobile/client/Callback;

    invoke-interface {v0, v3}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V

    .line 287
    iput-object v3, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mSignOutCallback:Lcom/amazonaws/mobile/client/Callback;

    .line 289
    :cond_7
    return v4

    .line 292
    .end local v5    # "signOutRedirectUri":Landroid/net/Uri;
    :cond_8
    return v0
.end method

.method public open(Landroid/net/Uri;)V
    .locals 3
    .param p1, "uri"    # Landroid/net/Uri;

    .line 226
    new-instance v0, Landroidx/browser/customtabs/CustomTabsIntent$Builder;

    iget-object v1, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mCustomTabsSession:Landroidx/browser/customtabs/CustomTabsSession;

    invoke-direct {v0, v1}, Landroidx/browser/customtabs/CustomTabsIntent$Builder;-><init>(Landroidx/browser/customtabs/CustomTabsSession;)V

    .line 227
    invoke-virtual {v0}, Landroidx/browser/customtabs/CustomTabsIntent$Builder;->build()Landroidx/browser/customtabs/CustomTabsIntent;

    move-result-object v0

    .line 228
    .local v0, "customTabsIntent":Landroidx/browser/customtabs/CustomTabsIntent;
    iget-object v1, v0, Landroidx/browser/customtabs/CustomTabsIntent;->intent:Landroid/content/Intent;

    const-string v2, "com.android.chrome"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 229
    iget-object v1, v0, Landroidx/browser/customtabs/CustomTabsIntent;->intent:Landroid/content/Intent;

    const/high16 v2, 0x40000000    # 2.0f

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 230
    iget-object v1, v0, Landroidx/browser/customtabs/CustomTabsIntent;->intent:Landroid/content/Intent;

    const/high16 v2, 0x10000000

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 231
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mAuthorizeOrSignOutRedirectReceived:Z

    .line 232
    iget-object v1, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v1, p1}, Landroidx/browser/customtabs/CustomTabsIntent;->launchUrl(Landroid/content/Context;Landroid/net/Uri;)V

    .line 233
    return-void
.end method

.method public refresh(Landroid/net/Uri;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 5
    .param p1, "tokenUri"    # Landroid/net/Uri;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/net/Uri;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;",
            ">;)V"
        }
    .end annotation

    .line 344
    .local p2, "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "body":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;>;"
    const-string v0, "refresh_token"

    const-string v1, "grant_type"

    iget-object v2, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    sget-object v3, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Constants$TokenResponseFields;->REFRESH_TOKEN:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Constants$TokenResponseFields;

    invoke-virtual {v3}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Constants$TokenResponseFields;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 345
    .local v2, "refreshToken":Ljava/lang/String;
    if-nez v2, :cond_0

    .line 346
    new-instance v3, Ljava/lang/IllegalStateException;

    const-string v4, "Refresh called without refresh token available"

    invoke-direct {v3, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    invoke-interface {p4, v3}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 351
    :cond_0
    :try_start_0
    invoke-interface {p3, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    if-nez v3, :cond_1

    .line 352
    sget-object v3, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Constants$GrantTypes;->REFRESH_TOKEN:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Constants$GrantTypes;

    invoke-virtual {v3}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Constants$GrantTypes;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {p3, v1, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 354
    :cond_1
    invoke-interface {p3, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    if-nez v1, :cond_3

    .line 355
    if-eqz v2, :cond_2

    .line 359
    invoke-interface {p3, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 356
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The refresh flow must contain a refresh_token"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .end local v2    # "refreshToken":Ljava/lang/String;
    .end local p1    # "tokenUri":Landroid/net/Uri;
    .end local p2    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local p3    # "body":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local p4    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;>;"
    throw v0

    .line 361
    .restart local v2    # "refreshToken":Ljava/lang/String;
    .restart local p1    # "tokenUri":Landroid/net/Uri;
    .restart local p2    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local p3    # "body":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local p4    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;>;"
    :cond_3
    :goto_0
    new-instance v0, Ljava/net/URL;

    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->userAgentOverride:Ljava/lang/String;

    invoke-static {v0, p2, p3, v1}, Lcom/amazonaws/mobile/client/internal/oauth2/HTTPUtil;->httpPost(Ljava/net/URL;Ljava/util/Map;Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 362
    .local v0, "response":Ljava/lang/String;
    invoke-static {v0}, Lcom/amazonaws/mobile/client/internal/oauth2/HTTPUtil;->parseHttpResponse(Ljava/lang/String;)Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;

    move-result-object v1

    .line 363
    .local v1, "tokens":Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;
    iget-object v3, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    invoke-virtual {v3, v1}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->set(Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;)V

    .line 364
    invoke-interface {p4, v1}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 367
    .end local v0    # "response":Ljava/lang/String;
    .end local v1    # "tokens":Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;
    goto :goto_1

    .line 365
    :catch_0
    move-exception v0

    .line 366
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/Exception;

    const-string v3, "Failed to refresh tokens with service"

    invoke-direct {v1, v3, v0}, Ljava/lang/Exception;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-interface {p4, v1}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 368
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method public requestTokens(Landroid/net/Uri;Ljava/util/Map;Ljava/util/Map;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 6
    .param p1, "tokenUri"    # Landroid/net/Uri;
    .param p4, "code"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/net/Uri;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;",
            ">;)V"
        }
    .end annotation

    .line 300
    .local p2, "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "body":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p5, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;>;"
    const-string v0, "grant_type"

    const-string v1, "code_verifier"

    const-string v2, "code"

    iget-object v3, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    const-string v4, "proofKey"

    invoke-virtual {v3, v4}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 302
    .local v3, "proofKey":Ljava/lang/String;
    if-nez v3, :cond_0

    iget-object v4, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mPKCEMode:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;

    sget-object v5, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;->NONE:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;

    invoke-virtual {v4, v5}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;->equals(Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 304
    new-instance v4, Ljava/lang/Exception;

    const-string v5, "Proof key could not be found from current session."

    invoke-direct {v4, v5}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    invoke-interface {p5, v4}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 309
    :cond_0
    :try_start_0
    const-string v4, "client_id"

    invoke-interface {p3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    if-eqz v4, :cond_7

    .line 312
    const-string v4, "redirect_uri"

    invoke-interface {p3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    if-eqz v4, :cond_6

    .line 316
    invoke-interface {p3, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    if-nez v4, :cond_2

    .line 317
    if-eqz p4, :cond_1

    .line 320
    invoke-interface {p3, v2, p4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 318
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The token exchange must contain a code"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .end local v3    # "proofKey":Ljava/lang/String;
    .end local p1    # "tokenUri":Landroid/net/Uri;
    .end local p2    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local p3    # "body":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local p4    # "code":Ljava/lang/String;
    .end local p5    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;>;"
    throw v0

    .line 322
    .restart local v3    # "proofKey":Ljava/lang/String;
    .restart local p1    # "tokenUri":Landroid/net/Uri;
    .restart local p2    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local p3    # "body":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local p4    # "code":Ljava/lang/String;
    .restart local p5    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;>;"
    :cond_2
    :goto_0
    invoke-interface {p3, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-nez v2, :cond_4

    .line 323
    if-eqz v3, :cond_3

    .line 326
    invoke-interface {p3, v1, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 324
    :cond_3
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "The token exchange must contain a code verifier"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local v3    # "proofKey":Ljava/lang/String;
    .end local p1    # "tokenUri":Landroid/net/Uri;
    .end local p2    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local p3    # "body":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local p4    # "code":Ljava/lang/String;
    .end local p5    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;>;"
    throw v0

    .line 328
    .restart local v3    # "proofKey":Ljava/lang/String;
    .restart local p1    # "tokenUri":Landroid/net/Uri;
    .restart local p2    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local p3    # "body":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local p4    # "code":Ljava/lang/String;
    .restart local p5    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;>;"
    :cond_4
    :goto_1
    invoke-interface {p3, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    if-nez v1, :cond_5

    .line 329
    sget-object v1, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Constants$GrantTypes;->AUTHORIZATION_CODE:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Constants$GrantTypes;

    invoke-virtual {v1}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Constants$GrantTypes;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p3, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 331
    :cond_5
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    const-string/jumbo v1, "tokenUri"

    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 333
    new-instance v0, Ljava/net/URL;

    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->userAgentOverride:Ljava/lang/String;

    invoke-static {v0, p2, p3, v1}, Lcom/amazonaws/mobile/client/internal/oauth2/HTTPUtil;->httpPost(Ljava/net/URL;Ljava/util/Map;Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 334
    .local v0, "response":Ljava/lang/String;
    invoke-static {v0}, Lcom/amazonaws/mobile/client/internal/oauth2/HTTPUtil;->parseHttpResponse(Ljava/lang/String;)Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;

    move-result-object v1

    .line 335
    .local v1, "tokens":Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;
    iget-object v2, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    invoke-virtual {v2, v1}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->set(Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;)V

    .line 336
    invoke-interface {p5, v1}, Lcom/amazonaws/mobile/client/Callback;->onResult(Ljava/lang/Object;)V

    .line 339
    .end local v0    # "response":Ljava/lang/String;
    .end local v1    # "tokens":Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;
    goto :goto_2

    .line 313
    :cond_6
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The token exchange must contain a redirect_uri"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .end local v3    # "proofKey":Ljava/lang/String;
    .end local p1    # "tokenUri":Landroid/net/Uri;
    .end local p2    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local p3    # "body":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local p4    # "code":Ljava/lang/String;
    .end local p5    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;>;"
    throw v0

    .line 310
    .restart local v3    # "proofKey":Ljava/lang/String;
    .restart local p1    # "tokenUri":Landroid/net/Uri;
    .restart local p2    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local p3    # "body":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local p4    # "code":Ljava/lang/String;
    .restart local p5    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;>;"
    :cond_7
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The token exchange must contain a client_id"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .end local v3    # "proofKey":Ljava/lang/String;
    .end local p1    # "tokenUri":Landroid/net/Uri;
    .end local p2    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local p3    # "body":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local p4    # "code":Ljava/lang/String;
    .end local p5    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;>;"
    throw v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 337
    .restart local v3    # "proofKey":Ljava/lang/String;
    .restart local p1    # "tokenUri":Landroid/net/Uri;
    .restart local p2    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local p3    # "body":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local p4    # "code":Ljava/lang/String;
    .restart local p5    # "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Tokens;>;"
    :catch_0
    move-exception v0

    .line 338
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/Exception;

    const-string v2, "Failed to exchange code for tokens"

    invoke-direct {v1, v2, v0}, Ljava/lang/Exception;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-interface {p5, v1}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 340
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_2
    return-void
.end method

.method public setPKCEMode(Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;)V
    .locals 0
    .param p1, "pkceMode"    # Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;

    .line 169
    iput-object p1, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mPKCEMode:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;

    .line 170
    return-void
.end method

.method public setPersistenceEnabled(Z)V
    .locals 1
    .param p1, "isPersistenceEnabled"    # Z

    .line 118
    iput-boolean p1, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mIsPersistenceEnabled:Z

    .line 119
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    invoke-virtual {v0, p1}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->setPersistenceEnabled(Z)V

    .line 120
    return-void
.end method

.method public setUserAgentOverride(Ljava/lang/String;)V
    .locals 0
    .param p1, "userAgentOverride"    # Ljava/lang/String;

    .line 123
    iput-object p1, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->userAgentOverride:Ljava/lang/String;

    .line 124
    return-void
.end method

.method public signOut()V
    .locals 2

    .line 138
    iget-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->clear()V

    .line 139
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mSignOutCallback:Lcom/amazonaws/mobile/client/Callback;

    .line 140
    iput-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mAuthorizeCallback:Lcom/amazonaws/mobile/client/Callback;

    .line 141
    sget-object v1, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;->S256:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;

    iput-object v1, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mPKCEMode:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client$PKCEMode;

    .line 142
    iput-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mState:Ljava/lang/String;

    .line 143
    iput-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mClientId:Ljava/lang/String;

    .line 144
    iput-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mError:Ljava/lang/String;

    .line 145
    iput-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mErrorDescription:Ljava/lang/String;

    .line 146
    iput-object v0, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mErrorUriString:Ljava/lang/String;

    .line 147
    return-void
.end method

.method public signOut(Landroid/net/Uri;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 3
    .param p1, "signOutUri"    # Landroid/net/Uri;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/net/Uri;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Ljava/lang/Void;",
            ">;)V"
        }
    .end annotation

    .line 127
    .local p2, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Ljava/lang/Void;>;"
    iput-object p2, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mSignOutCallback:Lcom/amazonaws/mobile/client/Callback;

    .line 128
    const-string v0, "redirect_uri"

    invoke-virtual {p1, v0}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 129
    .local v0, "redirectUri":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 132
    iget-object v1, p0, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->mStore:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;

    const-string/jumbo v2, "signOutRedirectUri"

    invoke-virtual {v1, v2, v0}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2ClientStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 133
    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    .line 134
    invoke-virtual {p0, p1}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->open(Landroid/net/Uri;)V

    .line 135
    return-void

    .line 130
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "The sign-out URI must contain a redirect_uri"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method
