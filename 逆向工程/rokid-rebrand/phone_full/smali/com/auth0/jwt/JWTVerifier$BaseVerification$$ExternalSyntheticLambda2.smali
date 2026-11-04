.class public final synthetic Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/BiPredicate;


# direct methods
.method public synthetic constructor <init>()V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final test(Ljava/lang/Object;Ljava/lang/Object;)Z
    .locals 0

    .line 0
    check-cast p1, Lcom/auth0/jwt/interfaces/Claim;

    check-cast p2, Lcom/auth0/jwt/interfaces/DecodedJWT;

    invoke-static {p1, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->lambda$withClaimPresence$5(Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z

    move-result p1

    return p1
.end method
