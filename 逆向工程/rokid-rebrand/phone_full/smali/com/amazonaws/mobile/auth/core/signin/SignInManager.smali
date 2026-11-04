.class public Lcom/amazonaws/mobile/auth/core/signin/SignInManager;
.super Ljava/lang/Object;
.source "SignInManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/mobile/auth/core/signin/SignInManager$SignInProviderResultAdapter;
    }
.end annotation


# static fields
.field private static final LOG_TAG:Ljava/lang/String;

.field private static volatile singleton:Lcom/amazonaws/mobile/auth/core/signin/SignInManager;


# instance fields
.field private final providersHandlingPermissions:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray<",
            "Lcom/amazonaws/mobile/auth/core/signin/SignInPermissionsHandler;",
            ">;"
        }
    .end annotation
.end field

.field private resultsAdapter:Lcom/amazonaws/mobile/auth/core/signin/SignInManager$SignInProviderResultAdapter;

.field private final signInProviders:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Class<",
            "+",
            "Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;",
            ">;",
            "Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;",
            ">;"
        }
    .end annotation
.end field

.field private volatile signInResultHandler:Lcom/amazonaws/mobile/auth/core/SignInResultHandler;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 43
    const-class v0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->LOG_TAG:Ljava/lang/String;

    .line 50
    const/4 v0, 0x0

    sput-object v0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->singleton:Lcom/amazonaws/mobile/auth/core/signin/SignInManager;

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;

    .line 62
    const-string v0, " . Skipping this provider."

    const-string v1, "Unable to instantiate "

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    iput-object v2, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->signInProviders:Ljava/util/Map;

    .line 56
    new-instance v2, Landroid/util/SparseArray;

    invoke-direct {v2}, Landroid/util/SparseArray;-><init>()V

    iput-object v2, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->providersHandlingPermissions:Landroid/util/SparseArray;

    .line 64
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v2

    invoke-virtual {v2}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getSignInProviderClasses()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Class;

    .line 67
    .local v3, "providerClass":Ljava/lang/Class;, "Ljava/lang/Class<+Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;>;"
    :try_start_0
    invoke-virtual {v3}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;

    .line 68
    .local v4, "provider":Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;
    if-eqz v4, :cond_0

    .line 69
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v5

    invoke-virtual {v5}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getConfiguration()Lcom/amazonaws/mobile/config/AWSConfiguration;

    move-result-object v5

    invoke-interface {v4, p1, v5}, Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;->initialize(Landroid/content/Context;Lcom/amazonaws/mobile/config/AWSConfiguration;)V

    .line 70
    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->signInProviders:Ljava/util/Map;

    invoke-interface {v5, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 71
    instance-of v5, v4, Lcom/amazonaws/mobile/auth/core/signin/SignInPermissionsHandler;

    if-eqz v5, :cond_0

    .line 72
    move-object v5, v4

    check-cast v5, Lcom/amazonaws/mobile/auth/core/signin/SignInPermissionsHandler;

    .line 73
    .local v5, "handler":Lcom/amazonaws/mobile/auth/core/signin/SignInPermissionsHandler;
    iget-object v6, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->providersHandlingPermissions:Landroid/util/SparseArray;

    invoke-interface {v5}, Lcom/amazonaws/mobile/auth/core/signin/SignInPermissionsHandler;->getPermissionRequestCode()I

    move-result v7

    invoke-virtual {v6, v7, v5}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_0

    .line 80
    .end local v5    # "handler":Lcom/amazonaws/mobile/auth/core/signin/SignInPermissionsHandler;
    :cond_0
    goto :goto_1

    .line 78
    .end local v4    # "provider":Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;
    :catch_0
    move-exception v4

    .line 79
    .local v4, "ex":Ljava/lang/InstantiationException;
    sget-object v5, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->LOG_TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 76
    .end local v4    # "ex":Ljava/lang/InstantiationException;
    :catch_1
    move-exception v4

    .line 77
    .local v4, "ex":Ljava/lang/IllegalAccessException;
    sget-object v5, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->LOG_TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 80
    .end local v4    # "ex":Ljava/lang/IllegalAccessException;
    nop

    .line 82
    .end local v3    # "providerClass":Ljava/lang/Class;, "Ljava/lang/Class<+Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;>;"
    :goto_1
    goto :goto_0

    .line 84
    :cond_1
    sput-object p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->singleton:Lcom/amazonaws/mobile/auth/core/signin/SignInManager;

    .line 85
    return-void
.end method

.method public static declared-synchronized dispose()V
    .locals 2

    const-class v0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;

    monitor-enter v0

    .line 130
    const/4 v1, 0x0

    :try_start_0
    sput-object v1, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->singleton:Lcom/amazonaws/mobile/auth/core/signin/SignInManager;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 131
    monitor-exit v0

    return-void

    .line 129
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private findProvider(Ljava/lang/Class;)Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "+",
            "Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;",
            ">;)",
            "Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;"
        }
    .end annotation

    .line 270
    .local p1, "providerClass":Ljava/lang/Class;, "Ljava/lang/Class<+Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;>;"
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->signInProviders:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;

    .line 272
    .local v0, "provider":Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;
    if-eqz v0, :cond_0

    .line 276
    return-object v0

    .line 273
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "No such provider : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public static declared-synchronized getInstance()Lcom/amazonaws/mobile/auth/core/signin/SignInManager;
    .locals 2

    const-class v0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;

    monitor-enter v0

    .line 93
    :try_start_0
    sget-object v1, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->singleton:Lcom/amazonaws/mobile/auth/core/signin/SignInManager;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    .line 93
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized getInstance(Landroid/content/Context;)Lcom/amazonaws/mobile/auth/core/signin/SignInManager;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    const-class v0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;

    monitor-enter v0

    .line 102
    :try_start_0
    sget-object v1, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->singleton:Lcom/amazonaws/mobile/auth/core/signin/SignInManager;

    if-nez v1, :cond_0

    .line 103
    new-instance v1, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;

    invoke-direct {v1, p0}, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;-><init>(Landroid/content/Context;)V

    sput-object v1, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->singleton:Lcom/amazonaws/mobile/auth/core/signin/SignInManager;

    .line 105
    :cond_0
    sget-object v1, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->singleton:Lcom/amazonaws/mobile/auth/core/signin/SignInManager;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    .line 101
    .end local p0    # "context":Landroid/content/Context;
    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method


