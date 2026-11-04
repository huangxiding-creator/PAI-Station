.class public Lcom/amazonaws/mobile/auth/core/IdentityManager;
.super Ljava/lang/Object;
.source "IdentityManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;,
        Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSRefreshingCognitoIdentityProvider;,
        Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;
    }
.end annotation


# static fields
.field private static final AWS_CONFIGURATION_FILE:Ljava/lang/String; = "awsconfiguration.json"

.field private static final EXPIRATION_KEY:Ljava/lang/String; = "expirationDate"

.field private static final LOG_TAG:Ljava/lang/String;

.field private static final SHARED_PREF_NAME:Ljava/lang/String; = "com.amazonaws.android.auth"

.field private static defaultIdentityManager:Lcom/amazonaws/mobile/auth/core/IdentityManager;


# instance fields
.field private final appContext:Landroid/content/Context;

.field private awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

.field private awsKeyValueStore:Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;

.field private final clientConfiguration:Lcom/amazonaws/ClientConfiguration;

.field private final credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

.field private volatile currentIdentityProvider:Lcom/amazonaws/mobile/auth/core/IdentityProvider;

.field private final executorService:Ljava/util/concurrent/ExecutorService;

.field private isPersistenceEnabled:Z

.field private resultsAdapter:Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;

.field shouldFederate:Z

.field private final signInProviderClasses:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/Class<",
            "+",
            "Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;",
            ">;>;"
        }
    .end annotation
.end field

.field private final signInStateChangeListeners:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet<",
            "Lcom/amazonaws/mobile/auth/core/SignInStateChangeListener;",
            ">;"
        }
    .end annotation
.end field

