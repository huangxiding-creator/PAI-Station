.class public abstract Lcom/amazonaws/mobile/auth/core/DefaultSignInResultHandler;
.super Ljava/lang/Object;
.source "DefaultSignInResultHandler.java"

# interfaces
.implements Lcom/amazonaws/mobile/auth/core/SignInResultHandler;


# static fields
.field private static final LOG_TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 36
    const-class v0, Lcom/amazonaws/mobile/auth/core/DefaultSignInResultHandler;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/mobile/auth/core/DefaultSignInResultHandler;->LOG_TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onIntermediateProviderCancel(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/IdentityProvider;)V
    .locals 3
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "provider"    # Lcom/amazonaws/mobile/auth/core/IdentityProvider;

    .line 44
    sget-object v0, Lcom/amazonaws/mobile/auth/core/DefaultSignInResultHandler;->LOG_TAG:Ljava/lang/String;

    invoke-interface {p2}, Lcom/amazonaws/mobile/auth/core/IdentityProvider;->getDisplayName()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "%s Sign-In flow is canceled"

    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 45
    return-void
.end method

.method public onIntermediateProviderError(Landroid/app/Activity;Lcom/amazonaws/mobile/auth/core/IdentityProvider;Ljava/lang/Exception;)V
    .locals 4
    .param p1, "callingActivity"    # Landroid/app/Activity;
    .param p2, "provider"    # Lcom/amazonaws/mobile/auth/core/IdentityProvider;
    .param p3, "ex"    # Ljava/lang/Exception;

    .line 54
    sget v0, Lcom/amazonaws/mobile/auth/core/R$string;->sign_in_failure_message_format:I

    invoke-virtual {p1, v0}, Landroid/app/Activity;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 55
    .local v0, "failureFormatString":Ljava/lang/String;
    sget-object v1, Lcom/amazonaws/mobile/auth/core/DefaultSignInResultHandler;->LOG_TAG:Ljava/lang/String;

    .line 56
    invoke-interface {p2}, Lcom/amazonaws/mobile/auth/core/IdentityProvider;->getDisplayName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    .line 55
    invoke-static {v0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2, p3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 57
    return-void
.end method
