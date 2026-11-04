.class public final synthetic Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda8;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/BiPredicate;


# instance fields
.field public final synthetic f$0:Lcom/auth0/jwt/JWTVerifier$BaseVerification;

.field public final synthetic f$1:J


# direct methods
.method public synthetic constructor <init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;J)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda8;->f$0:Lcom/auth0/jwt/JWTVerifier$BaseVerification;

    iput-wide p2, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda8;->f$1:J

    return-void
.end method


# virtual methods
.method public final test(Ljava/lang/Object;Ljava/lang/Object;)Z
    .locals 3

    .line 0
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda8;->f$0:Lcom/auth0/jwt/JWTVerifier$BaseVerification;

    iget-wide v1, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda8;->f$1:J

    check-cast p1, Lcom/auth0/jwt/interfaces/Claim;

    check-cast p2, Lcom/auth0/jwt/interfaces/DecodedJWT;

    invoke-virtual {v0, v1, v2, p1, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->lambda$addMandatoryClaimChecks$19$com-auth0-jwt-JWTVerifier$BaseVerification(JLcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z

    move-result p1

    return p1
.end method
