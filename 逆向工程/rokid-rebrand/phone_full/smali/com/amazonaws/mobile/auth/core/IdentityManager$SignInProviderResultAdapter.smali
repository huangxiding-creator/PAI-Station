.class Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;
.super Ljava/lang/Object;
.source "IdentityManager.java"

# interfaces
.implements Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/amazonaws/mobile/auth/core/IdentityManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "SignInProviderResultAdapter"
.end annotation


# instance fields
.field private final handler:Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;

.field final synthetic this$0:Lcom/amazonaws/mobile/auth/core/IdentityManager;


# direct methods
.method private constructor <init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;)V
    .locals 0
    .param p2, "handler"    # Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;

    .line 442
    iput-object p1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;->this$0:Lcom/amazonaws/mobile/auth/core/IdentityManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 443
    iput-object p2, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;->handler:Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;

    .line 444
    return-void
.end method

.method synthetic constructor <init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;Lcom/amazonaws/mobile/auth/core/IdentityManager$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/amazonaws/mobile/auth/core/IdentityManager;
    .param p2, "x1"    # Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;
    .param p3, "x2"    # Lcom/amazonaws/mobile/auth/core/IdentityManager$1;

    .line 439
    invoke-direct {p0, p1, p2}, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityManager;Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;)V

    return-void
.end method

.method static synthetic access$1000(Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;Ljava/lang/Exception;)V
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;
    .param p1, "x1"    # Ljava/lang/Exception;

    .line 439
    invoke-direct {p0, p1}, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;->onCognitoError(Ljava/lang/Exception;)V

    return-void
.end method

.method static synthetic access$1100(Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;)V
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;

    .line 439
    invoke-direct {p0}, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;->onCognitoSuccess()V

    return-void
.end method

.method private onCognitoError(Ljava/lang/Exception;)V
    .locals 3
    .param p1, "ex"    # Ljava/lang/Exception;

    .line 461
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->access$500()Ljava/lang/String;

    move-result-object v0

    const-string v1, "SignInProviderResultAdapter.onCognitoError()"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 462
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;->this$0:Lcom/amazonaws/mobile/auth/core/IdentityManager;

    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->access$000(Lcom/amazonaws/mobile/auth/core/IdentityManager;)Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    move-result-object v0

    .line 464
    .local v0, "provider":Lcom/amazonaws/mobile/auth/core/IdentityProvider;
    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;->this$0:Lcom/amazonaws/mobile/auth/core/IdentityManager;

    invoke-virtual {v1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->signOut()V

    .line 465
    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;->handler:Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;

    new-instance v2, Lcom/amazonaws/mobile/auth/core/signin/CognitoAuthException;

    invoke-direct {v2, v0, p1}, Lcom/amazonaws/mobile/auth/core/signin/CognitoAuthException;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityProvider;Ljava/lang/Exception;)V

    invoke-interface {v1, v0, v2}, Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;->onError(Lcom/amazonaws/mobile/auth/core/IdentityProvider;Ljava/lang/Exception;)V

    .line 466
    return-void
.end method

.method private onCognitoSuccess()V
    .locals 2

    .line 456
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->access$500()Ljava/lang/String;

    move-result-object v0

    const-string v1, "SignInProviderResultAdapter.onCognitoSuccess()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 457
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;->handler:Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;

    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;->this$0:Lcom/amazonaws/mobile/auth/core/IdentityManager;

    invoke-static {v1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->access$000(Lcom/amazonaws/mobile/auth/core/IdentityManager;)Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;->onSuccess(Lcom/amazonaws/mobile/auth/core/IdentityProvider;)V

    .line 458
    return-void
.end method


# virtual methods
.method public onCancel(Lcom/amazonaws/mobile/auth/core/IdentityProvider;)V
    .locals 3
    .param p1, "provider"    # Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    .line 470
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->access$500()Ljava/lang/String;

    move-result-object v0

    .line 472
    invoke-interface {p1}, Lcom/amazonaws/mobile/auth/core/IdentityProvider;->getDisplayName()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .line 470
    const-string v2, "SignInProviderResultAdapter.onCancel(): %s provider sign-in canceled."

    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 473
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;->handler:Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;

    invoke-interface {v0, p1}, Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;->onCancel(Lcom/amazonaws/mobile/auth/core/IdentityProvider;)V

    .line 474
    return-void
.end method

.method public onError(Lcom/amazonaws/mobile/auth/core/IdentityProvider;Ljava/lang/Exception;)V
    .locals 3
    .param p1, "provider"    # Lcom/amazonaws/mobile/auth/core/IdentityProvider;
    .param p2, "ex"    # Ljava/lang/Exception;

    .line 478
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->access$500()Ljava/lang/String;

    move-result-object v0

    .line 480
    invoke-interface {p1}, Lcom/amazonaws/mobile/auth/core/IdentityProvider;->getDisplayName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v1, v2}, [Ljava/lang/Object;

    move-result-object v1

    .line 479
    const-string v2, "SignInProviderResultAdapter.onError(): %s provider error. %s"

    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 478
    invoke-static {v0, v1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 481
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;->handler:Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;

    new-instance v1, Lcom/amazonaws/mobile/auth/core/signin/ProviderAuthException;

    invoke-direct {v1, p1, p2}, Lcom/amazonaws/mobile/auth/core/signin/ProviderAuthException;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityProvider;Ljava/lang/Exception;)V

    invoke-interface {v0, p1, v1}, Lcom/amazonaws/mobile/auth/core/signin/SignInProviderResultHandler;->onError(Lcom/amazonaws/mobile/auth/core/IdentityProvider;Ljava/lang/Exception;)V

    .line 482
    return-void
.end method

.method public onSuccess(Lcom/amazonaws/mobile/auth/core/IdentityProvider;)V
    .locals 3
    .param p1, "provider"    # Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    .line 448
    invoke-static {}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->access$500()Ljava/lang/String;

    move-result-object v0

    .line 450
    invoke-interface {p1}, Lcom/amazonaws/mobile/auth/core/IdentityProvider;->getDisplayName()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .line 449
    const-string v2, "SignInProviderResultAdapter.onSuccess(): %s provider sign-in succeeded."

    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 448
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 452
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/IdentityManager$SignInProviderResultAdapter;->this$0:Lcom/amazonaws/mobile/auth/core/IdentityManager;

    invoke-virtual {v0, p1}, Lcom/amazonaws/mobile/auth/core/IdentityManager;->federateWithProvider(Lcom/amazonaws/mobile/auth/core/IdentityProvider;)V

    .line 453
    return-void
.end method
