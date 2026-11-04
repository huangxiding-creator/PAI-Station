.class Lcom/auth0/jwt/JWTVerifier$BaseVerification$1;
.super Ljava/lang/Object;
.source "JWTVerifier.java"

# interfaces
.implements Lcom/auth0/jwt/impl/ExpectedCheckHolder;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/auth0/jwt/JWTVerifier$BaseVerification;->constructExpectedCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)Lcom/auth0/jwt/impl/ExpectedCheckHolder;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/auth0/jwt/JWTVerifier$BaseVerification;

.field final synthetic val$check:Ljava/util/function/BiPredicate;

.field final synthetic val$claimName:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/lang/String;Ljava/util/function/BiPredicate;)V
    .locals 0
    .param p1, "this$0"    # Lcom/auth0/jwt/JWTVerifier$BaseVerification;

    .line 397
    iput-object p1, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$1;->this$0:Lcom/auth0/jwt/JWTVerifier$BaseVerification;

    iput-object p2, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$1;->val$claimName:Ljava/lang/String;

    iput-object p3, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$1;->val$check:Ljava/util/function/BiPredicate;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getClaimName()Ljava/lang/String;
    .locals 1

    .line 400
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$1;->val$claimName:Ljava/lang/String;

    return-object v0
.end method

.method public verify(Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p1, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p2, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 405
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$1;->val$check:Ljava/util/function/BiPredicate;

    invoke-interface {v0, p1, p2}, Ljava/util/function/BiPredicate;->test(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method
