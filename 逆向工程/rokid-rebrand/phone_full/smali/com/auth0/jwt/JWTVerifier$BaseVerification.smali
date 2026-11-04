.class public Lcom/auth0/jwt/JWTVerifier$BaseVerification;
.super Ljava/lang/Object;
.source "JWTVerifier.java"

# interfaces
.implements Lcom/auth0/jwt/interfaces/Verification;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/auth0/jwt/JWTVerifier;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "BaseVerification"
.end annotation


# instance fields
.field private final algorithm:Lcom/auth0/jwt/algorithms/Algorithm;

.field private clock:Ljava/time/Clock;

.field private final customLeeways:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field private defaultLeeway:J

.field private final expectedChecks:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/auth0/jwt/impl/ExpectedCheckHolder;",
            ">;"
        }
    .end annotation
.end field

.field private ignoreIssuedAt:Z


# direct methods
.method constructor <init>(Lcom/auth0/jwt/algorithms/Algorithm;)V
    .locals 2
    .param p1, "algorithm"    # Lcom/auth0/jwt/algorithms/Algorithm;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 63
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 64
    if-eqz p1, :cond_0

    .line 68
    iput-object p1, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->algorithm:Lcom/auth0/jwt/algorithms/Algorithm;

    .line 69
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->expectedChecks:Ljava/util/List;

    .line 70
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->customLeeways:Ljava/util/Map;

    .line 71
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->defaultLeeway:J

    .line 72
    return-void

    .line 65
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The Algorithm cannot be null."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/function/BiPredicate<",
            "Lcom/auth0/jwt/interfaces/Claim;",
            "Lcom/auth0/jwt/interfaces/DecodedJWT;",
            ">;)V"
        }
    .end annotation

    .line 388
    .local p2, "predicate":Ljava/util/function/BiPredicate;, "Ljava/util/function/BiPredicate<Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;>;"
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->expectedChecks:Ljava/util/List;

    new-instance v1, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda18;

    invoke-direct {v1, p1, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda18;-><init>(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    invoke-direct {p0, p1, v1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->constructExpectedCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)Lcom/auth0/jwt/impl/ExpectedCheckHolder;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 394
    return-void
.end method

.method private addMandatoryClaimChecks()V
    .locals 11

    .line 303
    const-string v0, "exp"

    invoke-virtual {p0, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->getLeewayFor(Ljava/lang/String;)J

    move-result-wide v1

    .line 304
    .local v1, "expiresAtLeeway":J
    const-string v3, "nbf"

    invoke-virtual {p0, v3}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->getLeewayFor(Ljava/lang/String;)J

    move-result-wide v4

    .line 305
    .local v4, "notBeforeLeeway":J
    const-string v6, "iat"

    invoke-virtual {p0, v6}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->getLeewayFor(Ljava/lang/String;)J

    move-result-wide v7

    .line 307
    .local v7, "issuedAtLeeway":J
    iget-object v9, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->expectedChecks:Ljava/util/List;

    new-instance v10, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda6;

    invoke-direct {v10, p0, v1, v2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda6;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;J)V

    invoke-direct {p0, v0, v10}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->constructExpectedCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)Lcom/auth0/jwt/impl/ExpectedCheckHolder;

    move-result-object v0

    invoke-interface {v9, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 309
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->expectedChecks:Ljava/util/List;

    new-instance v9, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda7;

    invoke-direct {v9, p0, v4, v5}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda7;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;J)V

    invoke-direct {p0, v3, v9}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->constructExpectedCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)Lcom/auth0/jwt/impl/ExpectedCheckHolder;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 311
    iget-boolean v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->ignoreIssuedAt:Z

    if-nez v0, :cond_0

    .line 312
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->expectedChecks:Ljava/util/List;

    new-instance v3, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda8;

    invoke-direct {v3, p0, v7, v8}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda8;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;J)V

    invoke-direct {p0, v6, v3}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->constructExpectedCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)Lcom/auth0/jwt/impl/ExpectedCheckHolder;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 315
    :cond_0
    return-void
