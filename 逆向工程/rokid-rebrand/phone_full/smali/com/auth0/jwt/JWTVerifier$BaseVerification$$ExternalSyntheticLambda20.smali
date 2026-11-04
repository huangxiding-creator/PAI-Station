.class public final synthetic Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda20;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/BiPredicate;


# instance fields
.field public final synthetic f$0:Lcom/auth0/jwt/JWTVerifier$BaseVerification;

.field public final synthetic f$1:Ljava/lang/Integer;


# direct methods
.method public synthetic constructor <init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/lang/Integer;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda20;->f$0:Lcom/auth0/jwt/JWTVerifier$BaseVerification;

    iput-object p2, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda20;->f$1:Ljava/lang/Integer;

    return-void
.end method


# virtual methods
.method public final test(Ljava/lang/Object;Ljava/lang/Object;)Z
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda20;->f$0:Lcom/auth0/jwt/JWTVerifier$BaseVerification;

    iget-object v1, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda20;->f$1:Ljava/lang/Integer;

    check-cast p1, Lcom/auth0/jwt/interfaces/Claim;

    check-cast p2, Lcom/auth0/jwt/interfaces/DecodedJWT;

    invoke-virtual {v0, v1, p1, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->lambda$withClaim$8$com-auth0-jwt-JWTVerifier$BaseVerification(Ljava/lang/Integer;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z

    move-result p1

    return p1
.end method
