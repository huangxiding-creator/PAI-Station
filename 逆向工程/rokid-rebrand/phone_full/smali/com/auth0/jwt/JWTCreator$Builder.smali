.class public Lcom/auth0/jwt/JWTCreator$Builder;
.super Ljava/lang/Object;
.source "JWTCreator.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/auth0/jwt/JWTCreator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field private final headerClaims:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private final payloadClaims:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>()V
    .locals 1

    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 74
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v0, p0, Lcom/auth0/jwt/JWTCreator$Builder;->payloadClaims:Ljava/util/Map;

    .line 75
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v0, p0, Lcom/auth0/jwt/JWTCreator$Builder;->headerClaims:Ljava/util/Map;

    .line 76
    return-void
.end method

.method private addClaim(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 615
    iget-object v0, p0, Lcom/auth0/jwt/JWTCreator$Builder;->payloadClaims:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 616
    return-void
.end method

.method private assertNonNull(Ljava/lang/String;)V
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 609
    if-eqz p1, :cond_0

    .line 612
    return-void

    .line 610
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The Custom Claim\'s name can\'t be null."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static isBasicType(Ljava/lang/Object;)Z
    .locals 4
    .param p0, "value"    # Ljava/lang/Object;

    .line 571
    const/4 v0, 0x1

    if-nez p0, :cond_0

    .line 572
    return v0

    .line 574
    :cond_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    .line 576
    .local v1, "c":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-virtual {v1}, Ljava/lang/Class;->isArray()Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_3

    .line 577
    const-class v2, [Ljava/lang/Integer;

    if-eq v1, v2, :cond_2

    const-class v2, [Ljava/lang/Long;

    if-eq v1, v2, :cond_2

    const-class v2, [Ljava/lang/String;

    if-ne v1, v2, :cond_1

    goto :goto_0

    :cond_1
    move v0, v3

    :cond_2
    :goto_0
    return v0

    .line 579
    :cond_3
    const-class v2, Ljava/lang/String;

    if-eq v1, v2, :cond_5

    const-class v2, Ljava/lang/Integer;

    if-eq v1, v2, :cond_5

    const-class v2, Ljava/lang/Long;

    if-eq v1, v2, :cond_5

    const-class v2, Ljava/lang/Double;

    if-eq v1, v2, :cond_5

    const-class v2, Ljava/util/Date;

    if-eq v1, v2, :cond_5

    const-class v2, Ljava/time/Instant;

    if-eq v1, v2, :cond_5

    const-class v2, Ljava/lang/Boolean;

    if-ne v1, v2, :cond_4

    goto :goto_1

    :cond_4
    move v0, v3

    :cond_5
    :goto_1
    return v0
.end method

.method private static isSupportedType(Ljava/lang/Object;)Z
    .locals 1
    .param p0, "value"    # Ljava/lang/Object;

    .line 561
    instance-of v0, p0, Ljava/util/List;

    if-eqz v0, :cond_0

    .line 562
    move-object v0, p0

    check-cast v0, Ljava/util/List;

    invoke-static {v0}, Lcom/auth0/jwt/JWTCreator$Builder;->validateClaim(Ljava/util/List;)Z

    move-result v0

    return v0

    .line 563
    :cond_0
    instance-of v0, p0, Ljava/util/Map;

    if-eqz v0, :cond_1

    .line 564
    move-object v0, p0

    check-cast v0, Ljava/util/Map;

    invoke-static {v0}, Lcom/auth0/jwt/JWTCreator$Builder;->validateClaim(Ljava/util/Map;)Z

    move-result v0

    return v0

    .line 566
    :cond_1
    invoke-static {p0}, Lcom/auth0/jwt/JWTCreator$Builder;->isBasicType(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method private static validateClaim(Ljava/util/List;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "*>;)Z"
        }
    .end annotation

    .line 552
    .local p0, "list":Ljava/util/List;, "Ljava/util/List<*>;"
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    .line 553
    .local v1, "object":Ljava/lang/Object;
    invoke-static {v1}, Lcom/auth0/jwt/JWTCreator$Builder;->isSupportedType(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 554
    const/4 v0, 0x0

    return v0

    .line 556
    .end local v1    # "object":Ljava/lang/Object;
    :cond_0
    goto :goto_0

    .line 557
    :cond_1
    const/4 v0, 0x1

    return v0
.end method

.method private static validateClaim(Ljava/util/Map;)Z
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "**>;)Z"
        }
    .end annotation

    .line 537
    .local p0, "map":Ljava/util/Map;, "Ljava/util/Map<**>;"
    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 538
    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<**>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    .line 539
    .local v2, "value":Ljava/lang/Object;
    invoke-static {v2}, Lcom/auth0/jwt/JWTCreator$Builder;->isSupportedType(Ljava/lang/Object;)Z

    move-result v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    .line 540
    return v4

    .line 543
    :cond_0
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    instance-of v3, v3, Ljava/lang/String;

    if-nez v3, :cond_1

    .line 544
    return v4

    .line 546
    .end local v1    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<**>;"
    .end local v2    # "value":Ljava/lang/Object;
    :cond_1
    goto :goto_0

    .line 547
    :cond_2
    const/4 v0, 0x1

    return v0
.end method

.method private validatePayload(Ljava/util/Map;)Z
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "*>;)Z"
        }
    .end annotation

    .line 519
    .local p1, "payload":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;*>;"
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 520
    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;*>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 521
    .local v2, "key":Ljava/lang/String;
    invoke-direct {p0, v2}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 523
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    .line 524
    .local v3, "value":Ljava/lang/Object;
    instance-of v4, v3, Ljava/util/List;

    const/4 v5, 0x0

    if-eqz v4, :cond_0

    move-object v4, v3

    check-cast v4, Ljava/util/List;

    invoke-static {v4}, Lcom/auth0/jwt/JWTCreator$Builder;->validateClaim(Ljava/util/List;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 525
    return v5

    .line 526
    :cond_0
    instance-of v4, v3, Ljava/util/Map;

    if-eqz v4, :cond_1

    move-object v4, v3

    check-cast v4, Ljava/util/Map;

    invoke-static {v4}, Lcom/auth0/jwt/JWTCreator$Builder;->validateClaim(Ljava/util/Map;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 527
    return v5

    .line 528
    :cond_1
    invoke-static {v3}, Lcom/auth0/jwt/JWTCreator$Builder;->isSupportedType(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 529
    return v5

    .line 531
    .end local v1    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;*>;"
    .end local v2    # "key":Ljava/lang/String;
    .end local v3    # "value":Ljava/lang/Object;
    :cond_2
    goto :goto_0

    .line 532
    :cond_3
    const/4 v0, 0x1

    return v0
.end method


# virtual methods
.method public sign(Lcom/auth0/jwt/algorithms/Algorithm;)Ljava/lang/String;
    .locals 5
    .param p1, "algorithm"    # Lcom/auth0/jwt/algorithms/Algorithm;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;,
            Lcom/auth0/jwt/exceptions/JWTCreationException;
        }
    .end annotation

    .line 594
    if-eqz p1, :cond_2

    .line 597
    iget-object v0, p0, Lcom/auth0/jwt/JWTCreator$Builder;->headerClaims:Ljava/util/Map;

    const-string v1, "alg"

    invoke-virtual {p1}, Lcom/auth0/jwt/algorithms/Algorithm;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 598
    iget-object v0, p0, Lcom/auth0/jwt/JWTCreator$Builder;->headerClaims:Ljava/util/Map;

    const-string/jumbo v1, "typ"

    invoke-interface {v0, v1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 599
    iget-object v0, p0, Lcom/auth0/jwt/JWTCreator$Builder;->headerClaims:Ljava/util/Map;

    const-string v2, "JWT"

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 601
    :cond_0
    invoke-virtual {p1}, Lcom/auth0/jwt/algorithms/Algorithm;->getSigningKeyId()Ljava/lang/String;

    move-result-object v0

    .line 602
    .local v0, "signingKeyId":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 603
    invoke-virtual {p0, v0}, Lcom/auth0/jwt/JWTCreator$Builder;->withKeyId(Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;

    .line 605
    :cond_1
    new-instance v1, Lcom/auth0/jwt/JWTCreator;

    iget-object v2, p0, Lcom/auth0/jwt/JWTCreator$Builder;->headerClaims:Ljava/util/Map;

    iget-object v3, p0, Lcom/auth0/jwt/JWTCreator$Builder;->payloadClaims:Ljava/util/Map;

    const/4 v4, 0x0

    invoke-direct {v1, p1, v2, v3, v4}, Lcom/auth0/jwt/JWTCreator;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/util/Map;Ljava/util/Map;Lcom/auth0/jwt/JWTCreator$1;)V

    invoke-static {v1}, Lcom/auth0/jwt/JWTCreator;->access$200(Lcom/auth0/jwt/JWTCreator;)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 595
    .end local v0    # "signingKeyId":Ljava/lang/String;
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The Algorithm cannot be null."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public withArrayClaim(Ljava/lang/String;[Ljava/lang/Integer;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "items"    # [Ljava/lang/Integer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 435
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 436
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 437
    return-object p0
.end method

.method public withArrayClaim(Ljava/lang/String;[Ljava/lang/Long;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "items"    # [Ljava/lang/Long;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 449
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 450
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 451
    return-object p0
.end method

.method public withArrayClaim(Ljava/lang/String;[Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "items"    # [Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 421
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 422
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 423
    return-object p0
.end method

.method public varargs withAudience([Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 1
    .param p1, "audience"    # [Ljava/lang/String;

    .line 164
    const-string v0, "aud"

    invoke-direct {p0, v0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 165
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/lang/Boolean;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Boolean;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 260
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 261
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 262
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/lang/Double;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Double;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 302
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 303
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 304
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/lang/Integer;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Integer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 274
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 275
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 276
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/lang/Long;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Long;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 288
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 289
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 290
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 316
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 317
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 318
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/time/Instant;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/time/Instant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 346
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 347
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 348
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/util/Date;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/util/Date;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 331
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 332
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 333
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/util/List;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "*>;)",
            "Lcom/auth0/jwt/JWTCreator$Builder;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 389
    .local p2, "list":Ljava/util/List;, "Ljava/util/List<*>;"
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 391
    if-eqz p2, :cond_1

    invoke-static {p2}, Lcom/auth0/jwt/JWTCreator$Builder;->validateClaim(Ljava/util/List;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 392
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Expected list containing Map, List, Boolean, Integer, Long, Double, String and Date"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 395
    :cond_1
    :goto_0
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 396
    return-object p0
.end method

.method public withClaim(Ljava/lang/String;Ljava/util/Map;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "*>;)",
            "Lcom/auth0/jwt/JWTCreator$Builder;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 365
    .local p2, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;*>;"
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 367
    if-eqz p2, :cond_1

    invoke-static {p2}, Lcom/auth0/jwt/JWTCreator$Builder;->validateClaim(Ljava/util/Map;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 368
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Expected map containing Map, List, Boolean, Integer, Long, Double, String and Date"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 371
    :cond_1
    :goto_0
    invoke-direct {p0, p1, p2}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 372
    return-object p0
.end method

.method public withExpiresAt(Ljava/time/Instant;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 1
    .param p1, "expiresAt"    # Ljava/time/Instant;

    .line 188
    const-string v0, "exp"

    invoke-direct {p0, v0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 189
    return-object p0
.end method

.method public withExpiresAt(Ljava/util/Date;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 1
    .param p1, "expiresAt"    # Ljava/util/Date;

    .line 176
    const-string v0, "exp"

    invoke-direct {p0, v0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 177
    return-object p0
.end method

.method public withHeader(Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 3
    .param p1, "headerClaimsJson"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 110
    if-nez p1, :cond_0

    .line 111
    return-object p0

    .line 115
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/auth0/jwt/JWTCreator;->access$000()Lcom/fasterxml/jackson/databind/ObjectMapper;

    move-result-object v0

    const-class v1, Ljava/util/LinkedHashMap;

    invoke-virtual {v0, p1, v1}, Lcom/fasterxml/jackson/databind/ObjectMapper;->readValue(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map;

    .line 116
    .local v0, "headerClaims":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;"
    invoke-virtual {p0, v0}, Lcom/auth0/jwt/JWTCreator$Builder;->withHeader(Ljava/util/Map;)Lcom/auth0/jwt/JWTCreator$Builder;

    move-result-object v1
    :try_end_0
    .catch Lcom/fasterxml/jackson/core/JsonProcessingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 117
    .end local v0    # "headerClaims":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;"
    :catch_0
    move-exception v0

    .line 118
    .local v0, "e":Lcom/fasterxml/jackson/core/JsonProcessingException;
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Invalid header JSON"

    invoke-direct {v1, v2, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public withHeader(Ljava/util/Map;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)",
            "Lcom/auth0/jwt/JWTCreator$Builder;"
        }
    .end annotation

    .line 86
    .local p1, "headerClaims":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;"
    if-nez p1, :cond_0

    .line 87
    return-object p0

    .line 90
    :cond_0
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 91
    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/Object;>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    if-nez v2, :cond_1

    .line 92
    iget-object v2, p0, Lcom/auth0/jwt/JWTCreator$Builder;->headerClaims:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 94
    :cond_1
    iget-object v2, p0, Lcom/auth0/jwt/JWTCreator$Builder;->headerClaims:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 96
    .end local v1    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/Object;>;"
    :goto_1
    goto :goto_0

    .line 98
    :cond_2
    return-object p0
.end method

.method public withIssuedAt(Ljava/time/Instant;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 1
    .param p1, "issuedAt"    # Ljava/time/Instant;

    .line 236
    const-string v0, "iat"

    invoke-direct {p0, v0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 237
    return-object p0
.end method

.method public withIssuedAt(Ljava/util/Date;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 1
    .param p1, "issuedAt"    # Ljava/util/Date;

    .line 224
    const-string v0, "iat"

    invoke-direct {p0, v0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 225
    return-object p0
.end method

.method public withIssuer(Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 1
    .param p1, "issuer"    # Ljava/lang/String;

    .line 142
    const-string v0, "iss"

    invoke-direct {p0, v0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 143
    return-object p0
.end method

.method public withJWTId(Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 1
    .param p1, "jwtId"    # Ljava/lang/String;

    .line 247
    const-string v0, "jti"

    invoke-direct {p0, v0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 248
    return-object p0
.end method

.method public withKeyId(Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 2
    .param p1, "keyId"    # Ljava/lang/String;

    .line 131
    iget-object v0, p0, Lcom/auth0/jwt/JWTCreator$Builder;->headerClaims:Ljava/util/Map;

    const-string v1, "kid"

    invoke-interface {v0, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 132
    return-object p0
.end method

.method public withNotBefore(Ljava/time/Instant;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 1
    .param p1, "notBefore"    # Ljava/time/Instant;

    .line 212
    const-string v0, "nbf"

    invoke-direct {p0, v0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 213
    return-object p0
.end method

.method public withNotBefore(Ljava/util/Date;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 1
    .param p1, "notBefore"    # Ljava/util/Date;

    .line 200
    const-string v0, "nbf"

    invoke-direct {p0, v0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 201
    return-object p0
.end method

.method public withNullClaim(Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 407
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->assertNonNull(Ljava/lang/String;)V

    .line 408
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 409
    return-object p0
.end method

.method public withPayload(Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 3
    .param p1, "payloadClaimsJson"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 506
    if-nez p1, :cond_0

    .line 507
    return-object p0

    .line 511
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/auth0/jwt/JWTCreator;->access$000()Lcom/fasterxml/jackson/databind/ObjectMapper;

    move-result-object v0

    const-class v1, Ljava/util/LinkedHashMap;

    invoke-virtual {v0, p1, v1}, Lcom/fasterxml/jackson/databind/ObjectMapper;->readValue(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map;

    .line 512
    .local v0, "payloadClaims":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;"
    invoke-virtual {p0, v0}, Lcom/auth0/jwt/JWTCreator$Builder;->withPayload(Ljava/util/Map;)Lcom/auth0/jwt/JWTCreator$Builder;

    move-result-object v1
    :try_end_0
    .catch Lcom/fasterxml/jackson/core/JsonProcessingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 513
    .end local v0    # "payloadClaims":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;"
    :catch_0
    move-exception v0

    .line 514
    .local v0, "e":Lcom/fasterxml/jackson/core/JsonProcessingException;
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Invalid payload JSON"

    invoke-direct {v1, v2, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public withPayload(Ljava/util/Map;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "*>;)",
            "Lcom/auth0/jwt/JWTCreator$Builder;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 474
    .local p1, "payloadClaims":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;*>;"
    if-nez p1, :cond_0

    .line 475
    return-object p0

    .line 478
    :cond_0
    invoke-direct {p0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->validatePayload(Ljava/util/Map;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 484
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 485
    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;*>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    invoke-direct {p0, v2, v3}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 486
    .end local v1    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;*>;"
    goto :goto_0

    .line 488
    :cond_1
    return-object p0

    .line 479
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Claim values must only be of types Map, List, Boolean, Integer, Long, Double, String, Date, Instant, and Null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public withSubject(Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 1
    .param p1, "subject"    # Ljava/lang/String;

    .line 153
    const-string/jumbo v0, "sub"

    invoke-direct {p0, v0, p1}, Lcom/auth0/jwt/JWTCreator$Builder;->addClaim(Ljava/lang/String;Ljava/lang/Object;)V

    .line 154
    return-object p0
.end method