.field private final startupAuthTimeoutLatch:Ljava/util/concurrent/CountDownLatch;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 100
    const-class v0, Lcom/amazonaws/mobile/auth/core/IdentityManager;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->LOG_TAG:Ljava/lang/String;

    .line 137
    const/4 v0, 0x0

    sput-object v0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->defaultIdentityManager:Lcom/amazonaws/mobile/auth/core/IdentityManager;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;

    .line 201
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 118
    const/4 v0, 0x4

    invoke-static {v0}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->executorService:Ljava/util/concurrent/ExecutorService;

    .line 121
    new-instance v0, Ljava/util/concurrent/CountDownLatch;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->startupAuthTimeoutLatch:Ljava/util/concurrent/CountDownLatch;

    .line 124
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInProviderClasses:Ljava/util/Set;

    .line 127
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->currentIdentityProvider:Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    .line 133
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    iput-object v2, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInStateChangeListeners:Ljava/util/HashSet;

    .line 162
    iput-boolean v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->isPersistenceEnabled:Z

    .line 164
    iput-boolean v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->shouldFederate:Z

    .line 202
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    iput-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->appContext:Landroid/content/Context;

    .line 203
    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 204
    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->clientConfiguration:Lcom/amazonaws/ClientConfiguration;

    .line 205
    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    .line 206
    new-instance v0, Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;

    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->appContext:Landroid/content/Context;

    const-string v2, "com.amazonaws.android.auth"

    iget-boolean v3, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->isPersistenceEnabled:Z

    invoke-direct {v0, v1, v2, v3}, Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;-><init>(Landroid/content/Context;Ljava/lang/String;Z)V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsKeyValueStore:Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;

    .line 207
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "credentialsProvider"    # Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;
    .param p3, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;

    .line 267
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 118
    const/4 v0, 0x4

    invoke-static {v0}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->executorService:Ljava/util/concurrent/ExecutorService;

    .line 121
    new-instance v0, Ljava/util/concurrent/CountDownLatch;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->startupAuthTimeoutLatch:Ljava/util/concurrent/CountDownLatch;

    .line 124
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInProviderClasses:Ljava/util/Set;

    .line 127
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->currentIdentityProvider:Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    .line 133
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    iput-object v2, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInStateChangeListeners:Ljava/util/HashSet;

    .line 162
    iput-boolean v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->isPersistenceEnabled:Z

    .line 164
    iput-boolean v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->shouldFederate:Z

    .line 268
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    iput-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->appContext:Landroid/content/Context;

    .line 269
    iput-object p3, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->clientConfiguration:Lcom/amazonaws/ClientConfiguration;

    .line 270
    new-instance v1, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    invoke-direct {v1, p0, v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Lcom/amazonaws/mobile/auth/core/IdentityManager$1;)V

    iput-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    .line 271
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    invoke-static {v0, p2}, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;->access$200(Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;)V

    .line 272
    new-instance v0, Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;

    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->appContext:Landroid/content/Context;

    const-string v2, "com.amazonaws.android.auth"

    iget-boolean v3, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->isPersistenceEnabled:Z

    invoke-direct {v0, v1, v2, v3}, Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;-><init>(Landroid/content/Context;Ljava/lang/String;Z)V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsKeyValueStore:Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;

    .line 273
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/amazonaws/mobile/config/AWSConfiguration;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "awsConfiguration"    # Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 218
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 118
    const/4 v0, 0x4

    invoke-static {v0}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->executorService:Ljava/util/concurrent/ExecutorService;

    .line 121
    new-instance v0, Ljava/util/concurrent/CountDownLatch;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->startupAuthTimeoutLatch:Ljava/util/concurrent/CountDownLatch;

    .line 124
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInProviderClasses:Ljava/util/Set;

    .line 127
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->currentIdentityProvider:Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    .line 133
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    iput-object v2, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInStateChangeListeners:Ljava/util/HashSet;

    .line 162
    iput-boolean v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->isPersistenceEnabled:Z

    .line 164
    iput-boolean v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->shouldFederate:Z

    .line 219
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    iput-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->appContext:Landroid/content/Context;

    .line 220
    iput-object p2, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 221
    new-instance v1, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v1}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    .line 222
    invoke-virtual {p2}, Lcom/amazonaws/mobile/config/AWSConfiguration;->getUserAgent()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/amazonaws/ClientConfiguration;->withUserAgent(Ljava/lang/String;)Lcom/amazonaws/ClientConfiguration;

    move-result-object v1

    .line 223
    invoke-virtual {p2}, Lcom/amazonaws/mobile/config/AWSConfiguration;->getUserAgentOverride()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/amazonaws/ClientConfiguration;->withUserAgentOverride(Ljava/lang/String;)Lcom/amazonaws/ClientConfiguration;

    move-result-object v1

    iput-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->clientConfiguration:Lcom/amazonaws/ClientConfiguration;

    .line 224
    new-instance v1, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    invoke-direct {v1, p0, v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Lcom/amazonaws/mobile/auth/core/IdentityManager$1;)V

    iput-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    .line 225
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->appContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->clientConfiguration:Lcom/amazonaws/ClientConfiguration;

    invoke-direct {p0, v0, v1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->createCredentialsProvider(Landroid/content/Context;Lcom/amazonaws/ClientConfiguration;)V

    .line 226
    new-instance v0, Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;

    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->appContext:Landroid/content/Context;

    const-string v2, "com.amazonaws.android.auth"

    iget-boolean v3, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->isPersistenceEnabled:Z

    invoke-direct {v0, v1, v2, v3}, Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;-><init>(Landroid/content/Context;Ljava/lang/String;Z)V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsKeyValueStore:Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;

    .line 227
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/amazonaws/mobile/config/AWSConfiguration;Lcom/amazonaws/ClientConfiguration;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "awsConfiguration"    # Lcom/amazonaws/mobile/config/AWSConfiguration;
    .param p3, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;

    .line 241
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 118
    const/4 v0, 0x4

    invoke-static {v0}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->executorService:Ljava/util/concurrent/ExecutorService;

    .line 121
    new-instance v0, Ljava/util/concurrent/CountDownLatch;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->startupAuthTimeoutLatch:Ljava/util/concurrent/CountDownLatch;

    .line 124
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInProviderClasses:Ljava/util/Set;

    .line 127
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->currentIdentityProvider:Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    .line 133
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    iput-object v2, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInStateChangeListeners:Ljava/util/HashSet;

    .line 162
    iput-boolean v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->isPersistenceEnabled:Z

    .line 164
    iput-boolean v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->shouldFederate:Z

    .line 242
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    iput-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->appContext:Landroid/content/Context;

    .line 243
    iput-object p2, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 244
    iput-object p3, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->clientConfiguration:Lcom/amazonaws/ClientConfiguration;

    .line 246
    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    invoke-virtual {v1}, Lcom/amazonaws/mobile/config/AWSConfiguration;->getUserAgent()Ljava/lang/String;

    move-result-object v1

    .line 247
    .local v1, "userAgent":Ljava/lang/String;
    iget-object v2, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->clientConfiguration:Lcom/amazonaws/ClientConfiguration;

    invoke-virtual {v2}, Lcom/amazonaws/ClientConfiguration;->getUserAgent()Ljava/lang/String;

    move-result-object v2

    .line 248
    .local v2, "currentUserAgent":Ljava/lang/String;
    if-eqz v2, :cond_0

    move-object v3, v2

    goto :goto_0

    :cond_0
    const-string v3, ""

    :goto_0
    move-object v2, v3

    .line 250
    if-eqz v1, :cond_1

    if-eq v1, v2, :cond_1

    .line 251
    iget-object v3, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->clientConfiguration:Lcom/amazonaws/ClientConfiguration;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/ClientConfiguration;->setUserAgent(Ljava/lang/String;)V

    .line 254
    :cond_1
    new-instance v3, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    invoke-direct {v3, p0, v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Lcom/amazonaws/mobile/auth/core/IdentityManager$1;)V

    iput-object v3, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    .line 255
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->appContext:Landroid/content/Context;

    iget-object v3, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->clientConfiguration:Lcom/amazonaws/ClientConfiguration;

    invoke-direct {p0, v0, v3}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->createCredentialsProvider(Landroid/content/Context;Lcom/amazonaws/ClientConfiguration;)V

    .line 256
    new-instance v0, Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;

    iget-object v3, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->appContext:Landroid/content/Context;

    const-string v4, "com.amazonaws.android.auth"

    iget-boolean v5, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->isPersistenceEnabled:Z

    invoke-direct {v0, v3, v4, v5}, Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;-><init>(Landroid/content/Context;Ljava/lang/String;Z)V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsKeyValueStore:Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;

    .line 257
    return-void
.end method

.method static synthetic access$000(Lcom/amazonaws/mobile/auth/core/IdentityManager;)Lcom/amazonaws/mobile/auth/core/IdentityProvider;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/auth/core/IdentityManager;

    .line 71
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->currentIdentityProvider:Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    return-object v0
.end method

.method static synthetic access$002(Lcom/amazonaws/mobile/auth/core/IdentityManager;Lcom/amazonaws/mobile/auth/core/IdentityProvider;)Lcom/amazonaws/mobile/auth/core/IdentityProvider;
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/auth/core/IdentityManager;
    .param p1, "x1"    # Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    .line 71
    iput-object p1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->currentIdentityProvider:Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    return-object p1
.end method

.method static synthetic access$1200(Lcom/amazonaws/mobile/auth/core/IdentityManager;)Ljava/util/concurrent/CountDownLatch;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/auth/core/IdentityManager;

    .line 71
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->startupAuthTimeoutLatch:Ljava/util/concurrent/CountDownLatch;

    return-object v0
.end method

.method static synthetic access$1300(Lcom/amazonaws/mobile/auth/core/IdentityManager;Landroid/app/Activity;Ljava/lang/Runnable;)V
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/auth/core/IdentityManager;
    .param p1, "x1"    # Landroid/app/Activity;
    .param p2, "x2"    # Ljava/lang/Runnable;

    .line 71
    invoke-direct {p0, p1, p2}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->runAfterStartupAuthDelay(Landroid/app/Activity;Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic access$1400(Lcom/amazonaws/mobile/auth/core/IdentityManager;Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;Lcom/amazonaws/mobile/auth/core/signin/AuthException;)V
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/auth/core/IdentityManager;
    .param p1, "x1"    # Landroid/app/Activity;
    .param p2, "x2"    # Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;
    .param p3, "x3"    # Lcom/amazonaws/mobile/auth/core/signin/AuthException;

    .line 71
    invoke-direct {p0, p1, p2, p3}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->completeHandler(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;Lcom/amazonaws/mobile/auth/core/signin/AuthException;)V

    return-void
.end method

.method static synthetic access$400(Lcom/amazonaws/mobile/auth/core/IdentityManager;)Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/auth/core/IdentityManager;

    .line 71
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    return-object v0
.end method

.method static synthetic access$500()Ljava/lang/String;
    .locals 1

    .line 71
    sget-object v0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->LOG_TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$600(Lcom/amazonaws/mobile/auth/core/IdentityManager;)Ljava/util/HashSet;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/auth/core/IdentityManager;

    .line 71
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInStateChangeListeners:Ljava/util/HashSet;

    return-object v0
.end method

.method static synthetic access$800(Lcom/amazonaws/mobile/auth/core/IdentityManager;Ljava/util/Map;)V
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/auth/core/IdentityManager;
    .param p1, "x1"    # Ljava/util/Map;

    .line 71
    invoke-direct {p0, p1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->refreshCredentialWithLogins(Ljava/util/Map;)V

    return-void
.end method

.method static synthetic access$900(Lcom/amazonaws/mobile/auth/core/IdentityManager;)Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobile/auth/core/IdentityManager;

    .line 71
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->resultsAdapter:Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;

    return-object v0
.end method

.method private completeHandler(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;Lcom/amazonaws/mobile/auth/core/signin/AuthException;)V
    .locals 1
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "startupAuthResultHandler"    # Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;
    .param p3, "ex"    # Lcom/amazonaws/mobile/auth/core/signin/AuthException;

    .line 677
    new-instance v0, Lcom/amazonaws/mobile/auth/core/IdentityManager$4;

    invoke-direct {v0, p0, p2, p3}, Lcom/amazonaws/mobile/auth/core/IdentityManager$4;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;Lcom/amazonaws/mobile/auth/core/signin/AuthException;)V

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->runAfterStartupAuthDelay(Landroid/app/Activity;Ljava/lang/Runnable;)V

    .line 684
    return-void
.end method

.method private createCredentialsProvider(Landroid/content/Context;Lcom/amazonaws/ClientConfiguration;)V
    .locals 10
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;

    .line 905
    sget-object v0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->LOG_TAG:Ljava/lang/String;

    const-string v1, "Creating the Cognito Caching Credentials Provider with a refreshing Cognito Identity Provider."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 908
    iget-boolean v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->shouldFederate:Z

    if-nez v0, :cond_0

    .line 909
    return-void

    .line 912
    :cond_0
    invoke-direct {p0}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getCognitoIdentityPoolConfig()Lorg/json/JSONObject;

    move-result-object v0

    .line 916
    .local v0, "cognitoIdentityConfig":Lorg/json/JSONObject;
    :try_start_0
    const-string v1, "Region"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 917
    .local v1, "region":Ljava/lang/String;
    const-string v2, "PoolId"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 920
    .local v6, "poolId":Ljava/lang/String;
    nop

    .line 922
    invoke-static {v1}, Lcom/amazonaws/regions/Regions;->fromName(Ljava/lang/String;)Lcom/amazonaws/regions/Regions;

    move-result-object v2

    .line 924
    .local v2, "cognitoIdentityRegion":Lcom/amazonaws/regions/Regions;
    new-instance v9, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSRefreshingCognitoIdentityProvider;

    const/4 v5, 0x0

    move-object v3, v9

    move-object v4, p0

    move-object v7, p2

    move-object v8, v2

    invoke-direct/range {v3 .. v8}, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSRefreshingCognitoIdentityProvider;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/regions/Regions;)V

    .line 928
    .local v3, "refreshingCredentialsProvider":Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSRefreshingCognitoIdentityProvider;
    new-instance v4, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    invoke-direct {v4, p1, v3, v2, p2}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;-><init>(Landroid/content/Context;Lcom/amazonaws/auth/AWSCognitoIdentityProvider;Lcom/amazonaws/regions/Regions;Lcom/amazonaws/ClientConfiguration;)V

    .line 934
    .local v4, "cognitoCachingCredentialsProvider":Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;
    iget-boolean v5, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->isPersistenceEnabled:Z

    invoke-virtual {v4, v5}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->setPersistenceEnabled(Z)V

    .line 935
    invoke-virtual {p2}, Lcom/amazonaws/ClientConfiguration;->getUserAgentOverride()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_1

    .line 936
    invoke-virtual {p2}, Lcom/amazonaws/ClientConfiguration;->getUserAgentOverride()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->setUserAgentOverride(Ljava/lang/String;)V

    .line 938
    :cond_1
    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    invoke-static {v5, v4}, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;->access$200(Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;)V

    .line 939
    return-void

    .line 918
    .end local v1    # "region":Ljava/lang/String;
    .end local v2    # "cognitoIdentityRegion":Lcom/amazonaws/regions/Regions;
    .end local v3    # "refreshingCredentialsProvider":Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSRefreshingCognitoIdentityProvider;
    .end local v4    # "cognitoCachingCredentialsProvider":Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;
    .end local v6    # "poolId":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 919
    .local v1, "e":Lorg/json/JSONException;
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "Failed to read configuration for CognitoIdentity"

    invoke-direct {v2, v3, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2
.end method

.method private getCognitoIdentityPoolConfig()Lorg/json/JSONObject;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 949
    :try_start_0
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    const-string v1, "CredentialsProvider"

    .line 950
    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/config/AWSConfiguration;->optJsonObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v1, "CognitoIdentity"

    .line 951
    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 952
    invoke-virtual {v1}, Lcom/amazonaws/mobile/config/AWSConfiguration;->getConfiguration()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 949
    return-object v0

    .line 953
    :catch_0
    move-exception v0

    .line 954
    .local v0, "exception":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Cannot access Cognito IdentityPoolId from the awsconfiguration.json file."

    invoke-direct {v1, v2, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public static getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;
    .locals 1

    .line 300
    sget-object v0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->defaultIdentityManager:Lcom/amazonaws/mobile/auth/core/IdentityManager;

    return-object v0
.end method

.method private refreshCredentialWithLogins(Ljava/util/Map;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 557
    .local p1, "loginMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    .line 558
    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;->access$300(Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;)Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    move-result-object v0

    .line 560
    .local v0, "credentialsProvider":Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;
    iget-boolean v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->shouldFederate:Z

    if-nez v1, :cond_0

    .line 561
    return-void

    .line 564
    :cond_0
    invoke-virtual {v0}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->clear()V

    .line 565
    invoke-virtual {v0, p1}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->withLogins(Ljava/util/Map;)Lcom/amazonaws/auth/AWSCredentialsProvider;

    .line 568
    sget-object v1, Lcom/amazonaws/mobile/auth/core/IdentityManager;->LOG_TAG:Ljava/lang/String;

    const-string v2, "refresh credentials"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 569
    invoke-virtual {v0}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->refresh()V

    .line 572
    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsKeyValueStore:Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "expirationDate"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 573
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    const-wide/32 v5, 0x7c830

    add-long/2addr v3, v5

    invoke-static {v3, v4}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v3

    .line 572
    invoke-virtual {v1, v2, v3}, Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 574
    return-void
.end method

.method private runAfterStartupAuthDelay(Landroid/app/Activity;Ljava/lang/Runnable;)V
    .locals 2
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "runnable"    # Ljava/lang/Runnable;

    .line 695
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->executorService:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/amazonaws/mobile/auth/core/IdentityManager$5;

    invoke-direct {v1, p0, p1, p2}, Lcom/amazonaws/mobile/auth/core/IdentityManager$5;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Landroid/app/Activity;Ljava/lang/Runnable;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    .line 708
    return-void
.end method

.method public static setDefaultIdentityManager(Lcom/amazonaws/mobile/auth/core/IdentityManager;)V
    .locals 1
    .param p0, "identityManager"    # Lcom/amazonaws/mobile/auth/core/IdentityManager;

    .line 309
    const/4 v0, 0x0

    sput-object v0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->defaultIdentityManager:Lcom/amazonaws/mobile/auth/core/IdentityManager;

    .line 310
    sput-object p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->defaultIdentityManager:Lcom/amazonaws/mobile/auth/core/IdentityManager;

    .line 311
    return-void
.end method


# virtual methods
.method public addSignInProvider(Ljava/lang/Class;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "+",
            "Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;",
            ">;)V"
        }
    .end annotation

    .line 642
    .local p1, "providerClass":Ljava/lang/Class;, "Ljava/lang/Class<+Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;>;"
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInProviderClasses:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 643
    return-void
.end method

.method public addSignInStateChangeListener(Lcom/amazonaws/mobile/auth/core/SignInStateChangeListener;)V
    .locals 2
    .param p1, "listener"    # Lcom/amazonaws/mobile/auth/core/SignInStateChangeListener;

    .line 492
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInStateChangeListeners:Ljava/util/HashSet;

    monitor-enter v0

    .line 493
    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInStateChangeListeners:Ljava/util/HashSet;

    invoke-virtual {v1, p1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 494
    monitor-exit v0

    .line 495
    return-void

    .line 494
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public areCredentialsExpired()Z
    .locals 8

    .line 337
    iget-boolean v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->shouldFederate:Z

    if-eqz v0, :cond_3

    .line 341
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    .line 342
    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;->access$300(Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;)Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->getSessionCredentialsExpiration()Ljava/util/Date;

    move-result-object v0

    .line 344
    .local v0, "credentialsExpirationDate":Ljava/util/Date;
    const/4 v1, 0x1

    if-nez v0, :cond_0

    .line 345
    sget-object v2, Lcom/amazonaws/mobile/auth/core/IdentityManager;->LOG_TAG:Ljava/lang/String;

    const-string v3, "Credentials are EXPIRED."

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 346
    return v1

    .line 349
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 350
    invoke-static {}, Lcom/amazonaws/SDKGlobalConfiguration;->getGlobalTimeOffset()I

    move-result v4

    mul-int/lit16 v4, v4, 0x3e8

    int-to-long v4, v4

    sub-long/2addr v2, v4

    .line 352
    .local v2, "currentTime":J
    nop

    .line 353
    invoke-virtual {v0}, Ljava/util/Date;->getTime()J

    move-result-wide v4

    sub-long/2addr v4, v2

    const-wide/16 v6, 0x0

    cmp-long v4, v4, v6

    if-gez v4, :cond_1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    .line 355
    .local v1, "credsAreExpired":Z
    :goto_0
    sget-object v4, Lcom/amazonaws/mobile/auth/core/IdentityManager;->LOG_TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Credentials are "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    if-eqz v1, :cond_2

    const-string v6, "EXPIRED."

    goto :goto_1

    :cond_2
    const-string v6, "OK"

    :goto_1
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 357
    return v1

    .line 338
    .end local v0    # "credentialsExpirationDate":Ljava/util/Date;
    .end local v1    # "credsAreExpired":Z
    .end local v2    # "currentTime":J
    :cond_3
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Federation is not enabled and does not support credentials"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public doStartupAuth(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;)V
    .locals 2
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "startupAuthResultHandler"    # Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 832
    const-wide/16 v0, 0x0

    invoke-virtual {p0, p1, p2, v0, v1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->resumeSession(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;J)V

    .line 833
    return-void
.end method

.method public doStartupAuth(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;J)V
    .locals 0
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "startupAuthResultHandler"    # Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;
    .param p3, "minimumDelay"    # J
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 850
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->resumeSession(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;J)V

    .line 851
    return-void
.end method

.method public enableFederation(Z)V
    .locals 0
    .param p1, "enabled"    # Z

    .line 291
    iput-boolean p1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->shouldFederate:Z

    .line 292
    return-void
.end method

.method public expireSignInTimeout()V
    .locals 1

    .line 857
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->startupAuthTimeoutLatch:Ljava/util/concurrent/CountDownLatch;

    invoke-virtual {v0}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    .line 858
    return-void
.end method

.method public federateWithProvider(Lcom/amazonaws/mobile/auth/core/IdentityProvider;)V
    .locals 3
    .param p1, "provider"    # Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    .line 597
    sget-object v0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->LOG_TAG:Ljava/lang/String;

    const-string v1, "federate with provider: Populate loginsMap with token."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 598
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 599
    .local v0, "loginMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-interface {p1}, Lcom/amazonaws/mobile/auth/core/IdentityProvider;->getCognitoLoginKey()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1}, Lcom/amazonaws/mobile/auth/core/IdentityProvider;->getToken()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 600
    iput-object p1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->currentIdentityProvider:Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    .line 602
    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->executorService:Ljava/util/concurrent/ExecutorService;

    new-instance v2, Lcom/amazonaws/mobile/auth/core/IdentityManager$3;

    invoke-direct {v2, p0, v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager$3;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Ljava/util/Map;)V

    invoke-interface {v1, v2}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    .line 624
    return-void
.end method

.method public getCachedUserID()Ljava/lang/String;
    .locals 2

    .line 384
    iget-boolean v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->shouldFederate:Z

    if-eqz v0, :cond_0

    .line 387
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;->access$300(Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;)Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->getCachedIdentityId()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 385
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Federation is not enabled and does not support user id"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getConfiguration()Lcom/amazonaws/mobile/config/AWSConfiguration;
    .locals 1

    .line 319
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    return-object v0
.end method

.method public getCredentialsProvider()Lcom/amazonaws/auth/AWSCredentialsProvider;
    .locals 1

    .line 366
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    return-object v0
.end method

.method public getCurrentIdentityProvider()Lcom/amazonaws/mobile/auth/core/IdentityProvider;
    .locals 1

    .line 632
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->currentIdentityProvider:Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    return-object v0
.end method

.method public getResultsAdapter()Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;
    .locals 1

    .line 515
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->resultsAdapter:Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;

    return-object v0
.end method

.method public getSignInProviderClasses()Ljava/util/Collection;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Collection<",
            "Ljava/lang/Class<",
            "+",
            "Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;",
            ">;>;"
        }
    .end annotation

    .line 651
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInProviderClasses:Ljava/util/Set;

    return-object v0
.end method

.method public getUnderlyingProvider()Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;
    .locals 1

    .line 375
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;->access$300(Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;)Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    move-result-object v0

    return-object v0
.end method

.method public getUserID(Lcom/amazonaws/mobile/auth/core/IdentityHandler;)V
    .locals 2
    .param p1, "handler"    # Lcom/amazonaws/mobile/auth/core/IdentityHandler;

    .line 397
    iget-boolean v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->shouldFederate:Z

    if-eqz v0, :cond_0

    .line 401
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->executorService:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/amazonaws/mobile/auth/core/IdentityManager$1;

    invoke-direct {v1, p0, p1}, Lcom/amazonaws/mobile/auth/core/IdentityManager$1;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Lcom/amazonaws/mobile/auth/core/IdentityHandler;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    .line 433
    return-void

    .line 398
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Federation is not enabled and does not support user id"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public isUserSignedIn()Z
    .locals 2

    .line 660
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->credentialsProviderHolder:Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;

    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;->access$300(Lcom/amazonaws/mobile/auth/core/IdentityManager$AWSCredentialsProviderHolder;)Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/auth/CognitoCachingCredentialsProvider;->getLogins()Ljava/util/Map;

    move-result-object v0

    .line 661
    .local v0, "logins":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 663
    :cond_0
    const/4 v1, 0x1

    return v1

    .line 662
    :cond_1
    :goto_0
    const/4 v1, 0x0

    return v1
.end method

.method public login(Landroid/content/Context;Lcom/amazonaws/mobile/auth/core/SignInResultHandler;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "signInResultHandler"    # Lcom/amazonaws/mobile/auth/core/SignInResultHandler;

    .line 888
    nop

    .line 889
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->getInstance(Landroid/content/Context;)Lcom/amazonaws/mobile/auth/core/signin/SignInManager;

    move-result-object v0

    .line 890
    invoke-virtual {v0, p2}, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->setResultHandler(Lcom/amazonaws/mobile/auth/core/SignInResultHandler;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 894
    goto :goto_0

    .line 891
    :catch_0
    move-exception v0

    .line 892
    .local v0, "exception":Ljava/lang/Exception;
    sget-object v1, Lcom/amazonaws/mobile/auth/core/IdentityManager;->LOG_TAG:Ljava/lang/String;

    const-string v2, "Error in instantiating SignInManager. Check the context and completion handler."

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 895
    .end local v0    # "exception":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public removeSignInStateChangeListener(Lcom/amazonaws/mobile/auth/core/SignInStateChangeListener;)V
    .locals 2
    .param p1, "listener"    # Lcom/amazonaws/mobile/auth/core/SignInStateChangeListener;

    .line 503
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInStateChangeListeners:Ljava/util/HashSet;

    monitor-enter v0

    .line 504
    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signInStateChangeListeners:Ljava/util/HashSet;

    invoke-virtual {v1, p1}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z

    .line 505
    monitor-exit v0

    .line 506
    return-void

    .line 505
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public resumeSession(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;)V
    .locals 2
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "startupAuthResultHandler"    # Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;

    .line 815
    const-wide/16 v0, 0x0

    invoke-virtual {p0, p1, p2, v0, v1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->resumeSession(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;J)V

    .line 816
    return-void
.end method

.method public resumeSession(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;J)V
    .locals 8
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "startupAuthResultHandler"    # Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;
    .param p3, "minimumDelay"    # J

    .line 724
    sget-object v0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->LOG_TAG:Ljava/lang/String;

    const-string v1, "Resume Session called."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 726
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->executorService:Ljava/util/concurrent/ExecutorService;

    new-instance v7, Lcom/amazonaws/mobile/auth/core/IdentityManager$6;

    move-object v1, v7

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move-wide v5, p3

    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/mobile/auth/core/IdentityManager$6;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/StartupAuthResultHandler;J)V

    invoke-interface {v0, v7}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    .line 801
    return-void
.end method

.method public setConfiguration(Lcom/amazonaws/mobile/config/AWSConfiguration;)V
    .locals 0
    .param p1, "configuration"    # Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 327
    iput-object p1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsConfiguration:Lcom/amazonaws/mobile/config/AWSConfiguration;

    .line 328
    return-void
.end method

.method public setPersistenceEnabled(Z)V
    .locals 2
    .param p1, "persistenceEnabled"    # Z

    .line 280
    iput-boolean p1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->isPersistenceEnabled:Z

    .line 281
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->awsKeyValueStore:Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;

    iget-boolean v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->isPersistenceEnabled:Z

    invoke-virtual {v0, v1}, Lcom/amazonaws/internal/keyvaluestore/AWSKeyValueStore;->setPersistenceEnabled(Z)V

    .line 282
    return-void
.end method

.method public setProviderResultsHandler(Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;)V
    .locals 2
    .param p1, "signInProviderResultHandler"    # Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;

    .line 582
    if-eqz p1, :cond_0

    .line 585
    new-instance v0, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;

    const/4 v1, 0x0

    invoke-direct {v0, p0, p1, v1}, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;Lcom/amazonaws/mobile/auth/core/IdentityManager$1;)V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->resultsAdapter:Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;

    .line 586
    return-void

    .line 583
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string/jumbo v1, "signInProviderResultHandler cannot be null."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setUpToAuthenticate(Landroid/content/Context;Lcom/amazonaws/mobile/auth/core/SignInResultHandler;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "signInResultHandler"    # Lcom/amazonaws/mobile/auth/core/SignInResultHandler;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 872
    invoke-virtual {p0, p1, p2}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->login(Landroid/content/Context;Lcom/amazonaws/mobile/auth/core/SignInResultHandler;)V

    .line 873
    return-void
.end method

.method public signOut()V
    .locals 2

    .line 524
    sget-object v0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->LOG_TAG:Ljava/lang/String;

    const-string v1, "Signing out..."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 526
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->currentIdentityProvider:Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    if-eqz v0, :cond_0

    .line 527
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager;->executorService:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/amazonaws/mobile/auth/core/IdentityManager$2;

    invoke-direct {v1, p0}, Lcom/amazonaws/mobile/auth/core/IdentityManager$2;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    .line 545
    :cond_0
    return-void
.end method