.end method

.method private assertInstantIsFuture(Ljava/time/Instant;JLjava/time/Instant;)Z
    .locals 1
    .param p1, "claimVal"    # Ljava/time/Instant;
    .param p2, "leeway"    # J
    .param p4, "now"    # Ljava/time/Instant;

    .line 359
    if-eqz p1, :cond_1

    invoke-static {p2, p3}, Ljava/time/Duration;->ofSeconds(J)Ljava/time/Duration;

    move-result-object v0

    invoke-virtual {p4, v0}, Ljava/time/Instant;->minus(Ljava/time/temporal/TemporalAmount;)Ljava/time/Instant;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/time/Instant;->isBefore(Ljava/time/Instant;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method private assertInstantIsLessThanOrEqualToNow(Ljava/time/Instant;JLjava/time/Instant;)Z
    .locals 1
    .param p1, "claimVal"    # Ljava/time/Instant;
    .param p2, "leeway"    # J
    .param p4, "now"    # Ljava/time/Instant;

    .line 363
    if-eqz p1, :cond_1

    invoke-static {p2, p3}, Ljava/time/Duration;->ofSeconds(J)Ljava/time/Duration;

    move-result-object v0

    invoke-virtual {p4, v0}, Ljava/time/Instant;->plus(Ljava/time/temporal/TemporalAmount;)Ljava/time/Instant;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/time/Instant;->isBefore(Ljava/time/Instant;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method private assertNonNull(Ljava/lang/String;)V
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 382
    if-eqz p1, :cond_0

    .line 385
    return-void

    .line 383
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The Custom Claim\'s name can\'t be null."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private assertPositive(J)V
    .locals 2
    .param p1, "leeway"    # J

    .line 376
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-ltz v0, :cond_0

    .line 379
    return-void

    .line 377
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Leeway value can\'t be negative."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private assertValidAudienceClaim(Ljava/util/List;Ljava/util/List;Z)Z
    .locals 1
    .param p3, "shouldContainAll"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;Z)Z"
        }
    .end annotation

    .line 371
    .local p1, "audience":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .local p2, "values":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    if-eqz p1, :cond_2

    if-eqz p3, :cond_0

    invoke-interface {p1, p2}, Ljava/util/List;->containsAll(Ljava/util/Collection;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_0
    if-nez p3, :cond_1

    .line 372
    invoke-static {p1, p2}, Ljava/util/Collections;->disjoint(Ljava/util/Collection;Ljava/util/Collection;)Z

    move-result v0

    if-nez v0, :cond_2

    :cond_1
    const/4 v0, 0x1

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    .line 371
    :goto_0
    return v0
.end method

.method private assertValidCollectionClaim(Lcom/auth0/jwt/interfaces/Claim;[Ljava/lang/Object;)Z
    .locals 7
    .param p1, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p2, "expectedClaimValue"    # [Ljava/lang/Object;

    .line 319
    const-class v0, [Ljava/lang/Object;

    invoke-interface {p1, v0}, Lcom/auth0/jwt/interfaces/Claim;->as(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/Object;

    .line 322
    .local v0, "claimAsObject":[Ljava/lang/Object;
    instance-of v1, p2, [Ljava/lang/Long;

    if-eqz v1, :cond_1

    .line 324
    new-instance v1, Ljava/util/ArrayList;

    array-length v2, v0

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    .line 325
    .local v1, "claimArr":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    array-length v2, v0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_2

    aget-object v4, v0, v3

    .line 326
    .local v4, "cao":Ljava/lang/Object;
    instance-of v5, v4, Ljava/lang/Integer;

    if-eqz v5, :cond_0

    .line 327
    move-object v5, v4

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->longValue()J

    move-result-wide v5

    invoke-static {v5, v6}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    invoke-interface {v1, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 329
    :cond_0
    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 325
    .end local v4    # "cao":Ljava/lang/Object;
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 333
    .end local v1    # "claimArr":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    :cond_1
    const-class v1, [Ljava/lang/Object;

    invoke-interface {p1, v1}, Lcom/auth0/jwt/interfaces/Claim;->as(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/Object;

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    .line 335
    .restart local v1    # "claimArr":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    :cond_2
    invoke-static {p2}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    .line 336
    .local v2, "valueArr":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    invoke-interface {v1, v2}, Ljava/util/List;->containsAll(Ljava/util/Collection;)Z

    move-result v3

    return v3
.end method

.method private assertValidInstantClaim(Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;JZ)Z
    .locals 6
    .param p1, "claimName"    # Ljava/lang/String;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "leeway"    # J
    .param p5, "shouldBeFuture"    # Z

    .line 340
    invoke-interface {p2}, Lcom/auth0/jwt/interfaces/Claim;->asInstant()Ljava/time/Instant;

    move-result-object v0

    .line 341
    .local v0, "claimVal":Ljava/time/Instant;
    iget-object v1, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->clock:Ljava/time/Clock;

    invoke-virtual {v1}, Ljava/time/Clock;->instant()Ljava/time/Instant;

    move-result-object v1

    sget-object v2, Ljava/time/temporal/ChronoUnit;->SECONDS:Ljava/time/temporal/ChronoUnit;

    invoke-virtual {v1, v2}, Ljava/time/Instant;->truncatedTo(Ljava/time/temporal/TemporalUnit;)Ljava/time/Instant;

    move-result-object v1

    .line 343
    .local v1, "now":Ljava/time/Instant;
    if-eqz p5, :cond_1

    .line 344
    invoke-direct {p0, v0, p3, p4, v1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertInstantIsFuture(Ljava/time/Instant;JLjava/time/Instant;)Z

    move-result v2

    .line 345
    .local v2, "isValid":Z
    if-eqz v2, :cond_0

    goto :goto_0

    .line 346
    :cond_0
    new-instance v3, Lcom/auth0/jwt/exceptions/TokenExpiredException;

    const-string v4, "The Token has expired on %s."

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4, v0}, Lcom/auth0/jwt/exceptions/TokenExpiredException;-><init>(Ljava/lang/String;Ljava/time/Instant;)V

    throw v3

    .line 349
    .end local v2    # "isValid":Z
    :cond_1
    invoke-direct {p0, v0, p3, p4, v1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertInstantIsLessThanOrEqualToNow(Ljava/time/Instant;JLjava/time/Instant;)Z

    move-result v2

    .line 350
    .restart local v2    # "isValid":Z
    if-eqz v2, :cond_2

    .line 355
    :goto_0
    const/4 v3, 0x1

    return v3

    .line 351
    :cond_2
    new-instance v3, Lcom/auth0/jwt/exceptions/IncorrectClaimException;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v4

    .line 352
    const-string v5, "The Token can\'t be used before %s."

    invoke-static {v5, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4, p1, p2}, Lcom/auth0/jwt/exceptions/IncorrectClaimException;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;)V

    throw v3
.end method

.method private constructExpectedCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)Lcom/auth0/jwt/impl/ExpectedCheckHolder;
    .locals 1
    .param p1, "claimName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/function/BiPredicate<",
            "Lcom/auth0/jwt/interfaces/Claim;",
            "Lcom/auth0/jwt/interfaces/DecodedJWT;",
            ">;)",
            "Lcom/auth0/jwt/impl/ExpectedCheckHolder;"
        }
    .end annotation

    .line 397
    .local p2, "check":Ljava/util/function/BiPredicate;, "Ljava/util/function/BiPredicate<Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;>;"
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$1;

    invoke-direct {v0, p0, p1, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$1;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    return-object v0
.end method

.method private isNullOrEmpty([Ljava/lang/String;)Z
    .locals 4
    .param p1, "args"    # [Ljava/lang/String;

    .line 415
    if-eqz p1, :cond_3

    array-length v0, p1

    if-nez v0, :cond_0

    goto :goto_2

    .line 418
    :cond_0
    const/4 v0, 0x1

    .line 419
    .local v0, "isAllNull":Z
    array-length v1, p1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    aget-object v3, p1, v2

    .line 420
    .local v3, "arg":Ljava/lang/String;
    if-eqz v3, :cond_1

    .line 421
    const/4 v0, 0x0

    .line 422
    goto :goto_1

    .line 419
    .end local v3    # "arg":Ljava/lang/String;
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 425
    :cond_2
    :goto_1
    return v0

    .line 416
    .end local v0    # "isAllNull":Z
    :cond_3
    :goto_2
    const/4 v0, 0x1

    return v0
.end method

.method static synthetic lambda$addCheck$20(Ljava/lang/String;Ljava/util/function/BiPredicate;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "predicate"    # Ljava/util/function/BiPredicate;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 389
    invoke-interface {p2}, Lcom/auth0/jwt/interfaces/Claim;->isMissing()Z

    move-result v0

    if-nez v0, :cond_0

    .line 392
    invoke-interface {p1, p2, p3}, Ljava/util/function/BiPredicate;->test(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    return v0

    .line 390
    :cond_0
    new-instance v0, Lcom/auth0/jwt/exceptions/MissingClaimException;

    invoke-direct {v0, p0}, Lcom/auth0/jwt/exceptions/MissingClaimException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static synthetic lambda$withClaimPresence$5(Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p0, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p1, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 174
    const/4 v0, 0x1

    return v0
.end method

.method static synthetic lambda$withNullClaim$6(Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p0, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p1, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 181
    invoke-interface {p0}, Lcom/auth0/jwt/interfaces/Claim;->isNull()Z

    move-result v0

    return v0
.end method

.method private verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z
    .locals 1
    .param p1, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p2, "value"    # Ljava/lang/Object;

    .line 411
    if-nez p2, :cond_0

    invoke-interface {p1}, Lcom/auth0/jwt/interfaces/Claim;->isNull()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method


# virtual methods
.method public acceptExpiresAt(J)Lcom/auth0/jwt/interfaces/Verification;
    .locals 3
    .param p1, "leeway"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 138
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertPositive(J)V

    .line 139
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->customLeeways:Ljava/util/Map;

    const-string v1, "exp"

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 140
    return-object p0
.end method

.method public acceptIssuedAt(J)Lcom/auth0/jwt/interfaces/Verification;
    .locals 3
    .param p1, "leeway"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 152
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertPositive(J)V

    .line 153
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->customLeeways:Ljava/util/Map;

    const-string v1, "iat"

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 154
    return-object p0
.end method

.method public acceptLeeway(J)Lcom/auth0/jwt/interfaces/Verification;
    .locals 0
    .param p1, "leeway"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 131
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertPositive(J)V

    .line 132
    iput-wide p1, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->defaultLeeway:J

    .line 133
    return-object p0
.end method

.method public acceptNotBefore(J)Lcom/auth0/jwt/interfaces/Verification;
    .locals 3
    .param p1, "leeway"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 145
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertPositive(J)V

    .line 146
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->customLeeways:Ljava/util/Map;

    const-string v1, "nbf"

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 147
    return-object p0
.end method

.method public build()Lcom/auth0/jwt/JWTVerifier;
    .locals 1

    .line 276
    invoke-static {}, Ljava/time/Clock;->systemUTC()Ljava/time/Clock;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->build(Ljava/time/Clock;)Lcom/auth0/jwt/JWTVerifier;

    move-result-object v0

    return-object v0
.end method

.method public build(Ljava/time/Clock;)Lcom/auth0/jwt/JWTVerifier;
    .locals 3
    .param p1, "clock"    # Ljava/time/Clock;

    .line 287
    iput-object p1, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->clock:Ljava/time/Clock;

    .line 288
    invoke-direct {p0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addMandatoryClaimChecks()V

    .line 289
    new-instance v0, Lcom/auth0/jwt/JWTVerifier;

    iget-object v1, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->algorithm:Lcom/auth0/jwt/algorithms/Algorithm;

    iget-object v2, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->expectedChecks:Ljava/util/List;

    invoke-direct {v0, v1, v2}, Lcom/auth0/jwt/JWTVerifier;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/util/List;)V

    return-object v0
.end method

.method public getLeewayFor(Ljava/lang/String;)J
    .locals 3
    .param p1, "name"    # Ljava/lang/String;

    .line 299
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->customLeeways:Ljava/util/Map;

    iget-wide v1, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->defaultLeeway:J

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->getOrDefault(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    return-wide v0
.end method

.method public ignoreIssuedAt()Lcom/auth0/jwt/interfaces/Verification;
    .locals 1

    .line 159
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->ignoreIssuedAt:Z

    .line 160
    return-object p0
.end method

.method synthetic lambda$addMandatoryClaimChecks$17$com-auth0-jwt-JWTVerifier$BaseVerification(JLcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 6
    .param p1, "expiresAtLeeway"    # J
    .param p3, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p4, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 308
    const-string v1, "exp"

    const/4 v5, 0x1

    move-object v0, p0

    move-object v2, p3

    move-wide v3, p1

    invoke-direct/range {v0 .. v5}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertValidInstantClaim(Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;JZ)Z

    move-result v0

    return v0
.end method

.method synthetic lambda$addMandatoryClaimChecks$18$com-auth0-jwt-JWTVerifier$BaseVerification(JLcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 6
    .param p1, "notBeforeLeeway"    # J
    .param p3, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p4, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 310
    const-string v1, "nbf"

    const/4 v5, 0x0

    move-object v0, p0

    move-object v2, p3

    move-wide v3, p1

    invoke-direct/range {v0 .. v5}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertValidInstantClaim(Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;JZ)Z

    move-result v0

    return v0
.end method

.method synthetic lambda$addMandatoryClaimChecks$19$com-auth0-jwt-JWTVerifier$BaseVerification(JLcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 6
    .param p1, "issuedAtLeeway"    # J
    .param p3, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p4, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 313
    const-string v1, "iat"

    const/4 v5, 0x0

    move-object v0, p0

    move-object v2, p3

    move-wide v3, p1

    invoke-direct/range {v0 .. v5}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertValidInstantClaim(Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;JZ)Z

    move-result v0

    return v0
.end method

.method synthetic lambda$withAnyOfAudience$3$com-auth0-jwt-JWTVerifier$BaseVerification(Ljava/util/List;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 3
    .param p1, "value"    # Ljava/util/List;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 117
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 118
    return v1

    .line 120
    :cond_0
    invoke-interface {p3}, Lcom/auth0/jwt/interfaces/DecodedJWT;->getAudience()Ljava/util/List;

    move-result-object v0

    const/4 v2, 0x0

    invoke-direct {p0, v0, p1, v2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertValidAudienceClaim(Ljava/util/List;Ljava/util/List;Z)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 124
    return v1

    .line 121
    :cond_1
    new-instance v0, Lcom/auth0/jwt/exceptions/IncorrectClaimException;

    const-string v1, "The Claim \'aud\' value doesn\'t contain the required audience."

    const-string v2, "aud"

    invoke-direct {v0, v1, v2, p2}, Lcom/auth0/jwt/exceptions/IncorrectClaimException;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;)V

    throw v0
.end method

.method synthetic lambda$withArrayClaim$14$com-auth0-jwt-JWTVerifier$BaseVerification([Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p1, "items"    # [Ljava/lang/String;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 253
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 254
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertValidCollectionClaim(Lcom/auth0/jwt/interfaces/Claim;[Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 253
    :goto_1
    return v0
.end method

.method synthetic lambda$withArrayClaim$15$com-auth0-jwt-JWTVerifier$BaseVerification([Ljava/lang/Integer;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p1, "items"    # [Ljava/lang/Integer;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 261
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 262
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertValidCollectionClaim(Lcom/auth0/jwt/interfaces/Claim;[Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 261
    :goto_1
    return v0
.end method

.method synthetic lambda$withArrayClaim$16$com-auth0-jwt-JWTVerifier$BaseVerification([Ljava/lang/Long;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p1, "items"    # [Ljava/lang/Long;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 269
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 270
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertValidCollectionClaim(Lcom/auth0/jwt/interfaces/Claim;[Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 269
    :goto_1
    return v0
.end method

.method synthetic lambda$withAudience$2$com-auth0-jwt-JWTVerifier$BaseVerification(Ljava/util/List;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 3
    .param p1, "value"    # Ljava/util/List;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 101
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 102
    return v1

    .line 104
    :cond_0
    invoke-interface {p3}, Lcom/auth0/jwt/interfaces/DecodedJWT;->getAudience()Ljava/util/List;

    move-result-object v0

    invoke-direct {p0, v0, p1, v1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertValidAudienceClaim(Ljava/util/List;Ljava/util/List;Z)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 108
    return v1

    .line 105
    :cond_1
    new-instance v0, Lcom/auth0/jwt/exceptions/IncorrectClaimException;

    const-string v1, "The Claim \'aud\' value doesn\'t contain the required audience."

    const-string v2, "aud"

    invoke-direct {v0, v1, v2, p2}, Lcom/auth0/jwt/exceptions/IncorrectClaimException;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;)V

    throw v0
.end method

.method synthetic lambda$withClaim$10$com-auth0-jwt-JWTVerifier$BaseVerification(Ljava/lang/Double;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p1, "value"    # Ljava/lang/Double;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 212
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 213
    invoke-interface {p2}, Lcom/auth0/jwt/interfaces/Claim;->asDouble()Ljava/lang/Double;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/Double;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 212
    :goto_1
    return v0
.end method

.method synthetic lambda$withClaim$11$com-auth0-jwt-JWTVerifier$BaseVerification(Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p1, "value"    # Ljava/lang/String;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 220
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 221
    invoke-interface {p2}, Lcom/auth0/jwt/interfaces/Claim;->asString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 220
    :goto_1
    return v0
.end method

.method synthetic lambda$withClaim$12$com-auth0-jwt-JWTVerifier$BaseVerification(Ljava/time/Instant;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 2
    .param p1, "value"    # Ljava/time/Instant;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 236
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Ljava/time/temporal/ChronoUnit;->SECONDS:Ljava/time/temporal/ChronoUnit;

    .line 237
    invoke-virtual {p1, v0}, Ljava/time/Instant;->truncatedTo(Ljava/time/temporal/TemporalUnit;)Ljava/time/Instant;

    move-result-object v0

    invoke-interface {p2}, Lcom/auth0/jwt/interfaces/Claim;->asInstant()Ljava/time/Instant;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/time/Instant;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 236
    :goto_1
    return v0
.end method

.method synthetic lambda$withClaim$13$com-auth0-jwt-JWTVerifier$BaseVerification(Ljava/util/function/BiPredicate;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p1, "predicate"    # Ljava/util/function/BiPredicate;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 245
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 246
    invoke-interface {p1, p2, p3}, Ljava/util/function/BiPredicate;->test(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 245
    :goto_1
    return v0
.end method

.method synthetic lambda$withClaim$7$com-auth0-jwt-JWTVerifier$BaseVerification(Ljava/lang/Boolean;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p1, "value"    # Ljava/lang/Boolean;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 188
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 189
    invoke-interface {p2}, Lcom/auth0/jwt/interfaces/Claim;->asBoolean()Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 188
    :goto_1
    return v0
.end method

.method synthetic lambda$withClaim$8$com-auth0-jwt-JWTVerifier$BaseVerification(Ljava/lang/Integer;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p1, "value"    # Ljava/lang/Integer;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 196
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 197
    invoke-interface {p2}, Lcom/auth0/jwt/interfaces/Claim;->asInt()Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 196
    :goto_1
    return v0
.end method

.method synthetic lambda$withClaim$9$com-auth0-jwt-JWTVerifier$BaseVerification(Ljava/lang/Long;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p1, "value"    # Ljava/lang/Long;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 204
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 205
    invoke-interface {p2}, Lcom/auth0/jwt/interfaces/Claim;->asLong()Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/Long;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 204
    :goto_1
    return v0
.end method

.method synthetic lambda$withIssuer$0$com-auth0-jwt-JWTVerifier$BaseVerification(Ljava/util/List;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 3
    .param p1, "value"    # Ljava/util/List;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 78
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 79
    return v1

    .line 81
    :cond_0
    if-eqz p1, :cond_1

    invoke-interface {p2}, Lcom/auth0/jwt/interfaces/Claim;->asString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 85
    return v1

    .line 82
    :cond_1
    new-instance v0, Lcom/auth0/jwt/exceptions/IncorrectClaimException;

    const-string v1, "The Claim \'iss\' value doesn\'t match the required issuer."

    const-string v2, "iss"

    invoke-direct {v0, v1, v2, p2}, Lcom/auth0/jwt/exceptions/IncorrectClaimException;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;)V

    throw v0
.end method

.method synthetic lambda$withJWTId$4$com-auth0-jwt-JWTVerifier$BaseVerification(Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p1, "jwtId"    # Ljava/lang/String;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 166
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-interface {p2}, Lcom/auth0/jwt/interfaces/Claim;->asString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method synthetic lambda$withSubject$1$com-auth0-jwt-JWTVerifier$BaseVerification(Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z
    .locals 1
    .param p1, "subject"    # Ljava/lang/String;
    .param p2, "claim"    # Lcom/auth0/jwt/interfaces/Claim;
    .param p3, "decodedJWT"    # Lcom/auth0/jwt/interfaces/DecodedJWT;

    .line 93
    invoke-direct {p0, p2, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->verifyNull(Lcom/auth0/jwt/interfaces/Claim;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-interface {p2}, Lcom/auth0/jwt/interfaces/Claim;->asString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method public varargs withAnyOfAudience([Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 3
    .param p1, "audience"    # [Ljava/lang/String;

    .line 115
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->isNullOrEmpty([Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    .line 116
    .local v0, "value":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    :goto_0
    new-instance v1, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda15;

    invoke-direct {v1, p0, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda15;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/util/List;)V

    const-string v2, "aud"

    invoke-direct {p0, v2, v1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 126
    return-object p0
.end method

.method public varargs withArrayClaim(Ljava/lang/String;[Ljava/lang/Integer;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "items"    # [Ljava/lang/Integer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 260
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertNonNull(Ljava/lang/String;)V

    .line 261
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda14;

    invoke-direct {v0, p0, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda14;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;[Ljava/lang/Integer;)V

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 263
    return-object p0
.end method

.method public varargs withArrayClaim(Ljava/lang/String;[Ljava/lang/Long;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "items"    # [Ljava/lang/Long;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 268
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertNonNull(Ljava/lang/String;)V

    .line 269
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda11;

    invoke-direct {v0, p0, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda11;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;[Ljava/lang/Long;)V

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 271
    return-object p0
.end method

.method public varargs withArrayClaim(Ljava/lang/String;[Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "items"    # [Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 252
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertNonNull(Ljava/lang/String;)V

    .line 253
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda9;

    invoke-direct {v0, p0, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda9;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;[Ljava/lang/String;)V

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 255
    return-object p0
.end method

.method public varargs withAudience([Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 3
    .param p1, "audience"    # [Ljava/lang/String;

    .line 99
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->isNullOrEmpty([Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    .line 100
    .local v0, "value":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    :goto_0
    new-instance v1, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda0;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/util/List;)V

    const-string v2, "aud"

    invoke-direct {p0, v2, v1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 110
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/lang/Boolean;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Boolean;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 187
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertNonNull(Ljava/lang/String;)V

    .line 188
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda10;

    invoke-direct {v0, p0, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda10;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/lang/Boolean;)V

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 190
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/lang/Double;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Double;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 211
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertNonNull(Ljava/lang/String;)V

    .line 212
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda13;

    invoke-direct {v0, p0, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda13;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/lang/Double;)V

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 214
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/lang/Integer;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Integer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 195
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertNonNull(Ljava/lang/String;)V

    .line 196
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda20;

    invoke-direct {v0, p0, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda20;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/lang/Integer;)V

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 198
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/lang/Long;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Long;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 203
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertNonNull(Ljava/lang/String;)V

    .line 204
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda16;

    invoke-direct {v0, p0, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda16;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/lang/Long;)V

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 206
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 219
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertNonNull(Ljava/lang/String;)V

    .line 220
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda1;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/lang/String;)V

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 222
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/time/Instant;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/time/Instant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 232
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertNonNull(Ljava/lang/String;)V

    .line 235
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda5;

    invoke-direct {v0, p0, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda5;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/time/Instant;)V

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 238
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/util/Date;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/util/Date;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 227
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/util/Date;->toInstant()Ljava/time/Instant;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->withClaim(Ljava/lang/String;Ljava/time/Instant;)Lcom/auth0/jwt/interfaces/Verification;

    move-result-object v0

    return-object v0
.end method

.method public withClaim(Ljava/lang/String;Ljava/util/function/BiPredicate;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/function/BiPredicate<",
            "Lcom/auth0/jwt/interfaces/Claim;",
            "Lcom/auth0/jwt/interfaces/DecodedJWT;",
            ">;)",
            "Lcom/auth0/jwt/interfaces/Verification;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 244
    .local p2, "predicate":Ljava/util/function/BiPredicate;, "Ljava/util/function/BiPredicate<Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;>;"
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertNonNull(Ljava/lang/String;)V

    .line 245
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda17;

    invoke-direct {v0, p0, p2}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda17;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/util/function/BiPredicate;)V

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 247
    return-object p0
.end method

.method public withClaimPresence(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 172
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertNonNull(Ljava/lang/String;)V

    .line 174
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda2;

    invoke-direct {v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda2;-><init>()V

    invoke-virtual {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->withClaim(Ljava/lang/String;Ljava/util/function/BiPredicate;)Lcom/auth0/jwt/interfaces/Verification;

    .line 175
    return-object p0
.end method

.method public varargs withIssuer([Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 3
    .param p1, "issuer"    # [Ljava/lang/String;

    .line 76
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->isNullOrEmpty([Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    .line 77
    .local v0, "value":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    :goto_0
    new-instance v1, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda12;

    invoke-direct {v1, p0, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda12;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/util/List;)V

    const-string v2, "iss"

    invoke-direct {p0, v2, v1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 87
    return-object p0
.end method

.method public withJWTId(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 2
    .param p1, "jwtId"    # Ljava/lang/String;

    .line 165
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda3;

    invoke-direct {v0, p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda3;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/lang/String;)V

    const-string v1, "jti"

    invoke-direct {p0, v1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 167
    return-object p0
.end method

.method public withNullClaim(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 180
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->assertNonNull(Ljava/lang/String;)V

    .line 181
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda4;

    invoke-direct {v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda4;-><init>()V

    invoke-virtual {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->withClaim(Ljava/lang/String;Ljava/util/function/BiPredicate;)Lcom/auth0/jwt/interfaces/Verification;

    .line 182
    return-object p0
.end method

.method public withSubject(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 2
    .param p1, "subject"    # Ljava/lang/String;

    .line 92
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda19;

    invoke-direct {v0, p0, p1}, Lcom/auth0/jwt/JWTVerifier$BaseVerification$$ExternalSyntheticLambda19;-><init>(Lcom/auth0/jwt/JWTVerifier$BaseVerification;Ljava/lang/String;)V

    const-string/jumbo v1, "sub"

    invoke-direct {p0, v1, v0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;->addCheck(Ljava/lang/String;Ljava/util/function/BiPredicate;)V

    .line 94
    return-object p0
.end method