# virtual methods
.method public getPreviouslySignedInProvider()Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;
    .locals 4

    .line 144
    sget-object v0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->LOG_TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Providers: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->signInProviders:Ljava/util/Map;

    invoke-static {v2}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 146
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->signInProviders:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;

    .line 149
    .local v1, "provider":Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;
    invoke-interface {v1}, Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;->refreshUserSignInState()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 150
    sget-object v0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->LOG_TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Refreshing provider: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-interface {v1}, Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;->getDisplayName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 151
    return-object v1

    .line 153
    .end local v1    # "provider":Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;
    :cond_0
    goto :goto_0

    .line 154
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public getResultHandler()Lcom/amazonaws/mobile/auth/core/SignInResultHandler;
    .locals 1

    .line 123
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->signInResultHandler:Lcom/amazonaws/mobile/auth/core/SignInResultHandler;

    return-object v0
.end method

.method public handleActivityResult(IILandroid/content/Intent;)Z
    .locals 3
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .line 290
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->signInProviders:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;

    .line 291
    .local v1, "provider":Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;
    invoke-interface {v1, p1}, Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;->isRequestCodeOurs(I)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 292
    invoke-interface {v1, p1, p2, p3}, Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;->handleActivityResult(IILandroid/content/Intent;)V

    .line 293
    const/4 v0, 0x1

    return v0

    .line 295
    .end local v1    # "provider":Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;
    :cond_0
    goto :goto_0

    .line 297
    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method public handleRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 1
    .param p1, "requestCode"    # I
    .param p2, "permissions"    # [Ljava/lang/String;
    .param p3, "grantResults"    # [I

    .line 310
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->providersHandlingPermissions:Landroid/util/SparseArray;

    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/mobile/auth/core/signin/SignInPermissionsHandler;

    .line 311
    .local v0, "handler":Lcom/amazonaws/mobile/auth/core/signin/SignInPermissionsHandler;
    if-eqz v0, :cond_0

    .line 312
    invoke-interface {v0, p1, p2, p3}, Lcom/amazonaws/mobile/auth/core/signin/SignInPermissionsHandler;->handleRequestPermissionsResult(I[Ljava/lang/String;[I)V

    .line 314
    :cond_0
    return-void
.end method

.method public initializeSignInButton(Ljava/lang/Class;Landroid/view/View;)Landroid/view/View$OnClickListener;
    .locals 3
    .param p2, "buttonView"    # Landroid/view/View;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "+",
            "Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;",
            ">;",
            "Landroid/view/View;",
            ")",
            "Landroid/view/View$OnClickListener;"
        }
    .end annotation

    .line 261
    .local p1, "providerClass":Ljava/lang/Class;, "Ljava/lang/Class<+Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;>;"
    invoke-direct {p0, p1}, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->findProvider(Ljava/lang/Class;)Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;

    move-result-object v0

    .line 264
    .local v0, "provider":Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;
    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->resultsAdapter:Lcom/amazonaws/mobile/auth/core/signin/SignInManager$SignInProviderResultAdapter;

    invoke-static {v1}, Lcom/amazonaws/mobile/auth/core/signin/SignInManager$SignInProviderResultAdapter;->access$200(Lcom/amazonaws/mobile/auth/core/signin/SignInManager$SignInProviderResultAdapter;)Landroid/app/Activity;

    move-result-object v1

    .line 265
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v2

    invoke-virtual {v2}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getResultsAdapter()Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;

    move-result-object v2

    .line 264
    invoke-interface {v0, v1, p2, v2}, Lcom/amazonaws/mobile/auth/core/signin/SignInProvider;->initializeSignInButton(Landroid/app/Activity;Landroid/view/View;Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;)Landroid/view/View$OnClickListener;

    move-result-object v1

    return-object v1
.end method

.method public refreshCredentialsWithProvider(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/IdentityProvider;Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;)V
    .locals 2
    .param p1, "activity"    # Landroid/app/Activity;
    .param p2, "signInProvider"    # Lcom/amazonaws/mobile/auth/core/IdentityProvider;
    .param p3, "resultsHandler"    # Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;

    .line 224
    if-eqz p2, :cond_1

    .line 228
    invoke-interface {p2}, Lcom/amazonaws/mobile/auth/core/IdentityProvider;->getToken()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    .line 229
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Given provider not previously logged in."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    invoke-interface {p3, p2, v0}, Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;->onError(Lcom/amazonaws/mobile/auth/core/IdentityProvider;Ljava/lang/Exception;)V

    .line 233
    :cond_0
    new-instance v0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager$SignInProviderResultAdapter;

    const/4 v1, 0x0

    invoke-direct {v0, p0, p1, p3, v1}, Lcom/amazonaws/mobile/auth/core/signin/SignInManager$SignInProviderResultAdapter;-><init>(Lcom/amazonaws/mobile/auth/core/signin/SignInManager;Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;Lcom/amazonaws/mobile/auth/core/signin/SignInManager$1;)V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->resultsAdapter:Lcom/amazonaws/mobile/auth/core/signin/SignInManager$SignInProviderResultAdapter;

    .line 234
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v0

    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->resultsAdapter:Lcom/amazonaws/mobile/auth/core/signin/SignInManager$SignInProviderResultAdapter;

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->setProviderResultsHandler(Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;)V

    .line 235
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v0

    invoke-virtual {v0, p2}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->federateWithProvider(Lcom/amazonaws/mobile/auth/core/IdentityProvider;)V

    .line 236
    return-void

    .line 225
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The sign-in provider cannot be null."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setProviderResultsHandler(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;)V
    .locals 2
    .param p1, "activity"    # Landroid/app/Activity;
    .param p2, "resultsHandler"    # Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;

    .line 247
    new-instance v0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager$SignInProviderResultAdapter;

    const/4 v1, 0x0

    invoke-direct {v0, p0, p1, p2, v1}, Lcom/amazonaws/mobile/auth/core/signin/SignInManager$SignInProviderResultAdapter;-><init>(Lcom/amazonaws/mobile/auth/core/signin/SignInManager;Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;Lcom/amazonaws/mobile/auth/core/signin/SignInManager$1;)V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->resultsAdapter:Lcom/amazonaws/mobile/auth/core/signin/SignInManager$SignInProviderResultAdapter;

    .line 249
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->getDefaultIdentityManager()Lcom/amazonaws/mobile/auth/core/IdentityManager;

    move-result-object v0

    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->resultsAdapter:Lcom/amazonaws/mobile/auth/core/signin/SignInManager$SignInProviderResultAdapter;

    invoke-virtual {v0, v1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->setProviderResultsHandler(Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;)V

    .line 250
    return-void
.end method

.method public setResultHandler(Lcom/amazonaws/mobile/auth/core/SignInResultHandler;)V
    .locals 0
    .param p1, "signInResultHandler"    # Lcom/amazonaws/mobile/auth/core/SignInResultHandler;

    .line 114
    iput-object p1, p0, Lcom/amazonaws/mobile/auth/core/signin/SignInManager;->signInResultHandler:Lcom/amazonaws/mobile/auth/core/SignInResultHandler;

    .line 115
    return-void
.end method
