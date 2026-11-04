.class public final Lcom/amazonaws/mobile/client/AWSMobileClient;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Lcom/amazonaws/auth/AWSCredentialsProvider;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;,
        Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;,
        Lcom/amazonaws/mobile/client/AWSMobileClient$SignInMode;
    }
.end annotation


# static fields
.field static final AUTH_KEY:Ljava/lang/String; = "Auth"

.field public static final CHALLENGE_RESPONSE_NEW_PASSWORD_KEY:Ljava/lang/String; = "NEW_PASSWORD"

.field public static final CHALLENGE_RESPONSE_USER_ATTRIBUTES_PREFIX_KEY:Ljava/lang/String; = "userAttributes."

.field private static final CUSTOM_ROLE_ARN_KEY:Ljava/lang/String; = "customRoleArn"

.field public static final DEFAULT_USER_AGENT:Ljava/lang/String; = "AWSMobileClient"

.field private static final FACEBOOK:Ljava/lang/String; = "FacebookSignIn"

.field static final FEDERATION_ENABLED_KEY:Ljava/lang/String; = "isFederationEnabled"

.field private static final GOOGLE:Ljava/lang/String; = "GoogleSignIn"

.field private static final GOOGLE_WEBAPP_CONFIG_KEY:Ljava/lang/String; = "ClientId-WebApp"

.field public static final HOSTED_UI_KEY:Ljava/lang/String; = "hostedUI"

.field static final IDENTITY_ID_KEY:Ljava/lang/String; = "cognitoIdentityId"

.field static final PROVIDER_KEY:Ljava/lang/String; = "provider"

.field static final SHARED_PREFERENCES_KEY:Ljava/lang/String; = "com.amazonaws.mobile.client"

.field static final SIGN_IN_MODE:Ljava/lang/String; = "signInMode"

.field private static final TAG:Ljava/lang/String;

.field static final TOKEN_KEY:Ljava/lang/String; = "token"

.field private static final USER_POOLS:Ljava/lang/String; = "CognitoUserPool"

.field private static volatile singleton:Lcom/amazonaws/mobile/client/AWSMobileClient;


# instance fields
.field awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

.field private awsCredentialsProvider:Lcom/amazonaws/auth/AWSCredentialsProvider;

.field private awsStartupHandler:Lcom/amazonaws/mobile/client/AWSStartupHandler;

.field private final clientMap:Ljava/util/LinkedHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedHashMap<",
            "Ljava/lang/Class<",
            "+",
            "Lcom/amazonaws/mobile/config/AWSConfigurable;",
            ">;",
            "Lcom/amazonaws/mobile/config/AWSConfigurable;",
            ">;"
        }
    .end annotation
.end field

.field cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

.field private federateWithCognitoIdentityLockObject:Ljava/lang/Object;

.field private forgotPasswordCallback:Lcom/amazonaws/mobile/client/Callback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;",
            ">;"
        }
    .end annotation
.end field

.field private forgotPasswordContinuation:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ForgotPasswordContinuation;

.field hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

.field private initLockObject:Ljava/lang/Object;

.field listeners:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/mobile/client/UserStateListener;",
            ">;"
        }
    .end annotation
.end field

.field mCognitoUserSession:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;

.field mContext:Landroid/content/Context;

.field mDeviceOperations:Lcom/amazonaws/mobile/client/DeviceOperations;

.field mFederatedLoginsMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mIsLegacyMode:Z

.field mIsPersistenceEnabled:Z

.field mOAuth2Client:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

.field private volatile mSignedOutWaitLatch:Ljava/util/concurrent/CountDownLatch;

.field mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

.field mUserPoolPoolId:Ljava/lang/String;

.field private mWaitForSignInLock:Ljava/util/concurrent/locks/Lock;

.field provider:Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;

.field private showSignInLockObject:Ljava/lang/Object;

.field private volatile showSignInWaitLatch:Ljava/util/concurrent/CountDownLatch;

.field private signInCallback:Lcom/amazonaws/mobile/client/Callback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignInResult;",
            ">;"
        }
    .end annotation
.end field

.field private signInChallengeContinuation:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ChallengeContinuation;

.field private signInMfaContinuation:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/MultiFactorAuthenticationContinuation;

