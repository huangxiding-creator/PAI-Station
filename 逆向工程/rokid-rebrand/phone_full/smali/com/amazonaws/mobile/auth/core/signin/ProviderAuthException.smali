.class public Lcom/amazonaws/mobile/auth/core/signin/ProviderAuthException;
.super Lcom/amazonaws/mobile/auth/core/signin/AuthException;
.source "ProviderAuthException.java"


# direct methods
.method public constructor <init>(Lcom/amazonaws/mobile/auth/core/IdentityProvider;Ljava/lang/Exception;)V
    .locals 0
    .param p1, "provider"    # Lcom/amazonaws/mobile/auth/core/IdentityProvider;
    .param p2, "ex"    # Ljava/lang/Exception;

    .line 33
    invoke-direct {p0, p1, p2}, Lcom/amazonaws/mobile/auth/core/signin/AuthException;-><init>(Lcom/amazonaws/mobile/auth/core/IdentityProvider;Ljava/lang/Exception;)V

    .line 34
    return-void
.end method
