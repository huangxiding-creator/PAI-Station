.class public Lcom/auth0/jwt/exceptions/MissingClaimException;
.super Lcom/auth0/jwt/exceptions/InvalidClaimException;
.source "MissingClaimException.java"


# instance fields
.field private final claimName:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 2
    .param p1, "claimName"    # Ljava/lang/String;

    .line 11
    const-string v0, "The Claim \'%s\' is not present in the JWT."

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/auth0/jwt/exceptions/InvalidClaimException;-><init>(Ljava/lang/String;)V

    .line 12
    iput-object p1, p0, Lcom/auth0/jwt/exceptions/MissingClaimException;->claimName:Ljava/lang/String;

    .line 13
    return-void
.end method


# virtual methods
.method public getClaimName()Ljava/lang/String;
    .locals 1

    .line 21
    iget-object v0, p0, Lcom/auth0/jwt/exceptions/MissingClaimException;->claimName:Ljava/lang/String;

    return-object v0
.end method