.field private signInProviderConfig:[Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;

.field private signInState:Lcom/amazonaws/mobile/client/results/SignInState;

.field private signUpUser:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

.field private startupAuthResultHandler:Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;

.field userAgentOverride:Ljava/lang/String;

.field private userStateDetails:Lcom/amazonaws/mobile/client/UserStateDetails;

.field userpool:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;

.field userpoolLL:Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProvider;

.field userpoolsLoginKey:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 167
    const-class v0, Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    .line 195
    const/4 v0, 0x0

    sput-object v0, Lcom/amazonaws/mobile/client/AWSMobileClient;->singleton:Lcom/amazonaws/mobile/client/AWSMobileClient;

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .line 315
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 308
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mIsPersistenceEnabled:Z

    .line 316
    sget-object v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->singleton:Lcom/amazonaws/mobile/client/AWSMobileClient;

    if-nez v1, :cond_0

    .line 319
    new-instance v1, Ljava/util/LinkedHashMap;

    invoke-direct {v1}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->clientMap:Ljava/util/LinkedHashMap;

    .line 320
    const-string v1, ""

    iput-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpoolsLoginKey:Ljava/lang/String;

    .line 321
    new-instance v1, Ljava/util/concurrent/locks/ReentrantLock;

    invoke-direct {v1}, Ljava/util/concurrent/locks/ReentrantLock;-><init>()V

    iput-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mWaitForSignInLock:Ljava/util/concurrent/locks/Lock;

    .line 322
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iput-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mFederatedLoginsMap:Ljava/util/Map;

    .line 323
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->listeners:Ljava/util/List;

    .line 324
    new-instance v1, Ljava/lang/Object;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->showSignInLockObject:Ljava/lang/Object;

    .line 325
    new-instance v1, Ljava/lang/Object;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->federateWithCognitoIdentityLockObject:Ljava/lang/Object;

    .line 326
    new-instance v1, Ljava/util/concurrent/CountDownLatch;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    iput-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->showSignInWaitLatch:Ljava/util/concurrent/CountDownLatch;

    .line 327
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->initLockObject:Ljava/lang/Object;

    .line 328
    new-instance v0, Lcom/amazonaws/mobile/client/DummyStore;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/DummyStore;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    .line 329
    return-void

    .line 317
    :cond_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method private _changePassword(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 1
    .param p1, "oldPassword"    # Ljava/lang/String;
    .param p2, "newPassword"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Ljava/lang/Void;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 2462
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Ljava/lang/Void;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$18;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/amazonaws/mobile/client/AWSMobileClient$18;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V

    return-object v0
.end method

.method private _confirmForgotPassword(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 7
    .param p1, "password"    # Ljava/lang/String;
    .param p2, "forgotPasswordChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 2423
    .local p3, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;>;"
    new-instance v6, Lcom/amazonaws/mobile/client/AWSMobileClient$17;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p4

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lcom/amazonaws/mobile/client/AWSMobileClient$17;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V

    return-object v6
.end method

.method private _confirmSignIn(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 1
    .param p1, "signInChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignInResult;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 1307
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$7;

    invoke-direct {v0, p0, p3, p1, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient$7;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;Ljava/lang/String;Ljava/util/Map;)V

    return-object v0
.end method

.method private _confirmSignIn(Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;Ljava/util/Map;)Ljava/lang/Runnable;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignInResult;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 1421
    .local p1, "signInChallengeResponse":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p2, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    .local p3, "clientMetaData":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$8;

    invoke-direct {v0, p0, p2, p1, p3}, Lcom/amazonaws/mobile/client/AWSMobileClient$8;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;Ljava/util/Map;Ljava/util/Map;)V

    return-object v0
.end method

.method private _confirmSignUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 7
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "signUpChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignUpResult;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 2133
    .local p3, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    new-instance v6, Lcom/amazonaws/mobile/client/AWSMobileClient$14;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/amazonaws/mobile/client/AWSMobileClient$14;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V

    return-object v6
.end method

.method private _confirmUserAttribute(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 1
    .param p1, "attributeName"    # Ljava/lang/String;
    .param p2, "updateUserAttributeChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Ljava/lang/Void;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 2780
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Ljava/lang/Void;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$22;

    invoke-direct {v0, p0, p3, p1, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient$22;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method private _federatedSignIn(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/FederatedSignInOptions;Lcom/amazonaws/mobile/client/Callback;Z)Ljava/lang/Runnable;
    .locals 9
    .param p1, "providerKey"    # Ljava/lang/String;
    .param p2, "token"    # Ljava/lang/String;
    .param p3, "options"    # Lcom/amazonaws/mobile/client/FederatedSignInOptions;
    .param p5, "assignState"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/FederatedSignInOptions;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;Z)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 1677
    .local p4, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 1678
    .local v0, "loginsMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    sget-object v2, Lcom/amazonaws/mobile/client/AWSMobileClient$SignInMode;->FEDERATED_SIGN_IN:Lcom/amazonaws/mobile/client/AWSMobileClient$SignInMode;

    invoke-virtual {v2}, Lcom/amazonaws/mobile/client/AWSMobileClient$SignInMode;->toString()Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v3, "signInMode"

    invoke-interface {v1, v3, v2}, Lcom/amazonaws/mobile/client/KeyValueStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 1681
    :try_start_0
    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1683
    sget-object v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v2, "_federatedSignIn: Putting provider and token in store"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1684
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 1685
    .local v1, "details":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v2, "provider"

    invoke-virtual {v1, v2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1686
    const-string/jumbo v2, "token"

    invoke-virtual {v1, v2, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1687
    const-string v2, "isFederationEnabled"

    const-string/jumbo v3, "true"

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1688
    sget-object v2, Lcom/amazonaws/mobile/client/IdentityProvider;->DEVELOPER:Lcom/amazonaws/mobile/client/IdentityProvider;

    invoke-virtual {v2, p1}, Lcom/amazonaws/mobile/client/IdentityProvider;->equals(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1689
    if-nez p3, :cond_0

    .line 1690
    new-instance v2, Ljava/lang/Exception;

    const-string v3, "Developer authenticated identities require theidentity id to be specified in FederatedSignInOptions"

    invoke-direct {v2, v3}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    invoke-interface {p4, v2}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 1693
    :cond_0
    const-string v2, "cognitoIdentityId"

    invoke-virtual {p3}, Lcom/amazonaws/mobile/client/FederatedSignInOptions;->getCognitoIdentityId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1695
    :cond_1
    if-eqz p3, :cond_2

    invoke-virtual {p3}, Lcom/amazonaws/mobile/client/FederatedSignInOptions;->getCustomRoleARN()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/amazonaws/util/StringUtils;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 1696
    const-string v2, "customRoleArn"

    invoke-virtual {p3}, Lcom/amazonaws/mobile/client/FederatedSignInOptions;->getCustomRoleARN()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1698
    :cond_2
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    invoke-interface {v2, v1}, Lcom/amazonaws/mobile/client/KeyValueStore;->set(Ljava/util/Map;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1701
    .end local v1    # "details":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    goto :goto_0

    .line 1699
    :catch_0
    move-exception v1

    .line 1700
    .local v1, "e":Ljava/lang/Exception;
    invoke-interface {p4, v1}, Lcom/amazonaws/mobile/client/Callback;->onError(Ljava/lang/Exception;)V

    .line 1703
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    new-instance v8, Lcom/amazonaws/mobile/client/AWSMobileClient$10;

    move-object v1, v8

    move-object v2, p0

    move-object v3, p4

    move-object v4, p2

    move-object v5, p1

    move-object v6, v0

    move v7, p5

    invoke-direct/range {v1 .. v7}, Lcom/amazonaws/mobile/client/AWSMobileClient$10;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)V

    return-object v8
.end method

.method private _forgotPassword(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 1
    .param p1, "username"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 2313
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$16;

    invoke-direct {v0, p0, p3, p1, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient$16;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;Ljava/lang/String;Ljava/util/Map;)V

    return-object v0
.end method

.method private _getAWSCredentials()Lcom/amazonaws/mobile/client/internal/ReturningRunnable;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/amazonaws/mobile/client/internal/ReturningRunnable<",
            "Lcom/amazonaws/auth/AWSCredentials;",
            ">;"
        }
    .end annotation

    .line 410
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$1;

    invoke-direct {v0, p0}, Lcom/amazonaws/mobile/client/AWSMobileClient$1;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;)V

    return-object v0
.end method

.method private _getHostedUITokens(Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/Tokens;",
            ">;)V"
        }
    .end annotation

    .line 1885
    .local p1, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/Tokens;>;"
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    invoke-virtual {v0}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;->getCurrentUser()Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    .line 1886
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    new-instance v1, Lcom/amazonaws/mobile/client/AWSMobileClient$12;

    invoke-direct {v1, p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$12;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;)V

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;->setAuthHandler(Lcom/amazonaws/mobileconnectors/cognitoauth/handlers/AuthHandler;)V

    .line 1906
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    invoke-virtual {v0}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;->getSessionWithoutWebUI()V

    .line 1907
    return-void
.end method

.method private _getTokens(Lcom/amazonaws/mobile/client/Callback;Z)Ljava/lang/Runnable;
    .locals 1
    .param p2, "waitForSignIn"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/Tokens;",
            ">;Z)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 1805
    .local p1, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/Tokens;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$11;

    invoke-direct {v0, p0, p1, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient$11;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;Z)V

    return-object v0
.end method

.method private _getUserAttributes(Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;>;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 2497
    .local p1, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$19;

    invoke-direct {v0, p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$19;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;)V

    return-object v0
.end method

.method private _initializeHostedUI(Lorg/json/JSONObject;)V
    .locals 4
    .param p1, "hostedUIJSON"    # Lorg/json/JSONObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 618
    sget-object v0, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v1, "initialize: Cognito HostedUI client detected"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 619
    const-string v0, "Scopes"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    .line 620
    .local v0, "scopesJSONArray":Lorg/json/JSONArray;
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    .line 621
    .local v1, "scopes":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-ge v2, v3, :cond_0

    .line 622
    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 621
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 625
    .end local v2    # "i":I
    :cond_0
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mUserPoolPoolId:Ljava/lang/String;

    if-eqz v2, :cond_1

    .line 629
    invoke-virtual {p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getHostedUI(Lorg/json/JSONObject;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    iget-boolean v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mIsPersistenceEnabled:Z

    .line 630
    invoke-virtual {v2, v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setPersistenceEnabled(Z)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    new-instance v3, Lcom/amazonaws/mobile/client/AWSMobileClient$3;

    invoke-direct {v3, p0}, Lcom/amazonaws/mobile/client/AWSMobileClient$3;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;)V

    .line 631
    invoke-virtual {v2, v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setAuthHandler(Lcom/amazonaws/mobileconnectors/cognitoauth/handlers/AuthHandler;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    .line 647
    invoke-virtual {v2}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->build()Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    move-result-object v2

    iput-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    .line 648
    return-void

    .line 626
    :cond_1
    new-instance v2, Ljava/lang/IllegalStateException;

    const-string v3, "User pool Id must be available through user pool setting"

    invoke-direct {v2, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method private _resendSignUp(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 1
    .param p1, "username"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignUpResult;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 2222
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$15;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/amazonaws/mobile/client/AWSMobileClient$15;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V

    return-object v0
.end method

.method private _showSignIn(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 3
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "signInUIOptions"    # Lcom/amazonaws/mobile/client/SignInUIOptions;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Activity;",
            "Lcom/amazonaws/mobile/client/SignInUIOptions;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 3043
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    invoke-virtual {p2}, Lcom/amazonaws/mobile/client/SignInUIOptions;->getHostedUIOptions()Lcom/amazonaws/mobile/client/HostedUIOptions;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 3044
    invoke-virtual {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getHostedUIJSON()Lorg/json/JSONObject;

    move-result-object v0

    .line 3045
    .local v0, "hostedUIJSON":Lorg/json/JSONObject;
    if-nez v0, :cond_0

    .line 3046
    new-instance v1, Lcom/amazonaws/mobile/client/AWSMobileClient$23;

    invoke-direct {v1, p0, p3}, Lcom/amazonaws/mobile/client/AWSMobileClient$23;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;)V

    return-object v1

    .line 3053
    :cond_0
    const-string v1, "TokenURI"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 3054
    invoke-direct {p0, p1, p2, p3}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_showSignInOAuth2UI(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    return-object v1

    .line 3056
    :cond_1
    invoke-direct {p0, p1, p2, p3}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_showSignInHostedUI(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    return-object v1

    .line 3059
    .end local v0    # "hostedUIJSON":Lorg/json/JSONObject;
    :cond_2
    invoke-direct {p0, p1, p2, p3}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_showSignInDropInUI(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v0

    return-object v0
.end method

.method private _showSignInDropInUI(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 1
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "signInUIOptions"    # Lcom/amazonaws/mobile/client/SignInUIOptions;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Activity;",
            "Lcom/amazonaws/mobile/client/SignInUIOptions;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 3346
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$26;

    invoke-direct {v0, p0, p3, p2, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$26;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;Lcom/amazonaws/mobile/client/SignInUIOptions;Landroid/app/Activity;)V

    return-object v0
.end method

.method private _showSignInHostedUI(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 1
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "signInUIOptions"    # Lcom/amazonaws/mobile/client/SignInUIOptions;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Activity;",
            "Lcom/amazonaws/mobile/client/SignInUIOptions;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 3200
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$25;

    invoke-direct {v0, p0, p2, p3, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$25;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;Landroid/app/Activity;)V

    return-object v0
.end method

.method private _showSignInOAuth2UI(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 1
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "signInUIOptions"    # Lcom/amazonaws/mobile/client/SignInUIOptions;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Activity;",
            "Lcom/amazonaws/mobile/client/SignInUIOptions;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 3065
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$24;

    invoke-direct {v0, p0, p2, p3}, Lcom/amazonaws/mobile/client/AWSMobileClient$24;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)V

    return-object v0
.end method

.method private _signIn(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 10
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignInResult;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 1170
    .local p3, "validationData":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p5, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    iput-object p5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signInCallback:Lcom/amazonaws/mobile/client/Callback;

    .line 1171
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signInState:Lcom/amazonaws/mobile/client/results/SignInState;

    .line 1172
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    sget-object v1, Lcom/amazonaws/mobile/client/AWSMobileClient$SignInMode;->SIGN_IN:Lcom/amazonaws/mobile/client/AWSMobileClient$SignInMode;

    invoke-virtual {v1}, Lcom/amazonaws/mobile/client/AWSMobileClient$SignInMode;->toString()Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v2, "signInMode"

    invoke-interface {v0, v2, v1}, Lcom/amazonaws/mobile/client/KeyValueStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 1174
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$6;

    move-object v3, v0

    move-object v4, p0

    move-object v5, p1

    move-object v6, p4

    move-object v7, p2

    move-object v8, p3

    move-object v9, p5

    invoke-direct/range {v3 .. v9}, Lcom/amazonaws/mobile/client/AWSMobileClient$6;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Ljava/lang/String;Ljava/util/Map;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V

    return-object v0
.end method

.method private _signOut(Lcom/amazonaws/mobile/client/SignOutOptions;)Lcom/amazonaws/mobile/client/internal/ReturningRunnable;
    .locals 1
    .param p1, "signOutOptions"    # Lcom/amazonaws/mobile/client/SignOutOptions;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/mobile/client/SignOutOptions;",
            ")",
            "Lcom/amazonaws/mobile/client/internal/ReturningRunnable<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .line 1534
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$9;

    invoke-direct {v0, p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$9;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/SignOutOptions;)V

    return-object v0
.end method

.method private _signUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 9
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignUpResult;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 2012
    .local p3, "userAttributes":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "validationData":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p5, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p6, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    new-instance v8, Lcom/amazonaws/mobile/client/AWSMobileClient$13;

    move-object v0, v8

    move-object v1, p0

    move-object v2, p3

    move-object v3, p1

    move-object v4, p2

    move-object v5, p4

    move-object v6, p5

    move-object v7, p6

    invoke-direct/range {v0 .. v7}, Lcom/amazonaws/mobile/client/AWSMobileClient$13;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V

    return-object v8
.end method

.method private _updateUserAttributes(Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Ljava/util/List<",
            "Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;",
            ">;>;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 2587
    .local p1, "userAttributes":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Ljava/util/List<Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;>;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$20;

    invoke-direct {v0, p0, p3, p1, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient$20;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;Ljava/util/Map;Ljava/util/Map;)V

    return-object v0
.end method

.method private _verifyUserAttribute(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 1
    .param p1, "attributeName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 2687
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$21;

    invoke-direct {v0, p0, p3, p2, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$21;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;Ljava/util/Map;Ljava/lang/String;)V

    return-object v0
.end method

.method static synthetic access$000(Lcom/amazonaws/mobile/client/AWSMobileClient;)Ljava/lang/Object;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 163
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->initLockObject:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$100(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/config/AWSConfiguration;)V
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p1, "x1"    # Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 163
    invoke-direct {p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->registerConfigSignInProviders(Lcom/amazonaws/mobile/config/AWSConfiguration;)V

    return-void
.end method

.method static synthetic access$1002(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;)Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p1, "x1"    # Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

    .line 163
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signUpUser:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

    return-object p1
.end method

.method static synthetic access$1100(Lcom/amazonaws/mobile/client/AWSMobileClient;)Lcom/amazonaws/mobile/client/Callback;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 163
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->forgotPasswordCallback:Lcom/amazonaws/mobile/client/Callback;

    return-object v0
.end method

.method static synthetic access$1102(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;)Lcom/amazonaws/mobile/client/Callback;
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p1, "x1"    # Lcom/amazonaws/mobile/client/Callback;

    .line 163
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->forgotPasswordCallback:Lcom/amazonaws/mobile/client/Callback;

    return-object p1
.end method

.method static synthetic access$1200(Lcom/amazonaws/mobile/client/AWSMobileClient;)Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ForgotPasswordContinuation;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 163
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->forgotPasswordContinuation:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ForgotPasswordContinuation;

    return-object v0
.end method

.method static synthetic access$1202(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ForgotPasswordContinuation;)Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ForgotPasswordContinuation;
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p1, "x1"    # Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ForgotPasswordContinuation;

    .line 163
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->forgotPasswordContinuation:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ForgotPasswordContinuation;

    return-object p1
.end method

.method static synthetic access$1300(Lcom/amazonaws/mobile/client/AWSMobileClient;)Ljava/lang/Object;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 163
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->showSignInLockObject:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$1400(Lcom/amazonaws/mobile/client/AWSMobileClient;Ljava/lang/String;)Z
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p1, "x1"    # Ljava/lang/String;

    .line 163
    invoke-direct {p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isConfigurationKeyPresent(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$1500(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;)V
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p1, "x1"    # Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;

    .line 163
    invoke-direct {p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->initializeWithBuilder(Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;)V

    return-void
.end method

.method static synthetic access$200()Ljava/lang/String;
    .locals 1

    .line 163
    sget-object v0, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$300(Lcom/amazonaws/mobile/client/AWSMobileClient;)Lcom/amazonaws/mobile/client/results/SignInState;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 163
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signInState:Lcom/amazonaws/mobile/client/results/SignInState;

    return-object v0
.end method

.method static synthetic access$302(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/results/SignInState;)Lcom/amazonaws/mobile/client/results/SignInState;
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p1, "x1"    # Lcom/amazonaws/mobile/client/results/SignInState;

    .line 163
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signInState:Lcom/amazonaws/mobile/client/results/SignInState;

    return-object p1
.end method

.method static synthetic access$400(Lcom/amazonaws/mobile/client/AWSMobileClient;)Ljava/util/concurrent/CountDownLatch;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 163
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->showSignInWaitLatch:Ljava/util/concurrent/CountDownLatch;

    return-object v0
.end method

.method static synthetic access$402(Lcom/amazonaws/mobile/client/AWSMobileClient;Ljava/util/concurrent/CountDownLatch;)Ljava/util/concurrent/CountDownLatch;
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p1, "x1"    # Ljava/util/concurrent/CountDownLatch;

    .line 163
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->showSignInWaitLatch:Ljava/util/concurrent/CountDownLatch;

    return-object p1
.end method

.method static synthetic access$500(Lcom/amazonaws/mobile/client/AWSMobileClient;Lorg/json/JSONObject;)V
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p1, "x1"    # Lorg/json/JSONObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 163
    invoke-direct {p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_initializeHostedUI(Lorg/json/JSONObject;)V

    return-void
.end method

.method static synthetic access$600(Lcom/amazonaws/mobile/client/AWSMobileClient;)Lcom/amazonaws/mobile/client/Callback;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 163
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signInCallback:Lcom/amazonaws/mobile/client/Callback;

    return-object v0
.end method

.method static synthetic access$602(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;)Lcom/amazonaws/mobile/client/Callback;
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p1, "x1"    # Lcom/amazonaws/mobile/client/Callback;

    .line 163
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signInCallback:Lcom/amazonaws/mobile/client/Callback;

    return-object p1
.end method

.method static synthetic access$700(Lcom/amazonaws/mobile/client/AWSMobileClient;)Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/MultiFactorAuthenticationContinuation;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 163
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signInMfaContinuation:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/MultiFactorAuthenticationContinuation;

    return-object v0
.end method

.method static synthetic access$702(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/MultiFactorAuthenticationContinuation;)Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/MultiFactorAuthenticationContinuation;
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p1, "x1"    # Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/MultiFactorAuthenticationContinuation;

    .line 163
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signInMfaContinuation:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/MultiFactorAuthenticationContinuation;

    return-object p1
.end method

.method static synthetic access$800(Lcom/amazonaws/mobile/client/AWSMobileClient;)Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ChallengeContinuation;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 163
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signInChallengeContinuation:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ChallengeContinuation;

    return-object v0
.end method

.method static synthetic access$802(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ChallengeContinuation;)Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ChallengeContinuation;
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p1, "x1"    # Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ChallengeContinuation;

    .line 163
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signInChallengeContinuation:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/continuations/ChallengeContinuation;

    return-object p1
.end method

.method static synthetic access$900(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/client/AWSMobileClient;
    .param p1, "x1"    # Lcom/amazonaws/mobile/client/Callback;

    .line 163
    invoke-direct {p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_getHostedUITokens(Lcom/amazonaws/mobile/client/Callback;)V

    return-void
.end method

.method private fetchCognitoIdentity(Landroid/content/Context;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "startupAuthResultHandler"    # Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;

    .line 3488
    :try_start_0
    sget-object v0, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v1, "Fetching the Cognito Identity."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 3491
    new-instance v0, Lcom/amazonaws/mobile/auth/core/IdentityManager;

    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-direct {v0, p1, v1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;-><init>(Landroid/content/Context;Lcom/amazonaws/mobile/config/AWSConfiguration;)V

    .line 3492
    .local v0, "identityManager":Lcom/amazonaws/mobile/auth/core/IdentityManager;
    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->setDefaultIdentityManager(Lcom/amazonaws/mobile/auth/core/IdentityManager;)V

    .line 3493
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signInProviderConfig:[Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;

    if-nez v1, :cond_0

    .line 3494
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-direct {p0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->registerConfigSignInProviders(Lcom/amazonaws/mobile/config/AWSConfiguration;)V

    goto :goto_0

    .line 3496
    :cond_0
    invoke-direct {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->registerUserSignInProvidersWithPermissions()V

    .line 3498
    :goto_0
    move-object v1, p1

    check-cast v1, Landroid/app/Activity;

    invoke-direct {p0, v1, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->resumeSession(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 3502
    .end local v0    # "identityManager":Lcom/amazonaws/mobile/auth/core/IdentityManager;
    goto :goto_1

    .line 3499
    :catch_0
    move-exception v0

    .line 3500
    .local v0, "exception":Ljava/lang/Exception;
    sget-object v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v2, "Error occurred in fetching the Cognito Identity and resuming the auth session"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 3503
    .end local v0    # "exception":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method public static declared-synchronized getInstance()Lcom/amazonaws/mobile/client/AWSMobileClient;
    .locals 2

    const-class v0, Lcom/amazonaws/mobile/client/AWSMobileClient;

    monitor-enter v0

    .line 337
    :try_start_0
    sget-object v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->singleton:Lcom/amazonaws/mobile/client/AWSMobileClient;

    if-nez v1, :cond_0

    .line 338
    new-instance v1, Lcom/amazonaws/mobile/client/AWSMobileClient;

    invoke-direct {v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;-><init>()V

    sput-object v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->singleton:Lcom/amazonaws/mobile/client/AWSMobileClient;

    .line 340
    :cond_0
    sget-object v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->singleton:Lcom/amazonaws/mobile/client/AWSMobileClient;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    .line 336
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private hasFederatedToken(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 4
    .param p1, "providerKey"    # Ljava/lang/String;
    .param p2, "token"    # Ljava/lang/String;

    .line 1120
    if-eqz p2, :cond_1

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 1123
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mFederatedLoginsMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    .line 1124
    .local v0, "hasFederatedToken":Z
    sget-object v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "hasFederatedToken: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " provider: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1125
    return v0

    .line 1121
    .end local v0    # "hasFederatedToken":Z
    :cond_1
    :goto_0
    const/4 v0, 0x0

    return v0
.end method

.method private initializeWithBuilder(Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;)V
    .locals 3
    .param p1, "initializeBuilder"    # Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;

    .line 3430
    invoke-virtual {p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->getAwsConfiguration()Lcom/amazonaws/mobile/config/AWSConfiguration;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 3431
    invoke-virtual {p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->getAwsConfiguration()Lcom/amazonaws/mobile/config/AWSConfiguration;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 3434
    :cond_0
    invoke-virtual {p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->getSignInProviderConfig()[Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 3435
    invoke-virtual {p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->getSignInProviderConfig()[Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signInProviderConfig:[Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;

    .line 3439
    :cond_1
    :try_start_0
    invoke-virtual {p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$InitializeBuilder;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->startupAuthResultHandler:Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;

    invoke-direct {p0, v0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->fetchCognitoIdentity(Landroid/content/Context;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 3443
    goto :goto_0

    .line 3440
    :catch_0
    move-exception v0

    .line 3441
    .local v0, "exception":Ljava/lang/Exception;
    sget-object v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v2, "Error in initializing the AWSMobileClient. Check if AWS Cloud Config `awsconfiguration.json` is present in the application."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 3444
    .end local v0    # "exception":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private isConfigurationKeyPresent(Ljava/lang/String;)Z
    .locals 1
    .param p1, "configurationKey"    # Ljava/lang/String;

    .line 3558
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isConfigurationKeyPresent(Ljava/lang/String;Lcom/amazonaws/mobile/config/AWSConfiguration;)Z

    move-result v0

    return v0
.end method

.method private isConfigurationKeyPresent(Ljava/lang/String;Lcom/amazonaws/mobile/config/AWSConfiguration;)Z
    .locals 5
    .param p1, "configurationKey"    # Ljava/lang/String;
    .param p2, "awsConfig"    # Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 3568
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p2, p1}, Lcom/amazonaws/mobile/config/AWSConfiguration;->optJsonObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    .line 3569
    .local v1, "jsonObject":Lorg/json/JSONObject;
    const-string v2, "GoogleSignIn"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    const/4 v3, 0x1

    if-eqz v2, :cond_1

    .line 3570
    if-eqz v1, :cond_0

    const-string v2, "ClientId-WebApp"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v2, :cond_0

    move v0, v3

    :cond_0
    return v0

    .line 3572
    :cond_1
    if-eqz v1, :cond_2

    move v0, v3

    :cond_2
    return v0

    .line 3574
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    :catch_0
    move-exception v1

    .line 3575
    .local v1, "exception":Ljava/lang/Exception;
    sget-object v2, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " not found in `awsconfiguration.json`"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 3576
    return v0
.end method

.method private registerConfigSignInProviders(Lcom/amazonaws/mobile/config/AWSConfiguration;)V
    .locals 4
    .param p1, "awsConfiguration"    # Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 3531
    sget-object v0, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v1, "Using the SignInProviderConfig from `awsconfiguration.json`."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 3532
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v0

    .line 3535
    .local v0, "identityManager":Lcom/amazonaws/mobile/auth/core/IdentityManager;
    :try_start_0
    const-string v1, "CognitoUserPool"

    invoke-direct {p0, v1, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isConfigurationKeyPresent(Ljava/lang/String;Lcom/amazonaws/mobile/config/AWSConfiguration;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 3536
    const-class v1, Lcom/amazonaws/mobile/auth/userpools/CognitoUserPoolsSignInProvider;

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->addSignInProvider(Ljava/lang/Class;)V

    .line 3539
    :cond_0
    const-string v1, "FacebookSignIn"

    invoke-direct {p0, v1, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isConfigurationKeyPresent(Ljava/lang/String;Lcom/amazonaws/mobile/config/AWSConfiguration;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 3540
    const-class v1, Lcom/amazonaws/mobile/auth/facebook/FacebookSignInProvider;

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->addSignInProvider(Ljava/lang/Class;)V

    .line 3543
    :cond_1
    const-string v1, "GoogleSignIn"

    invoke-direct {p0, v1, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isConfigurationKeyPresent(Ljava/lang/String;Lcom/amazonaws/mobile/config/AWSConfiguration;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 3544
    const-class v1, Lcom/amazonaws/mobile/auth/google/GoogleSignInProvider;

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->addSignInProvider(Ljava/lang/Class;)V
    :try_end_0
    .catch Ljava/lang/NoClassDefFoundError; {:try_start_0 .. :try_end_0} :catch_0

    .line 3549
    :cond_2
    goto :goto_0

    .line 3546
    :catch_0
    move-exception v1

    .line 3547
    .local v1, "exception":Ljava/lang/NoClassDefFoundError;
    sget-object v2, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v3, "Sign in provider was not registered due to missing optional dependency. showSignIn() API may not work as expected."

    invoke-static {v2, v3, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 3550
    .end local v1    # "exception":Ljava/lang/NoClassDefFoundError;
    :goto_0
    return-void
.end method

.method private registerUserSignInProvidersWithPermissions()V
    .locals 7

    .line 3510
    sget-object v0, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v1, "Using the SignInProviderConfig supplied by the user."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 3511
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v0

    .line 3513
    .local v0, "identityManager":Lcom/amazonaws/mobile/auth/core/IdentityManager;
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->signInProviderConfig:[Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;

    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_2

    aget-object v4, v1, v3

    .line 3514
    .local v4, "config":Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;
    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;->getSignInProviderClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v0, v5}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->addSignInProvider(Ljava/lang/Class;)V

    .line 3515
    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;->getProviderPermissions()[Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_1

    .line 3516
    const-class v5, Lcom/amazonaws/mobile/auth/facebook/FacebookSignInProvider;

    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;->getSignInProviderClass()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 3517
    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;->getProviderPermissions()[Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/amazonaws/mobile/auth/facebook/FacebookSignInProvider;->setPermissions([Ljava/lang/String;)V

    .line 3519
    :cond_0
    const-class v5, Lcom/amazonaws/mobile/auth/google/GoogleSignInProvider;

    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;->getSignInProviderClass()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 3520
    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;->getProviderPermissions()[Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/amazonaws/mobile/auth/google/GoogleSignInProvider;->setPermissions([Ljava/lang/String;)V

    .line 3513
    .end local v4    # "config":Lcom/amazonaws/mobile/client/AWSMobileClient$SignInProviderConfig;
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 3524
    :cond_2
    return-void
.end method

.method private resumeSession(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;)V
    .locals 1
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "startupAuthResultHandler"    # Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;

    .line 3589
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v0

    .line 3590
    invoke-virtual {v0, p1, p2}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->resumeSession(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;)V

    .line 3591
    return-void
.end method


# virtual methods
.method _currentUserState()Lcom/amazonaws/mobile/client/internal/ReturningRunnable;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/amazonaws/mobile/client/internal/ReturningRunnable<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;"
        }
    .end annotation

    .line 844
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$5;

    invoke-direct {v0, p0}, Lcom/amazonaws/mobile/client/AWSMobileClient$5;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;)V

    return-object v0
.end method

.method _getCachedIdentityId()Ljava/lang/String;
    .locals 2

    .line 963
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    const-string v1, "cognitoIdentityId"

    invoke-interface {v0, v1}, Lcom/amazonaws/mobile/client/KeyValueStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected _initialize(Landroid/content/Context;Lcom/amazonaws/mobile/config/AWSConfiguration;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "awsConfiguration"    # Lcom/amazonaws/mobile/config/AWSConfiguration;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Lcom/amazonaws/mobile/config/AWSConfiguration;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;)",
            "Ljava/lang/Runnable;"
        }
    .end annotation

    .line 457
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/AWSMobileClient$2;

    invoke-direct {v0, p0, p3, p2, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$2;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/Callback;Lcom/amazonaws/mobile/config/AWSConfiguration;Landroid/content/Context;)V

    return-object v0
.end method

.method public addUserStateListener(Lcom/amazonaws/mobile/client/UserStateListener;)V
    .locals 2
    .param p1, "listener"    # Lcom/amazonaws/mobile/client/UserStateListener;

    .line 863
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->listeners:Ljava/util/List;

    monitor-enter v0

    .line 864
    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->listeners:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 865
    monitor-exit v0

    .line 866
    return-void

    .line 865
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public changePassword(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "oldPassword"    # Ljava/lang/String;
    .param p2, "newPassword"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2454
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2455
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_changePassword(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    .line 2456
    return-void
.end method

.method public changePassword(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "oldPassword"    # Ljava/lang/String;
    .param p2, "newPassword"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Ljava/lang/Void;",
            ">;)V"
        }
    .end annotation

    .line 2446
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Ljava/lang/Void;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2447
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_changePassword(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 2448
    return-void
.end method

.method public confirmForgotPassword(Ljava/lang/String;Ljava/lang/String;)Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;
    .locals 2
    .param p1, "password"    # Ljava/lang/String;
    .param p2, "forgotPasswordChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2413
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2414
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;>;"
    nop

    .line 2415
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v1

    .line 2414
    invoke-direct {p0, p1, p2, v1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmForgotPassword(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;

    return-object v1
.end method

.method public confirmForgotPassword(Ljava/lang/String;Ljava/util/Map;Ljava/lang/String;)Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;
    .locals 2
    .param p1, "password"    # Ljava/lang/String;
    .param p3, "forgotPasswordChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2379
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2380
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;>;"
    invoke-direct {p0, p1, p3, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmForgotPassword(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;

    return-object v1
.end method

.method public confirmForgotPassword(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "password"    # Ljava/lang/String;
    .param p2, "forgotPasswordChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;",
            ">;)V"
        }
    .end annotation

    .line 2397
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2398
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    nop

    .line 2399
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v1

    .line 2398
    invoke-direct {p0, p1, p2, v1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmForgotPassword(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 2400
    return-void
.end method

.method public confirmForgotPassword(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "password"    # Ljava/lang/String;
    .param p2, "forgotPasswordChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;",
            ">;)V"
        }
    .end annotation

    .line 2362
    .local p3, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p4}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2363
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-direct {p0, p1, p2, p3, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmForgotPassword(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 2364
    return-void
.end method

.method public confirmSignIn(Ljava/lang/String;)Lcom/amazonaws/mobile/client/results/SignInResult;
    .locals 1
    .param p1, "signInChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1292
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->confirmSignIn(Ljava/lang/String;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/SignInResult;

    move-result-object v0

    return-object v0
.end method

.method public confirmSignIn(Ljava/lang/String;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/SignInResult;
    .locals 2
    .param p1, "signInChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/mobile/client/results/SignInResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1299
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 1300
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmSignIn(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/SignInResult;

    return-object v1
.end method

.method public confirmSignIn(Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/SignInResult;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/mobile/client/results/SignInResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1413
    .local p1, "signInChallengeResponse":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 1414
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    const/4 v1, 0x0

    invoke-direct {p0, p1, v0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmSignIn(Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;Ljava/util/Map;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/SignInResult;

    return-object v1
.end method

.method public confirmSignIn(Ljava/util/Map;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/SignInResult;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/mobile/client/results/SignInResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1386
    .local p1, "signInChallengeResponse":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p2, "clientMetaData":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 1387
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    invoke-direct {p0, p1, v0, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmSignIn(Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;Ljava/util/Map;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/SignInResult;

    return-object v1
.end method

.method public confirmSignIn(Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 1
    .param p1, "signInChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignInResult;",
            ">;)V"
        }
    .end annotation

    .line 1278
    .local p2, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p0, p1, v0, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->confirmSignIn(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V

    .line 1279
    return-void
.end method

.method public confirmSignIn(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "signInChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignInResult;",
            ">;)V"
        }
    .end annotation

    .line 1286
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 1287
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmSignIn(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 1288
    return-void
.end method

.method public confirmSignIn(Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignInResult;",
            ">;)V"
        }
    .end annotation

    .line 1400
    .local p1, "signInChallengeResponse":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p2, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->confirmSignIn(Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V

    .line 1401
    return-void
.end method

.method public confirmSignIn(Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignInResult;",
            ">;)V"
        }
    .end annotation

    .line 1369
    .local p1, "signInChallengeResponse":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p2, "clientMetaData":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 1370
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-direct {p0, p1, v0, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmSignIn(Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;Ljava/util/Map;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 1371
    return-void
.end method

.method public confirmSignUp(Ljava/lang/String;Ljava/lang/String;)Lcom/amazonaws/mobile/client/results/SignUpResult;
    .locals 2
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "signUpChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2123
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2124
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    nop

    .line 2125
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v1

    .line 2124
    invoke-direct {p0, p1, p2, v1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmSignUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/SignUpResult;

    return-object v1
.end method

.method public confirmSignUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/SignUpResult;
    .locals 2
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "signUpChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/mobile/client/results/SignUpResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2090
    .local p3, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2091
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    invoke-direct {p0, p1, p2, p3, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmSignUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/SignUpResult;

    return-object v1
.end method

.method public confirmSignUp(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "signUpChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignUpResult;",
            ">;)V"
        }
    .end annotation

    .line 2108
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2109
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    nop

    .line 2110
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v1

    .line 2109
    invoke-direct {p0, p1, p2, v1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmSignUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 2111
    return-void
.end method

.method public confirmSignUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "signUpChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignUpResult;",
            ">;)V"
        }
    .end annotation

    .line 2073
    .local p3, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p4}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2074
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-direct {p0, p1, p2, p3, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmSignUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 2076
    return-void
.end method

.method public confirmUpdateUserAttribute(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "attributeName"    # Ljava/lang/String;
    .param p2, "updateUserAttributeChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2743
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2744
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Ljava/lang/Void;>;"
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmUserAttribute(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    .line 2745
    return-void
.end method

.method public confirmUpdateUserAttribute(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "attributeName"    # Ljava/lang/String;
    .param p2, "updateUserAttributeChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Ljava/lang/Void;",
            ">;)V"
        }
    .end annotation

    .line 2729
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Ljava/lang/Void;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2730
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmUserAttribute(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 2731
    return-void
.end method

.method public confirmVerifyUserAttribute(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "attributeName"    # Ljava/lang/String;
    .param p2, "updateUserAttributeChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2772
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2773
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Ljava/lang/Void;>;"
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmUserAttribute(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    .line 2774
    return-void
.end method

.method public confirmVerifyUserAttribute(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "attributeName"    # Ljava/lang/String;
    .param p2, "updateUserAttributeChallengeResponse"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Ljava/lang/Void;",
            ">;)V"
        }
    .end annotation

    .line 2758
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Ljava/lang/Void;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2759
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_confirmUserAttribute(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 2760
    return-void
.end method

.method public currentUserState()Lcom/amazonaws/mobile/client/UserStateDetails;
    .locals 3

    .line 826
    :try_start_0
    invoke-virtual {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_currentUserState()Lcom/amazonaws/mobile/client/internal/ReturningRunnable;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/internal/ReturningRunnable;->await()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/mobile/client/UserStateDetails;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 827
    :catch_0
    move-exception v0

    .line 828
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/RuntimeException;

    const-string v2, "Failed to retrieve user state."

    invoke-direct {v1, v2, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public currentUserState(Lcom/amazonaws/mobile/client/Callback;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;)V"
        }
    .end annotation

    .line 840
    .local p1, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    invoke-virtual {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_currentUserState()Lcom/amazonaws/mobile/client/internal/ReturningRunnable;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/amazonaws/mobile/client/internal/ReturningRunnable;->async(Lcom/amazonaws/mobile/client/Callback;)V

    .line 841
    return-void
.end method

.method protected federateWithCognitoIdentity(Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p1, "providerKey"    # Ljava/lang/String;
    .param p2, "token"    # Ljava/lang/String;

    .line 1748
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->federateWithCognitoIdentityLockObject:Ljava/lang/Object;

    monitor-enter v0

    .line 1749
    :try_start_0
    invoke-direct {p0, p1, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->hasFederatedToken(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 1750
    sget-object v1, Lcom/amazonaws/mobile/client/IdentityProvider;->DEVELOPER:Lcom/amazonaws/mobile/client/IdentityProvider;

    invoke-virtual {v1, p1}, Lcom/amazonaws/mobile/client/IdentityProvider;->equals(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1751
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->provider:Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;

    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    const-string v3, "cognitoIdentityId"

    invoke-interface {v2, v3}, Lcom/amazonaws/mobile/client/KeyValueStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, p2}, Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;->setDeveloperAuthenticated(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 1753
    :cond_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->provider:Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;

    invoke-virtual {v1}, Lcom/amazonaws/mobile/client/AWSMobileClientCognitoIdentityProvider;->setNotDeveloperAuthenticated()V

    .line 1756
    :goto_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    const-string v2, "customRoleArn"

    invoke-interface {v1, v2}, Lcom/amazonaws/mobile/client/KeyValueStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1757
    .local v1, "customRoleArn":Ljava/lang/String;
    invoke-static {v1}, Lcom/amazonaws/util/StringUtils;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 1758
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-virtual {v2, v1}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->setCustomRoleArn(Ljava/lang/String;)V

    .line 1761
    :cond_1
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    .line 1762
    .local v2, "logins":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {v2, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1763
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-virtual {v3, v2}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->setLogins(Ljava/util/Map;)V

    .line 1764
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-virtual {v3}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->refresh()V

    .line 1766
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    const-string v4, "cognitoIdentityId"

    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-virtual {v5}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->getIdentityId()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v3, v4, v5}, Lcom/amazonaws/mobile/client/KeyValueStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 1767
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-virtual {v3}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->getLogins()Ljava/util/Map;

    move-result-object v3

    iput-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mFederatedLoginsMap:Ljava/util/Map;

    .line 1769
    .end local v1    # "customRoleArn":Ljava/lang/String;
    .end local v2    # "logins":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_2
    monitor-exit v0

    .line 1770
    return-void

    .line 1769
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public federatedSignIn(Ljava/lang/String;Ljava/lang/String;)Lcom/amazonaws/mobile/client/UserStateDetails;
    .locals 7
    .param p1, "providerKey"    # Ljava/lang/String;
    .param p2, "token"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1620
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 1621
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    const/4 v4, 0x0

    const/4 v6, 0x1

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v5, v0

    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_federatedSignIn(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/FederatedSignInOptions;Lcom/amazonaws/mobile/client/Callback;Z)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/UserStateDetails;

    return-object v1
.end method

.method public federatedSignIn(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/FederatedSignInOptions;)Lcom/amazonaws/mobile/client/UserStateDetails;
    .locals 7
    .param p1, "providerKey"    # Ljava/lang/String;
    .param p2, "token"    # Ljava/lang/String;
    .param p3, "options"    # Lcom/amazonaws/mobile/client/FederatedSignInOptions;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1655
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 1656
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    const/4 v6, 0x1

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, v0

    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_federatedSignIn(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/FederatedSignInOptions;Lcom/amazonaws/mobile/client/Callback;Z)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/UserStateDetails;

    return-object v1
.end method

.method public federatedSignIn(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 7
    .param p1, "providerKey"    # Ljava/lang/String;
    .param p2, "token"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;)V"
        }
    .end annotation

    .line 1605
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 1606
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    const/4 v4, 0x0

    const/4 v6, 0x1

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v5, v0

    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_federatedSignIn(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/FederatedSignInOptions;Lcom/amazonaws/mobile/client/Callback;Z)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 1607
    return-void
.end method

.method public federatedSignIn(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/FederatedSignInOptions;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 7
    .param p1, "providerKey"    # Ljava/lang/String;
    .param p2, "token"    # Ljava/lang/String;
    .param p3, "options"    # Lcom/amazonaws/mobile/client/FederatedSignInOptions;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/FederatedSignInOptions;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;)V"
        }
    .end annotation

    .line 1638
    .local p4, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p4}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 1639
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    const/4 v6, 0x1

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, v0

    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_federatedSignIn(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/FederatedSignInOptions;Lcom/amazonaws/mobile/client/Callback;Z)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 1640
    return-void
.end method

.method protected federatedSignInWithoutAssigningState(Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .param p1, "providerKey"    # Ljava/lang/String;
    .param p2, "token"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1660
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 1661
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    const/4 v4, 0x0

    const/4 v6, 0x0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v5, v0

    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_federatedSignIn(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/FederatedSignInOptions;Lcom/amazonaws/mobile/client/Callback;Z)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    .line 1662
    return-void
.end method

.method protected federatedSignInWithoutAssigningState(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 7
    .param p1, "providerKey"    # Ljava/lang/String;
    .param p2, "token"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;)V"
        }
    .end annotation

    .line 1667
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 1668
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    const/4 v4, 0x0

    const/4 v6, 0x0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v5, v0

    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_federatedSignIn(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/mobile/client/FederatedSignInOptions;Lcom/amazonaws/mobile/client/Callback;Z)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 1669
    return-void
.end method

.method public forgotPassword(Ljava/lang/String;)Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;
    .locals 2
    .param p1, "username"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2305
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2306
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;>;"
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v1

    invoke-direct {p0, p1, v1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_forgotPassword(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;

    return-object v1
.end method

.method public forgotPassword(Ljava/lang/String;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;
    .locals 2
    .param p1, "username"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2278
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2279
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;>;"
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_forgotPassword(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;

    return-object v1
.end method

.method public forgotPassword(Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "username"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;",
            ">;)V"
        }
    .end annotation

    .line 2293
    .local p2, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p2}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2294
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v1

    invoke-direct {p0, p1, v1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_forgotPassword(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 2295
    return-void
.end method

.method public forgotPassword(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "username"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;",
            ">;)V"
        }
    .end annotation

    .line 2265
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/ForgotPasswordResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2266
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_forgotPassword(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 2267
    return-void
.end method

.method public getAWSCredentials()Lcom/amazonaws/auth/AWSCredentials;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 401
    invoke-direct {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_getAWSCredentials()Lcom/amazonaws/mobile/client/internal/ReturningRunnable;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/internal/ReturningRunnable;->await()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/auth/AWSCredentials;

    return-object v0
.end method

.method public getAWSCredentials(Lcom/amazonaws/mobile/client/Callback;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/auth/AWSCredentials;",
            ">;)V"
        }
    .end annotation

    .line 406
    .local p1, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/auth/AWSCredentials;>;"
    invoke-direct {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_getAWSCredentials()Lcom/amazonaws/mobile/client/internal/ReturningRunnable;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/amazonaws/mobile/client/internal/ReturningRunnable;->async(Lcom/amazonaws/mobile/client/Callback;)V

    .line 407
    return-void
.end method

.method public getClient(Landroid/content/Context;Ljava/lang/Class;)Lcom/amazonaws/mobile/config/AWSConfigurable;
    .locals 5
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/Class<",
            "+",
            "Lcom/amazonaws/mobile/config/AWSConfigurable;",
            ">;)",
            "Lcom/amazonaws/mobile/config/AWSConfigurable;"
        }
    .end annotation

    .line 3456
    .local p2, "clientClass":Ljava/lang/Class;, "Ljava/lang/Class<+Lcom/amazonaws/mobile/config/AWSConfigurable;>;"
    sget-object v0, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Retrieving the client instance for class: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 3458
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->clientMap:Ljava/util/LinkedHashMap;

    invoke-virtual {v0, p2}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/mobile/config/AWSConfigurable;

    .line 3461
    .local v0, "client":Lcom/amazonaws/mobile/config/AWSConfigurable;
    if-nez v0, :cond_0

    .line 3462
    :try_start_0
    invoke-virtual {p2}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/config/AWSConfigurable;

    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-interface {v1, v2, v3}, Lcom/amazonaws/mobile/config/AWSConfigurable;->initialize(Landroid/content/Context;Lcom/amazonaws/mobile/config/AWSConfiguration;)Lcom/amazonaws/mobile/config/AWSConfigurable;

    move-result-object v1

    move-object v0, v1

    .line 3463
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->clientMap:Ljava/util/LinkedHashMap;

    invoke-virtual {v1, p2, v0}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 3464
    sget-object v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Created the new client: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 3466
    :catch_0
    move-exception v1

    .line 3467
    .local v1, "exception":Ljava/lang/Exception;
    sget-object v2, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Error occurred in creating and initializing client. Check the context and the clientClass passed in: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 3469
    .end local v1    # "exception":Ljava/lang/Exception;
    :cond_0
    :goto_0
    nop

    .line 3471
    :goto_1
    return-object v0
.end method

.method public getConfiguration()Lcom/amazonaws/mobile/config/AWSConfiguration;
    .locals 1

    .line 350
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    return-object v0
.end method

.method public getCredentials()Lcom/amazonaws/auth/AWSCredentials;
    .locals 5

    .line 355
    const-string v0, "Failed to get credentials from Cognito Identity"

    invoke-virtual {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isLegacyMode()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 356
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getCredentialsProvider()Lcom/amazonaws/auth/AWSCredentialsProvider;

    move-result-object v0

    invoke-interface {v0}, Lcom/amazonaws/auth/AWSCredentialsProvider;->getCredentials()Lcom/amazonaws/auth/AWSCredentials;

    move-result-object v0

    return-object v0

    .line 359
    :cond_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    if-eqz v1, :cond_2

    .line 364
    :try_start_0
    invoke-virtual {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->waitForSignIn()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 365
    sget-object v1, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v2, "getCredentials: Validated user is signed-in"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 368
    :cond_1
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-virtual {v1}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->getCredentials()Lcom/amazonaws/auth/AWSSessionCredentials;

    move-result-object v1

    .line 369
    .local v1, "credentials":Lcom/amazonaws/auth/AWSSessionCredentials;
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    const-string v3, "cognitoIdentityId"

    iget-object v4, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-virtual {v4}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->getIdentityId()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Lcom/amazonaws/mobile/client/KeyValueStore;->set(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Lcom/amazonaws/services/cognitoidentity/model/NotAuthorizedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 370
    return-object v1

    .line 374
    .end local v1    # "credentials":Lcom/amazonaws/auth/AWSSessionCredentials;
    :catch_0
    move-exception v1

    .line 375
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Lcom/amazonaws/AmazonClientException;

    invoke-direct {v2, v0, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    .line 371
    .end local v1    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v1

    .line 372
    .local v1, "e":Lcom/amazonaws/services/cognitoidentity/model/NotAuthorizedException;
    sget-object v2, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v3, "getCredentials: Failed to getCredentials from Cognito Identity"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 373
    new-instance v2, Lcom/amazonaws/AmazonClientException;

    invoke-direct {v2, v0, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    .line 360
    .end local v1    # "e":Lcom/amazonaws/services/cognitoidentity/model/NotAuthorizedException;
    :cond_2
    new-instance v0, Lcom/amazonaws/AmazonClientException;

    const-string v1, "Cognito Identity not configured"

    invoke-direct {v0, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getDeviceOperations()Lcom/amazonaws/mobile/client/DeviceOperations;
    .locals 2

    .line 727
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mDeviceOperations:Lcom/amazonaws/mobile/client/DeviceOperations;

    if-eqz v0, :cond_0

    .line 730
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mDeviceOperations:Lcom/amazonaws/mobile/client/DeviceOperations;

    return-object v0

    .line 728
    :cond_0
    new-instance v0, Lcom/amazonaws/AmazonClientException;

    const-string v1, "Please check if userpools is configured."

    invoke-direct {v0, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method getHostedUI(Lorg/json/JSONObject;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;
    .locals 5
    .param p1, "hostedUIJSON"    # Lorg/json/JSONObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 699
    const-string v0, "Scopes"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    .line 700
    .local v0, "scopesJSONArray":Lorg/json/JSONArray;
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    .line 701
    .local v1, "scopes":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-ge v2, v3, :cond_0

    .line 702
    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 701
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 705
    .end local v2    # "i":I
    :cond_0
    new-instance v2, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    invoke-direct {v2}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;-><init>()V

    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mContext:Landroid/content/Context;

    .line 706
    invoke-virtual {v2, v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setApplicationContext(Landroid/content/Context;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mUserPoolPoolId:Ljava/lang/String;

    .line 707
    invoke-virtual {v2, v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setUserPoolId(Ljava/lang/String;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    .line 708
    const-string v3, "AppClientId"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setAppClientId(Ljava/lang/String;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    .line 709
    const-string v3, "AppClientSecret"

    const/4 v4, 0x0

    invoke-virtual {p1, v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setAppClientSecret(Ljava/lang/String;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    .line 710
    const-string v3, "WebDomain"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setAppCognitoWebDomain(Ljava/lang/String;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    .line 711
    const-string v3, "SignInRedirectURI"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setSignInRedirect(Ljava/lang/String;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    .line 712
    const-string v3, "SignOutRedirectURI"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setSignOutRedirect(Ljava/lang/String;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    .line 713
    invoke-virtual {v2, v1}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setScopes(Ljava/util/Set;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    .line 714
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setAdvancedSecurityDataCollection(Z)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    .line 715
    const-string v3, "IdentityProvider"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setIdentityProvider(Ljava/lang/String;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    .line 716
    const-string v3, "IdpIdentifier"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;->setIdpIdentifier(Ljava/lang/String;)Lcom/amazonaws/mobileconnectors/cognitoauth/Auth$Builder;

    move-result-object v2

    .line 705
    return-object v2
.end method

.method getHostedUIJSON()Lorg/json/JSONObject;
    .locals 1

    .line 669
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-virtual {p0, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getHostedUIJSON(Lcom/amazonaws/mobile/config/AWSConfiguration;)Lorg/json/JSONObject;

    move-result-object v0

    return-object v0
.end method

.method getHostedUIJSON(Lcom/amazonaws/mobile/config/AWSConfiguration;)Lorg/json/JSONObject;
    .locals 8
    .param p1, "awsConfig"    # Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 674
    const-string v0, "hostedUI"

    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getHostedUIJSONFromJSON(Lcom/amazonaws/mobile/config/AWSConfiguration;)Lorg/json/JSONObject;

    move-result-object v2

    .line 675
    .local v2, "hostedUIJSONFromJSON":Lorg/json/JSONObject;
    if-nez v2, :cond_0

    .line 676
    return-object v1

    .line 679
    :cond_0
    iget-object v3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    invoke-interface {v3, v0}, Lcom/amazonaws/mobile/client/KeyValueStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 680
    .local v3, "hostedUIString":Ljava/lang/String;
    const/4 v4, 0x0

    .line 682
    .local v4, "hostedUIJSON":Lorg/json/JSONObject;
    :try_start_1
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5, v3}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-object v4, v5

    .line 686
    goto :goto_0

    .line 683
    :catch_0
    move-exception v5

    .line 684
    .local v5, "e":Ljava/lang/Exception;
    :try_start_2
    sget-object v6, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v7, "Failed to parse HostedUI settings from store. Defaulting to awsconfiguration.json"

    invoke-static {v6, v7, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 687
    .end local v5    # "e":Ljava/lang/Exception;
    :goto_0
    if-nez v4, :cond_1

    if-eqz v2, :cond_1

    .line 688
    new-instance v5, Lorg/json/JSONObject;

    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    move-object v4, v5

    .line 689
    iget-object v5, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    invoke-virtual {v4}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-interface {v5, v0, v6}, Lcom/amazonaws/mobile/client/KeyValueStore;->set(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .line 691
    :cond_1
    return-object v4

    .line 692
    .end local v2    # "hostedUIJSONFromJSON":Lorg/json/JSONObject;
    .end local v3    # "hostedUIString":Ljava/lang/String;
    .end local v4    # "hostedUIJSON":Lorg/json/JSONObject;
    :catch_1
    move-exception v0

    .line 693
    .local v0, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v3, "getHostedUIJSON: Failed to read config"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 695
    .end local v0    # "e":Ljava/lang/Exception;
    return-object v1
.end method

.method getHostedUIJSONFromJSON()Lorg/json/JSONObject;
    .locals 1

    .line 651
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-virtual {p0, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getHostedUIJSONFromJSON(Lcom/amazonaws/mobile/config/AWSConfiguration;)Lorg/json/JSONObject;

    move-result-object v0

    return-object v0
.end method

.method getHostedUIJSONFromJSON(Lcom/amazonaws/mobile/config/AWSConfiguration;)Lorg/json/JSONObject;
    .locals 4
    .param p1, "awsConfig"    # Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 655
    const-string v0, "Auth"

    invoke-virtual {p1, v0}, Lcom/amazonaws/mobile/config/AWSConfiguration;->optJsonObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 656
    .local v0, "mobileClientJSON":Lorg/json/JSONObject;
    if-eqz v0, :cond_0

    const-string v1, "OAuth"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 658
    :try_start_0
    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 660
    .local v1, "hostedUIJSONFromJSON":Lorg/json/JSONObject;
    return-object v1

    .line 661
    .end local v1    # "hostedUIJSONFromJSON":Lorg/json/JSONObject;
    :catch_0
    move-exception v1

    .line 662
    .local v1, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v3, "getHostedUIJSONFromJSON: Failed to read config"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 665
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_0
    const/4 v1, 0x0

    return-object v1
.end method

.method public getIdentityId()Ljava/lang/String;
    .locals 3

    .line 420
    invoke-virtual {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isLegacyMode()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 421
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getCachedUserID()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 424
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    if-eqz v0, :cond_2

    .line 428
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-virtual {v0}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->getCachedIdentityId()Ljava/lang/String;

    move-result-object v0

    .line 429
    .local v0, "cachedIdentityId":Ljava/lang/String;
    if-nez v0, :cond_1

    .line 430
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    const-string v2, "cognitoIdentityId"

    invoke-interface {v1, v2}, Lcom/amazonaws/mobile/client/KeyValueStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 433
    :cond_1
    return-object v0

    .line 425
    .end local v0    # "cachedIdentityId":Ljava/lang/String;
    :cond_2
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Cognito Identity not configured"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method getLoginKey()Ljava/lang/String;
    .locals 1

    .line 887
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpoolsLoginKey:Ljava/lang/String;

    return-object v0
.end method

.method getSignInDetailsMap()Ljava/util/Map;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 959
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, "provider"

    aput-object v3, v1, v2

    const/4 v2, 0x1

    const-string/jumbo v3, "token"

    aput-object v3, v1, v2

    invoke-interface {v0, v1}, Lcom/amazonaws/mobile/client/KeyValueStore;->get([Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method getSignInMode()Lcom/amazonaws/mobile/client/AWSMobileClient$SignInMode;
    .locals 2

    .line 1115
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    const-string/jumbo v1, "signInMode"

    invoke-interface {v0, v1}, Lcom/amazonaws/mobile/client/KeyValueStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/amazonaws/mobile/client/AWSMobileClient$SignInMode;->fromString(Ljava/lang/String;)Lcom/amazonaws/mobile/client/AWSMobileClient$SignInMode;

    move-result-object v0

    return-object v0
.end method

.method getSignInUILatch()Ljava/util/concurrent/CountDownLatch;
    .locals 1

    .line 453
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->showSignInWaitLatch:Ljava/util/concurrent/CountDownLatch;

    return-object v0
.end method

.method public getTokens()Lcom/amazonaws/mobile/client/results/Tokens;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1781
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 1782
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/Tokens;>;"
    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_getTokens(Lcom/amazonaws/mobile/client/Callback;Z)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/Tokens;

    return-object v1
.end method

.method protected getTokens(Z)Lcom/amazonaws/mobile/client/results/Tokens;
    .locals 2
    .param p1, "waitForSignIn"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1799
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 1800
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/Tokens;>;"
    invoke-direct {p0, v0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_getTokens(Lcom/amazonaws/mobile/client/Callback;Z)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/Tokens;

    return-object v1
.end method

.method public getTokens(Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/Tokens;",
            ">;)V"
        }
    .end annotation

    .line 1794
    .local p1, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/Tokens;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 1795
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/Tokens;>;"
    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_getTokens(Lcom/amazonaws/mobile/client/Callback;Z)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 1796
    return-void
.end method

.method public getUserAttributes()Ljava/util/Map;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2492
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2493
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;>;"
    invoke-direct {p0, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_getUserAttributes(Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map;

    return-object v1
.end method

.method public getUserAttributes(Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;>;)V"
        }
    .end annotation

    .line 2486
    .local p1, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2487
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;>;"
    invoke-direct {p0, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_getUserAttributes(Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 2488
    return-void
.end method

.method protected getUserStateDetails(Z)Lcom/amazonaws/mobile/client/UserStateDetails;
    .locals 12
    .param p1, "offlineCheck"    # Z

    .line 974
    invoke-virtual {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getSignInDetailsMap()Ljava/util/Map;

    move-result-object v0

    .line 975
    .local v0, "details":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v1, "provider"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 976
    .local v1, "providerKey":Ljava/lang/String;
    const-string/jumbo v2, "token"

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 977
    .local v3, "token":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_getCachedIdentityId()Ljava/lang/String;

    move-result-object v4

    .line 979
    .local v4, "identityId":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isFederationEnabled()Z

    move-result v5

    .line 980
    .local v5, "federationEnabled":Z
    sget-object v6, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v7, "Inspecting user state details"

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 982
    const/4 v6, 0x0

    if-eqz v1, :cond_0

    if-eqz v3, :cond_0

    const/4 v7, 0x1

    goto :goto_0

    :cond_0
    move v7, v6

    .line 985
    .local v7, "hasUsefulToken":Z
    :goto_0
    const/4 v8, 0x0

    if-nez p1, :cond_14

    iget-object v9, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mContext:Landroid/content/Context;

    invoke-virtual {p0, v9}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isNetworkAvailable(Landroid/content/Context;)Z

    move-result v9

    if-nez v9, :cond_1

    goto/16 :goto_6

    .line 998
    :cond_1
    if-eqz v7, :cond_8

    iget-object v9, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpoolsLoginKey:Ljava/lang/String;

    invoke-virtual {v9, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_8

    .line 1001
    if-nez v5, :cond_2

    goto :goto_1

    .line 1005
    :cond_2
    move-object v2, v3

    .line 1006
    .local v2, "refreshedToken":Ljava/lang/String;
    :try_start_0
    iget-object v6, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mContext:Landroid/content/Context;

    .line 1007
    invoke-static {v6}, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->getInstance(Landroid/content/Context;)Lcom/amazonaws/mobile/auth/core/signin/SignInManager;

    move-result-object v6

    invoke-virtual {v6}, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->getPreviouslySignedInProvider()Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;

    move-result-object v6

    .line 1008
    .local v6, "previouslySignedInProvider":Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;
    if-eqz v6, :cond_3

    invoke-interface {v6}, Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;->getCognitoLoginKey()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_3

    .line 1009
    invoke-interface {v6}, Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;->getToken()Ljava/lang/String;

    move-result-object v8

    move-object v2, v8

    .line 1010
    sget-object v8, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v9, "Token was refreshed using drop-in UI internal mechanism"

    invoke-static {v8, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1013
    :cond_3
    if-nez v2, :cond_4

    .line 1014
    sget-object v8, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v9, "Token used for federation has become null"

    invoke-static {v8, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1015
    new-instance v8, Lcom/amazonaws/mobile/client/UserStateDetails;

    sget-object v9, Lcom/amazonaws/mobile/client/UserState;->SIGNED_OUT_FEDERATED_TOKENS_INVALID:Lcom/amazonaws/mobile/client/UserState;

    invoke-direct {v8, v9, v0}, Lcom/amazonaws/mobile/client/UserStateDetails;-><init>(Lcom/amazonaws/mobile/client/UserState;Ljava/util/Map;)V

    return-object v8

    .line 1019
    :cond_4
    invoke-direct {p0, v1, v2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->hasFederatedToken(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_5

    .line 1020
    sget-object v8, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v9, "getUserStateDetails: token already federated just fetch credentials"

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1021
    iget-object v8, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    if-eqz v8, :cond_6

    .line 1022
    iget-object v8, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-virtual {v8}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->getCredentials()Lcom/amazonaws/auth/AWSSessionCredentials;

    goto :goto_1

    .line 1025
    :cond_5
    invoke-virtual {p0, v1, v2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->federateWithCognitoIdentity(Ljava/lang/String;Ljava/lang/String;)V

    .line 1029
    .end local v2    # "refreshedToken":Ljava/lang/String;
    .end local v6    # "previouslySignedInProvider":Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;
    :cond_6
    :goto_1
    new-instance v2, Lcom/amazonaws/mobile/client/UserStateDetails;

    sget-object v6, Lcom/amazonaws/mobile/client/UserState;->SIGNED_IN:Lcom/amazonaws/mobile/client/UserState;

    invoke-direct {v2, v6, v0}, Lcom/amazonaws/mobile/client/UserStateDetails;-><init>(Lcom/amazonaws/mobile/client/UserState;Ljava/util/Map;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 1030
    :catch_0
    move-exception v2

    .line 1031
    .local v2, "e":Ljava/lang/Exception;
    sget-object v6, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v8, "Failed to federate the tokens."

    invoke-static {v6, v8, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1032
    sget-object v6, Lcom/amazonaws/mobile/client/UserState;->SIGNED_IN:Lcom/amazonaws/mobile/client/UserState;

    .line 1033
    .local v6, "userState":Lcom/amazonaws/mobile/client/UserState;
    invoke-virtual {p0, v2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isSignedOutRelatedException(Ljava/lang/Exception;)Z

    move-result v8

    if-eqz v8, :cond_7

    .line 1034
    sget-object v6, Lcom/amazonaws/mobile/client/UserState;->SIGNED_OUT_FEDERATED_TOKENS_INVALID:Lcom/amazonaws/mobile/client/UserState;

    .line 1037
    :cond_7
    new-instance v8, Lcom/amazonaws/mobile/client/UserStateDetails;

    invoke-direct {v8, v6, v0}, Lcom/amazonaws/mobile/client/UserStateDetails;-><init>(Lcom/amazonaws/mobile/client/UserState;Ljava/util/Map;)V

    .line 1038
    .local v8, "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    invoke-virtual {v8, v2}, Lcom/amazonaws/mobile/client/UserStateDetails;->setException(Ljava/lang/Exception;)V

    .line 1039
    return-object v8

    .line 1041
    .end local v2    # "e":Ljava/lang/Exception;
    .end local v6    # "userState":Lcom/amazonaws/mobile/client/UserState;
    .end local v8    # "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    :cond_8
    if-eqz v7, :cond_11

    iget-object v9, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpool:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;

    if-eqz v9, :cond_11

    .line 1042
    const/4 v8, 0x0

    .line 1043
    .local v8, "tokens":Lcom/amazonaws/mobile/client/results/Tokens;
    const/4 v9, 0x0

    .line 1044
    .local v9, "idToken":Ljava/lang/String;
    const/4 v10, 0x0

    .line 1046
    .local v10, "userPoolsException":Ljava/lang/Exception;
    :try_start_1
    invoke-virtual {p0, v6}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getTokens(Z)Lcom/amazonaws/mobile/client/results/Tokens;

    move-result-object v6

    move-object v8, v6

    .line 1047
    invoke-virtual {v8}, Lcom/amazonaws/mobile/client/results/Tokens;->getIdToken()Lcom/amazonaws/mobile/client/results/Token;

    move-result-object v6

    invoke-virtual {v6}, Lcom/amazonaws/mobile/client/results/Token;->getTokenString()Ljava/lang/String;

    move-result-object v6

    move-object v9, v6

    .line 1048
    invoke-interface {v0, v2, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1049
    if-nez v5, :cond_9

    goto :goto_2

    .line 1053
    :cond_9
    invoke-direct {p0, v1, v9}, Lcom/amazonaws/mobile/client/AWSMobileClient;->hasFederatedToken(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz v2, :cond_b

    .line 1055
    :try_start_2
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    if-eqz v2, :cond_a

    .line 1056
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-virtual {v2}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->getCredentials()Lcom/amazonaws/auth/AWSSessionCredentials;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1060
    :cond_a
    goto :goto_2

    .line 1058
    :catch_1
    move-exception v2

    .line 1059
    .restart local v2    # "e":Ljava/lang/Exception;
    :try_start_3
    sget-object v6, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v11, "Failed to get or refresh credentials from Cognito Identity"

    invoke-static {v6, v11, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1060
    nop

    .end local v2    # "e":Ljava/lang/Exception;
    goto :goto_2

    .line 1062
    :cond_b
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    if-eqz v2, :cond_c

    .line 1063
    invoke-virtual {p0, v1, v9}, Lcom/amazonaws/mobile/client/AWSMobileClient;->federateWithCognitoIdentity(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1071
    :cond_c
    :goto_2
    sget-object v2, Lcom/amazonaws/mobile/client/UserState;->SIGNED_IN:Lcom/amazonaws/mobile/client/UserState;

    .line 1072
    .local v2, "userState":Lcom/amazonaws/mobile/client/UserState;
    invoke-virtual {p0, v10}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isSignedOutRelatedException(Ljava/lang/Exception;)Z

    move-result v6

    if-eqz v6, :cond_d

    .line 1073
    sget-object v2, Lcom/amazonaws/mobile/client/UserState;->SIGNED_OUT_USER_POOLS_TOKENS_INVALID:Lcom/amazonaws/mobile/client/UserState;

    .line 1075
    :cond_d
    new-instance v6, Lcom/amazonaws/mobile/client/UserStateDetails;

    invoke-direct {v6, v2, v0}, Lcom/amazonaws/mobile/client/UserStateDetails;-><init>(Lcom/amazonaws/mobile/client/UserState;Ljava/util/Map;)V

    .line 1076
    .local v6, "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    :goto_3
    invoke-virtual {v6, v10}, Lcom/amazonaws/mobile/client/UserStateDetails;->setException(Ljava/lang/Exception;)V

    .line 1077
    return-object v6

    .line 1071
    .end local v2    # "userState":Lcom/amazonaws/mobile/client/UserState;
    .end local v6    # "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    :catchall_0
    move-exception v2

    goto :goto_5

    .line 1066
    :catch_2
    move-exception v2

    .line 1067
    .local v2, "e":Ljava/lang/Exception;
    :try_start_4
    sget-object v6, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    if-nez v8, :cond_e

    const-string v11, "Tokens are invalid, please sign-in again."

    goto :goto_4

    :cond_e
    const-string v11, "Failed to federate the tokens"

    :goto_4
    invoke-static {v6, v11, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 1069
    nop

    .line 1071
    .end local v10    # "userPoolsException":Ljava/lang/Exception;
    .local v2, "userPoolsException":Ljava/lang/Exception;
    sget-object v6, Lcom/amazonaws/mobile/client/UserState;->SIGNED_IN:Lcom/amazonaws/mobile/client/UserState;

    .line 1072
    .local v6, "userState":Lcom/amazonaws/mobile/client/UserState;
    invoke-virtual {p0, v2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isSignedOutRelatedException(Ljava/lang/Exception;)Z

    move-result v10

    if-eqz v10, :cond_f

    .line 1073
    sget-object v6, Lcom/amazonaws/mobile/client/UserState;->SIGNED_OUT_USER_POOLS_TOKENS_INVALID:Lcom/amazonaws/mobile/client/UserState;

    .line 1075
    :cond_f
    new-instance v10, Lcom/amazonaws/mobile/client/UserStateDetails;

    invoke-direct {v10, v6, v0}, Lcom/amazonaws/mobile/client/UserStateDetails;-><init>(Lcom/amazonaws/mobile/client/UserState;Ljava/util/Map;)V

    .line 1076
    .local v10, "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    invoke-virtual {v10, v2}, Lcom/amazonaws/mobile/client/UserStateDetails;->setException(Ljava/lang/Exception;)V

    .line 1077
    return-object v10

    .line 1071
    .end local v2    # "userPoolsException":Ljava/lang/Exception;
    .end local v6    # "userState":Lcom/amazonaws/mobile/client/UserState;
    .local v10, "userPoolsException":Ljava/lang/Exception;
    :goto_5
    sget-object v2, Lcom/amazonaws/mobile/client/UserState;->SIGNED_IN:Lcom/amazonaws/mobile/client/UserState;

    .line 1072
    .local v2, "userState":Lcom/amazonaws/mobile/client/UserState;
    invoke-virtual {p0, v10}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isSignedOutRelatedException(Ljava/lang/Exception;)Z

    move-result v6

    if-eqz v6, :cond_10

    .line 1073
    sget-object v2, Lcom/amazonaws/mobile/client/UserState;->SIGNED_OUT_USER_POOLS_TOKENS_INVALID:Lcom/amazonaws/mobile/client/UserState;

    .line 1075
    :cond_10
    new-instance v6, Lcom/amazonaws/mobile/client/UserStateDetails;

    invoke-direct {v6, v2, v0}, Lcom/amazonaws/mobile/client/UserStateDetails;-><init>(Lcom/amazonaws/mobile/client/UserState;Ljava/util/Map;)V

    goto :goto_3

    .line 1080
    .end local v2    # "userState":Lcom/amazonaws/mobile/client/UserState;
    .end local v8    # "tokens":Lcom/amazonaws/mobile/client/results/Tokens;
    .end local v9    # "idToken":Ljava/lang/String;
    .end local v10    # "userPoolsException":Ljava/lang/Exception;
    :cond_11
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    if-nez v2, :cond_12

    .line 1081
    new-instance v2, Lcom/amazonaws/mobile/client/UserStateDetails;

    sget-object v6, Lcom/amazonaws/mobile/client/UserState;->SIGNED_OUT:Lcom/amazonaws/mobile/client/UserState;

    invoke-direct {v2, v6, v0}, Lcom/amazonaws/mobile/client/UserStateDetails;-><init>(Lcom/amazonaws/mobile/client/UserState;Ljava/util/Map;)V

    return-object v2

    .line 1082
    :cond_12
    if-eqz v4, :cond_13

    .line 1083
    new-instance v2, Lcom/amazonaws/mobile/client/UserStateDetails;

    sget-object v6, Lcom/amazonaws/mobile/client/UserState;->GUEST:Lcom/amazonaws/mobile/client/UserState;

    invoke-direct {v2, v6, v0}, Lcom/amazonaws/mobile/client/UserStateDetails;-><init>(Lcom/amazonaws/mobile/client/UserState;Ljava/util/Map;)V

    return-object v2

    .line 1085
    :cond_13
    new-instance v2, Lcom/amazonaws/mobile/client/UserStateDetails;

    sget-object v6, Lcom/amazonaws/mobile/client/UserState;->SIGNED_OUT:Lcom/amazonaws/mobile/client/UserState;

    invoke-direct {v2, v6, v8}, Lcom/amazonaws/mobile/client/UserStateDetails;-><init>(Lcom/amazonaws/mobile/client/UserState;Ljava/util/Map;)V

    return-object v2

    .line 986
    :cond_14
    :goto_6
    if-eqz v7, :cond_15

    .line 987
    new-instance v2, Lcom/amazonaws/mobile/client/UserStateDetails;

    sget-object v6, Lcom/amazonaws/mobile/client/UserState;->SIGNED_IN:Lcom/amazonaws/mobile/client/UserState;

    invoke-direct {v2, v6, v0}, Lcom/amazonaws/mobile/client/UserStateDetails;-><init>(Lcom/amazonaws/mobile/client/UserState;Ljava/util/Map;)V

    return-object v2

    .line 989
    :cond_15
    if-eqz v4, :cond_16

    .line 990
    new-instance v2, Lcom/amazonaws/mobile/client/UserStateDetails;

    sget-object v6, Lcom/amazonaws/mobile/client/UserState;->GUEST:Lcom/amazonaws/mobile/client/UserState;

    invoke-direct {v2, v6, v0}, Lcom/amazonaws/mobile/client/UserStateDetails;-><init>(Lcom/amazonaws/mobile/client/UserState;Ljava/util/Map;)V

    return-object v2

    .line 992
    :cond_16
    new-instance v2, Lcom/amazonaws/mobile/client/UserStateDetails;

    sget-object v6, Lcom/amazonaws/mobile/client/UserState;->SIGNED_OUT:Lcom/amazonaws/mobile/client/UserState;

    invoke-direct {v2, v6, v8}, Lcom/amazonaws/mobile/client/UserStateDetails;-><init>(Lcom/amazonaws/mobile/client/UserState;Ljava/util/Map;)V

    return-object v2
.end method

.method public getUsername()Ljava/lang/String;
    .locals 4

    .line 808
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpoolsLoginKey:Ljava/lang/String;

    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    const-string v3, "provider"

    invoke-interface {v2, v3}, Lcom/amazonaws/mobile/client/KeyValueStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 809
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpool:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;

    invoke-virtual {v1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;->getCurrentUser()Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

    move-result-object v1

    invoke-virtual {v1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;->getUserId()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 811
    :cond_0
    return-object v0

    .line 812
    :catch_0
    move-exception v1

    .line 813
    .local v1, "e":Ljava/lang/Exception;
    return-object v0
.end method

.method public handleAuthResponse(Landroid/content/Intent;)Z
    .locals 3
    .param p1, "intent"    # Landroid/content/Intent;

    .line 2974
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    .line 2975
    if-eqz p1, :cond_0

    .line 2976
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    invoke-virtual {p1}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;->getTokens(Landroid/net/Uri;)V

    goto :goto_0

    .line 2978
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    invoke-virtual {v0}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;->handleFlowCancelled()V

    .line 2981
    :goto_0
    return v1

    .line 2983
    :cond_1
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mOAuth2Client:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

    if-eqz v0, :cond_2

    if-eqz p1, :cond_2

    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mOAuth2Client:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

    invoke-virtual {p1}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->handleRedirect(Landroid/net/Uri;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 2984
    return v1

    .line 2986
    :cond_2
    const/4 v0, 0x0

    return v0
.end method

.method public initialize(Landroid/content/Context;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;)V"
        }
    .end annotation

    .line 442
    .local p2, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 443
    .local v0, "applicationContext":Landroid/content/Context;
    new-instance v1, Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-direct {v1, v0}, Lcom/amazonaws/mobile/config/AWSConfiguration;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0, v0, v1, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->initialize(Landroid/content/Context;Lcom/amazonaws/mobile/config/AWSConfiguration;Lcom/amazonaws/mobile/client/Callback;)V

    .line 444
    return-void
.end method

.method public initialize(Landroid/content/Context;Lcom/amazonaws/mobile/config/AWSConfiguration;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "awsConfig"    # Lcom/amazonaws/mobile/config/AWSConfiguration;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Lcom/amazonaws/mobile/config/AWSConfiguration;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;)V"
        }
    .end annotation

    .line 448
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 449
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-virtual {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_initialize(Landroid/content/Context;Lcom/amazonaws/mobile/config/AWSConfiguration;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 450
    return-void
.end method

.method isFederationEnabled()Z
    .locals 2

    .line 1104
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    const-string v1, "isFederationEnabled"

    invoke-interface {v0, v1}, Lcom/amazonaws/mobile/client/KeyValueStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1106
    .local v0, "federationEnabledString":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 1107
    const-string/jumbo v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    .local v1, "federationEnabled":Z
    goto :goto_0

    .line 1109
    .end local v1    # "federationEnabled":Z
    :cond_0
    const/4 v1, 0x1

    .line 1111
    .restart local v1    # "federationEnabled":Z
    :goto_0
    return v1
.end method

.method isLegacyMode()Z
    .locals 1

    .line 437
    iget-boolean v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mIsLegacyMode:Z

    return v0
.end method

.method protected isNetworkAvailable(Landroid/content/Context;)Z
    .locals 4
    .param p1, "context"    # Landroid/content/Context;

    .line 771
    nop

    .line 772
    const-string v0, "android.permission.ACCESS_NETWORK_STATE"

    invoke-static {p1, v0}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    .line 774
    .local v0, "hasReadExternalStoragePermission":I
    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 775
    return v1

    .line 780
    .end local v0    # "hasReadExternalStoragePermission":I
    :cond_0
    :try_start_0
    const-string v0, "connectivity"

    .line 781
    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 782
    .local v0, "manager":Landroid/net/ConnectivityManager;
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v2

    .line 783
    .local v2, "networkInfo":Landroid/net/NetworkInfo;
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v3, :cond_1

    .line 784
    const/4 v1, 0x1

    return v1

    .line 788
    .end local v0    # "manager":Landroid/net/ConnectivityManager;
    .end local v2    # "networkInfo":Landroid/net/NetworkInfo;
    :cond_1
    goto :goto_0

    .line 786
    :catch_0
    move-exception v0

    .line 787
    .local v0, "e":Ljava/lang/Exception;
    sget-object v2, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    const-string v3, "Could not access network state"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 790
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return v1
.end method

.method public isSignedIn()Z
    .locals 4

    .line 899
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getUserStateDetails(Z)Lcom/amazonaws/mobile/client/UserStateDetails;

    move-result-object v1

    .line 900
    .local v1, "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    sget-object v2, Lcom/amazonaws/mobile/client/AWSMobileClient$27;->$SwitchMap$com$amazonaws$mobile$client$UserState:[I

    invoke-virtual {v1}, Lcom/amazonaws/mobile/client/UserStateDetails;->getUserState()Lcom/amazonaws/mobile/client/UserState;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/mobile/client/UserState;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    .line 909
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "Unknown user state, please report this exception"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 907
    :pswitch_0
    const/4 v0, 0x0

    return v0

    .line 904
    :pswitch_1
    return v0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method isSignedOutRelatedException(Ljava/lang/Exception;)Z
    .locals 4
    .param p1, "e"    # Ljava/lang/Exception;

    .line 1091
    const/4 v0, 0x0

    if-nez p1, :cond_0

    .line 1092
    return v0

    .line 1094
    :cond_0
    instance-of v1, p1, Lcom/amazonaws/services/cognitoidentity/model/NotAuthorizedException;

    const/4 v2, 0x1

    if-eqz v1, :cond_1

    .line 1095
    return v2

    .line 1097
    :cond_1
    const-string v1, "No cached session."

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {p1}, Ljava/lang/Exception;->getCause()Ljava/lang/Throwable;

    move-result-object v1

    if-nez v1, :cond_2

    .line 1098
    return v2

    .line 1100
    :cond_2
    return v0
.end method

.method isUserpoolsSignedIn()Z
    .locals 3

    .line 794
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpoolsLoginKey:Ljava/lang/String;

    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    const-string v2, "provider"

    invoke-interface {v1, v2}, Lcom/amazonaws/mobile/client/KeyValueStore;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public refresh()V
    .locals 3

    .line 381
    invoke-virtual {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isLegacyMode()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 382
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getCredentialsProvider()Lcom/amazonaws/auth/AWSCredentialsProvider;

    move-result-object v0

    invoke-interface {v0}, Lcom/amazonaws/auth/AWSCredentialsProvider;->refresh()V

    .line 383
    return-void

    .line 386
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    if-eqz v0, :cond_1

    .line 390
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-virtual {v0}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->refresh()V

    .line 391
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-virtual {v1}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->getIdentityId()Ljava/lang/String;

    move-result-object v1

    const-string v2, "cognitoIdentityId"

    invoke-interface {v0, v2, v1}, Lcom/amazonaws/mobile/client/KeyValueStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 392
    return-void

    .line 387
    :cond_1
    new-instance v0, Lcom/amazonaws/AmazonClientException;

    const-string v1, "Cognito Identity not configured"

    invoke-direct {v0, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public releaseSignInWait()V
    .locals 1

    .line 740
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mSignedOutWaitLatch:Ljava/util/concurrent/CountDownLatch;

    if-eqz v0, :cond_0

    .line 741
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mSignedOutWaitLatch:Ljava/util/concurrent/CountDownLatch;

    invoke-virtual {v0}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    .line 743
    :cond_0
    return-void
.end method

.method public removeUserStateListener(Lcom/amazonaws/mobile/client/UserStateListener;)Z
    .locals 3
    .param p1, "listener"    # Lcom/amazonaws/mobile/client/UserStateListener;

    .line 876
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->listeners:Ljava/util/List;

    monitor-enter v0

    .line 877
    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->listeners:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v1

    .line 878
    .local v1, "index":I
    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    .line 879
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->listeners:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 880
    monitor-exit v0

    const/4 v0, 0x1

    return v0

    .line 882
    :cond_0
    monitor-exit v0

    const/4 v0, 0x0

    return v0

    .line 883
    .end local v1    # "index":I
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public resendSignUp(Ljava/lang/String;)Lcom/amazonaws/mobile/client/results/SignUpResult;
    .locals 1
    .param p1, "username"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2200
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->resendSignUp(Ljava/lang/String;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/SignUpResult;

    move-result-object v0

    return-object v0
.end method

.method public resendSignUp(Ljava/lang/String;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/SignUpResult;
    .locals 2
    .param p1, "username"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/mobile/client/results/SignUpResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2214
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2215
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_resendSignUp(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/SignUpResult;

    return-object v1
.end method

.method public resendSignUp(Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 1
    .param p1, "username"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignUpResult;",
            ">;)V"
        }
    .end annotation

    .line 2169
    .local p2, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p0, p1, v0, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->resendSignUp(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V

    .line 2170
    return-void
.end method

.method public resendSignUp(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "username"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignUpResult;",
            ">;)V"
        }
    .end annotation

    .line 2187
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2188
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_resendSignUp(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 2189
    return-void
.end method

.method protected setUserState(Lcom/amazonaws/mobile/client/UserStateDetails;)V
    .locals 6
    .param p1, "details"    # Lcom/amazonaws/mobile/client/UserStateDetails;

    .line 746
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->userStateDetails:Lcom/amazonaws/mobile/client/UserStateDetails;

    invoke-virtual {p1, v0}, Lcom/amazonaws/mobile/client/UserStateDetails;->equals(Ljava/lang/Object;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    .line 747
    .local v0, "hasChanged":Z
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->userStateDetails:Lcom/amazonaws/mobile/client/UserStateDetails;

    .line 749
    if-eqz v0, :cond_1

    .line 750
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->listeners:Ljava/util/List;

    monitor-enter v1

    .line 751
    :try_start_0
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->listeners:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/amazonaws/mobile/client/UserStateListener;

    .line 752
    .local v3, "listener":Lcom/amazonaws/mobile/client/UserStateListener;
    new-instance v4, Ljava/lang/Thread;

    new-instance v5, Lcom/amazonaws/mobile/client/AWSMobileClient$4;

    invoke-direct {v5, p0, v3, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$4;-><init>(Lcom/amazonaws/mobile/client/AWSMobileClient;Lcom/amazonaws/mobile/client/UserStateListener;Lcom/amazonaws/mobile/client/UserStateDetails;)V

    invoke-direct {v4, v5}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 757
    invoke-virtual {v4}, Ljava/lang/Thread;->start()V

    .line 758
    .end local v3    # "listener":Lcom/amazonaws/mobile/client/UserStateListener;
    goto :goto_0

    .line 759
    :cond_0
    monitor-exit v1

    goto :goto_1

    :catchall_0
    move-exception v2

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .line 761
    :cond_1
    :goto_1
    return-void
.end method

.method public showSignIn(Landroid/app/Activity;)Lcom/amazonaws/mobile/client/UserStateDetails;
    .locals 2
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 3009
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 3010
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    invoke-static {}, Lcom/amazonaws/mobile/client/SignInUIOptions;->builder()Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->build()Lcom/amazonaws/mobile/client/SignInUIOptions;

    move-result-object v1

    invoke-direct {p0, p1, v1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_showSignIn(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/UserStateDetails;

    return-object v1
.end method

.method public showSignIn(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;)Lcom/amazonaws/mobile/client/UserStateDetails;
    .locals 2
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "signInUIOptions"    # Lcom/amazonaws/mobile/client/SignInUIOptions;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 3036
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 3037
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_showSignIn(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/UserStateDetails;

    return-object v1
.end method

.method public showSignIn(Landroid/app/Activity;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Activity;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;)V"
        }
    .end annotation

    .line 2998
    .local p2, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p2}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2999
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-static {}, Lcom/amazonaws/mobile/client/SignInUIOptions;->builder()Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/amazonaws/mobile/client/SignInUIOptions$Builder;->build()Lcom/amazonaws/mobile/client/SignInUIOptions;

    move-result-object v1

    invoke-direct {p0, p1, v1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_showSignIn(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 3000
    return-void
.end method

.method public showSignIn(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "signInUIOptions"    # Lcom/amazonaws/mobile/client/SignInUIOptions;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Activity;",
            "Lcom/amazonaws/mobile/client/SignInUIOptions;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/UserStateDetails;",
            ">;)V"
        }
    .end annotation

    .line 3023
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/UserStateDetails;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 3024
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_showSignIn(Landroid/app/Activity;Lcom/amazonaws/mobile/client/SignInUIOptions;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 3025
    return-void
.end method

.method public signIn(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/SignInResult;
    .locals 1
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/mobile/client/results/SignInResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1151
    .local p3, "validationData":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->signIn(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/SignInResult;

    move-result-object v0

    return-object v0
.end method

.method public signIn(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/SignInResult;
    .locals 7
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/mobile/client/results/SignInResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1160
    .local p3, "validationData":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 1161
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, v0

    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_signIn(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/SignInResult;

    return-object v1
.end method

.method public signIn(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 6
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignInResult;",
            ">;)V"
        }
    .end annotation

    .line 1133
    .local p3, "validationData":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v4

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v5, p4

    invoke-virtual/range {v0 .. v5}, Lcom/amazonaws/mobile/client/AWSMobileClient;->signIn(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V

    .line 1134
    return-void
.end method

.method public signIn(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 7
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignInResult;",
            ">;)V"
        }
    .end annotation

    .line 1143
    .local p3, "validationData":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p5, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p5}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 1144
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/SignInResult;>;"
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, v0

    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_signIn(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 1145
    return-void
.end method

.method public signOut()V
    .locals 4

    .line 1469
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mCognitoUserSession:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserSession;

    .line 1470
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpool:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;

    if-eqz v0, :cond_0

    .line 1471
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpool:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;

    invoke-virtual {v0}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;->getCurrentUser()Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;->signOut()V

    .line 1472
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->userpool:Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;

    invoke-virtual {v0}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUserPool;->getUser()Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/CognitoUser;->signOut()V

    .line 1474
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    if-eqz v0, :cond_1

    .line 1475
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->cognitoIdentity:Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-virtual {v0}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->clear()V

    .line 1477
    :cond_1
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 1478
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signOut()V

    .line 1480
    :cond_2
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mFederatedLoginsMap:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 1481
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    invoke-interface {v0}, Lcom/amazonaws/mobile/client/KeyValueStore;->clear()V

    .line 1482
    const/4 v0, 0x0

    .line 1483
    .local v0, "hostedUIJSON":Ljava/lang/String;
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    const-string v2, "Auth"

    invoke-virtual {v1, v2}, Lcom/amazonaws/mobile/config/AWSConfiguration;->optJsonObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    if-eqz v1, :cond_4

    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-virtual {v1, v2}, Lcom/amazonaws/mobile/config/AWSConfiguration;->optJsonObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    const-string v3, "OAuth"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 1485
    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-virtual {v1, v2}, Lcom/amazonaws/mobile/config/AWSConfiguration;->optJsonObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 1488
    goto :goto_0

    .line 1486
    :catch_0
    move-exception v1

    .line 1487
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    .line 1489
    .end local v1    # "e":Lorg/json/JSONException;
    :goto_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    if-eqz v1, :cond_3

    .line 1490
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->hostedUI:Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/amazonaws/mobileconnectors/cognitoauth/Auth;->signOut(Z)V

    .line 1492
    :cond_3
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mOAuth2Client:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

    if-eqz v1, :cond_4

    .line 1493
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mOAuth2Client:Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;

    invoke-virtual {v1}, Lcom/amazonaws/mobile/client/internal/oauth2/OAuth2Client;->signOut()V

    .line 1496
    :cond_4
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mStore:Lcom/amazonaws/mobile/client/KeyValueStore;

    const-string v2, "hostedUI"

    invoke-interface {v1, v2, v0}, Lcom/amazonaws/mobile/client/KeyValueStore;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 1497
    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getUserStateDetails(Z)Lcom/amazonaws/mobile/client/UserStateDetails;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->setUserState(Lcom/amazonaws/mobile/client/UserStateDetails;)V

    .line 1498
    invoke-virtual {p0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->releaseSignInWait()V

    .line 1499
    return-void
.end method

.method public signOut(Lcom/amazonaws/mobile/client/SignOutOptions;)V
    .locals 1
    .param p1, "signOutOptions"    # Lcom/amazonaws/mobile/client/SignOutOptions;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1514
    invoke-direct {p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_signOut(Lcom/amazonaws/mobile/client/SignOutOptions;)Lcom/amazonaws/mobile/client/internal/ReturningRunnable;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/internal/ReturningRunnable;->await()Ljava/lang/Object;

    .line 1515
    return-void
.end method

.method public signOut(Lcom/amazonaws/mobile/client/SignOutOptions;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 1
    .param p1, "signOutOptions"    # Lcom/amazonaws/mobile/client/SignOutOptions;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/mobile/client/SignOutOptions;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Ljava/lang/Void;",
            ">;)V"
        }
    .end annotation

    .line 1530
    .local p2, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Ljava/lang/Void;>;"
    invoke-direct {p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_signOut(Lcom/amazonaws/mobile/client/SignOutOptions;)Lcom/amazonaws/mobile/client/internal/ReturningRunnable;

    move-result-object v0

    invoke-virtual {v0, p2}, Lcom/amazonaws/mobile/client/internal/ReturningRunnable;->async(Lcom/amazonaws/mobile/client/Callback;)V

    .line 1531
    return-void
.end method

.method public signUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/SignUpResult;
    .locals 8
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/mobile/client/results/SignUpResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2000
    .local p3, "userAttributes":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "validationData":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2001
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    nop

    .line 2002
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v6

    .line 2001
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v7, v0

    invoke-direct/range {v1 .. v7}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_signUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/SignUpResult;

    return-object v1
.end method

.method public signUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/SignUpResult;
    .locals 8
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/mobile/client/results/SignUpResult;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 1954
    .local p3, "userAttributes":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p5, "validationData":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 1955
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p5

    move-object v6, p4

    move-object v7, v0

    invoke-direct/range {v1 .. v7}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_signUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/SignUpResult;

    return-object v1
.end method

.method public signUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 8
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignUpResult;",
            ">;)V"
        }
    .end annotation

    .line 1978
    .local p3, "userAttributes":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "validationData":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p5, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p5}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 1979
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    nop

    .line 1980
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v6

    .line 1979
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v7, v0

    invoke-direct/range {v1 .. v7}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_signUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 1981
    return-void
.end method

.method public signUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 8
    .param p1, "username"    # Ljava/lang/String;
    .param p2, "password"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/SignUpResult;",
            ">;)V"
        }
    .end annotation

    .line 1930
    .local p3, "userAttributes":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "validationData":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p5, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p6, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/SignUpResult;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p6}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 1931
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    move-object v7, v0

    invoke-direct/range {v1 .. v7}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_signUp(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 1933
    return-void
.end method

.method public updateUserAttributes(Ljava/util/Map;)Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/List<",
            "Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2561
    .local p1, "userAttributes":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->updateUserAttributes(Ljava/util/Map;Ljava/util/Map;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public updateUserAttributes(Ljava/util/Map;Ljava/util/Map;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/List<",
            "Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2578
    .local p1, "userAttributes":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2579
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Ljava/util/List<Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;>;>;"
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_updateUserAttributes(Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    return-object v1
.end method

.method public updateUserAttributes(Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Ljava/util/List<",
            "Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;",
            ">;>;)V"
        }
    .end annotation

    .line 2530
    .local p1, "userAttributes":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p2, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Ljava/util/List<Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;>;>;"
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p0, p1, v0, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->updateUserAttributes(Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V

    .line 2531
    return-void
.end method

.method public updateUserAttributes(Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Ljava/util/List<",
            "Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;",
            ">;>;)V"
        }
    .end annotation

    .line 2547
    .local p1, "userAttributes":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Ljava/util/List<Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;>;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2548
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_updateUserAttributes(Ljava/util/Map;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 2549
    return-void
.end method

.method public verifyUserAttribute(Ljava/lang/String;)Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;
    .locals 1
    .param p1, "attributeName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2664
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->verifyUserAttribute(Ljava/lang/String;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;

    move-result-object v0

    return-object v0
.end method

.method public verifyUserAttribute(Ljava/lang/String;Ljava/util/Map;)Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;
    .locals 2
    .param p1, "attributeName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 2679
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>()V

    .line 2680
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;, "Lcom/amazonaws/mobile/client/internal/InternalCallback<Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;>;"
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_verifyUserAttribute(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->await(Ljava/lang/Runnable;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;

    return-object v1
.end method

.method public verifyUserAttribute(Ljava/lang/String;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 1
    .param p1, "attributeName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;",
            ">;)V"
        }
    .end annotation

    .line 2637
    .local p2, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;>;"
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p0, p1, v0, p2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->verifyUserAttribute(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V

    .line 2638
    return-void
.end method

.method public verifyUserAttribute(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)V
    .locals 2
    .param p1, "attributeName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/amazonaws/mobile/client/Callback<",
            "Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;",
            ">;)V"
        }
    .end annotation

    .line 2652
    .local p2, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "callback":Lcom/amazonaws/mobile/client/Callback;, "Lcom/amazonaws/mobile/client/Callback<Lcom/amazonaws/mobile/client/results/UserCodeDeliveryDetails;>;"
    new-instance v0, Lcom/amazonaws/mobile/client/internal/InternalCallback;

    invoke-direct {v0, p3}, Lcom/amazonaws/mobile/client/internal/InternalCallback;-><init>(Lcom/amazonaws/mobile/client/Callback;)V

    .line 2653
    .local v0, "internalCallback":Lcom/amazonaws/mobile/client/internal/InternalCallback;
    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->_verifyUserAttribute(Ljava/lang/String;Ljava/util/Map;Lcom/amazonaws/mobile/client/Callback;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/client/internal/InternalCallback;->async(Ljava/lang/Runnable;)V

    .line 2654
    return-void
.end method

.method protected waitForSignIn()Z
    .locals 6

    .line 921
    const/4 v0, 0x0

    .line 923
    .local v0, "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mWaitForSignInLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->lock()V

    .line 924
    new-instance v1, Ljava/util/concurrent/CountDownLatch;

    const/4 v2, 0x1

    invoke-direct {v1, v2}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    iput-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mSignedOutWaitLatch:Ljava/util/concurrent/CountDownLatch;

    .line 925
    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getUserStateDetails(Z)Lcom/amazonaws/mobile/client/UserStateDetails;

    move-result-object v3

    move-object v0, v3

    .line 926
    sget-object v3, Lcom/amazonaws/mobile/client/AWSMobileClient;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "waitForSignIn: userState:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/UserStateDetails;->getUserState()Lcom/amazonaws/mobile/client/UserState;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 927
    sget-object v3, Lcom/amazonaws/mobile/client/AWSMobileClient$27;->$SwitchMap$com$amazonaws$mobile$client$UserState:[I

    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/UserStateDetails;->getUserState()Lcom/amazonaws/mobile/client/UserState;

    move-result-object v4

    invoke-virtual {v4}, Lcom/amazonaws/mobile/client/UserState;->ordinal()I

    move-result v4

    aget v3, v3, v4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    packed-switch v3, :pswitch_data_0

    .line 953
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mWaitForSignInLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 954
    goto :goto_1

    .line 933
    :pswitch_0
    :try_start_1
    invoke-virtual {p0, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->setUserState(Lcom/amazonaws/mobile/client/UserStateDetails;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 934
    nop

    .line 953
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mWaitForSignInLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 934
    return v1

    .line 937
    :pswitch_1
    :try_start_2
    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/UserStateDetails;->getException()Ljava/lang/Exception;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 938
    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/UserStateDetails;->getException()Ljava/lang/Exception;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/amazonaws/mobile/client/AWSMobileClient;->isSignedOutRelatedException(Ljava/lang/Exception;)Z

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_0

    .line 947
    :cond_0
    invoke-virtual {v0}, Lcom/amazonaws/mobile/client/UserStateDetails;->getException()Ljava/lang/Exception;

    move-result-object v1

    .end local v0    # "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    throw v1

    .line 941
    .restart local v0    # "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    :cond_1
    :goto_0
    invoke-virtual {p0, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->setUserState(Lcom/amazonaws/mobile/client/UserStateDetails;)V

    .line 942
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mSignedOutWaitLatch:Ljava/util/concurrent/CountDownLatch;

    invoke-virtual {v2}, Ljava/util/concurrent/CountDownLatch;->await()V

    .line 943
    invoke-virtual {p0, v1}, Lcom/amazonaws/mobile/client/AWSMobileClient;->getUserStateDetails(Z)Lcom/amazonaws/mobile/client/UserStateDetails;

    move-result-object v1

    invoke-virtual {v1}, Lcom/amazonaws/mobile/client/UserStateDetails;->getUserState()Lcom/amazonaws/mobile/client/UserState;

    move-result-object v1

    sget-object v2, Lcom/amazonaws/mobile/client/UserState;->SIGNED_IN:Lcom/amazonaws/mobile/client/UserState;

    invoke-virtual {v1, v2}, Lcom/amazonaws/mobile/client/UserState;->equals(Ljava/lang/Object;)Z

    move-result v1
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 953
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mWaitForSignInLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 943
    return v1

    .line 929
    :pswitch_2
    :try_start_3
    invoke-virtual {p0, v0}, Lcom/amazonaws/mobile/client/AWSMobileClient;->setUserState(Lcom/amazonaws/mobile/client/UserStateDetails;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 930
    nop

    .line 953
    iget-object v1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mWaitForSignInLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 930
    return v2

    .line 955
    :goto_1
    return v1

    .line 953
    :catchall_0
    move-exception v1

    goto :goto_2

    .line 950
    :catch_0
    move-exception v1

    .line 951
    .local v1, "e":Ljava/lang/Exception;
    :try_start_4
    new-instance v2, Lcom/amazonaws/AmazonClientException;

    const-string v3, "Operation requires a signed-in state"

    invoke-direct {v2, v3, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .end local v0    # "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    throw v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 953
    .end local v1    # "e":Ljava/lang/Exception;
    .restart local v0    # "userStateDetails":Lcom/amazonaws/mobile/client/UserStateDetails;
    :goto_2
    iget-object v2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient;->mWaitForSignInLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 954
    throw v1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method
