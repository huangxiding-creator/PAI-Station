.class public Lcom/auth0/jwt/exceptions/IncorrectClaimException;
.super Lcom/auth0/jwt/exceptions/InvalidClaimException;
.source "IncorrectClaimException.java"


# instance fields
.field private final claimName:Ljava/lang/String;

.field private final claimValue:Lcom/auth0/jwt/interfaces/Claim;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "claimName"    # Ljava/lang/String;
    .param p3, "claim"    # Lcom/auth0/jwt/interfaces/Claim;

    .line 22
    invoke-direct {p0, p1}, Lcom/auth0/jwt/exceptions/InvalidClaimException;-><init>(Ljava/lang/String;)V

    .line 23
    iput-object p2, p0, Lcom/auth0/jwt/exceptions/IncorrectClaimException;->claimName:Ljava/lang/String;

    .line 24
    iput-object p3, p0, Lcom/auth0/jwt/exceptions/IncorrectClaimException;->claimValue:Lcom/auth0/jwt/interfaces/Claim;

    .line 25
    return-void
.end method


# virtual methods
.method public getClaimName()Ljava/lang/String;
    .locals 1

    .line 33
    iget-object v0, p0, Lcom/auth0/jwt/exceptions/IncorrectClaimException;->claimName:Ljava/lang/String;

    return-object v0
.end method

.method public getClaimValue()Lcom/auth0/jwt/interfaces/Claim;
    .locals 1

    .line 42
    iget-object v0, p0, Lcom/auth0/jwt/exceptions/IncorrectClaimException;->claimValue:Lcom/auth0/jwt/interfaces/Claim;

    return-object v0
.end method
