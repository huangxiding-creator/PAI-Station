.class Lcom/auth0/jwt/impl/JsonNodeClaim;
.super Ljava/lang/Object;
.source "JsonNodeClaim.java"

# interfaces
.implements Lcom/auth0/jwt/interfaces/Claim;


# instance fields
.field private final codec:Lcom/fasterxml/jackson/core/ObjectCodec;

.field private final data:Lcom/fasterxml/jackson/databind/JsonNode;


# direct methods
.method private constructor <init>(Lcom/fasterxml/jackson/databind/JsonNode;Lcom/fasterxml/jackson/core/ObjectCodec;)V
    .locals 0
    .param p1, "node"    # Lcom/fasterxml/jackson/databind/JsonNode;
    .param p2, "codec"    # Lcom/fasterxml/jackson/core/ObjectCodec;

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    iput-object p1, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    .line 29
    iput-object p2, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->codec:Lcom/fasterxml/jackson/core/ObjectCodec;

    .line 30
    return-void
.end method

.method static claimFromNode(Lcom/fasterxml/jackson/databind/JsonNode;Lcom/fasterxml/jackson/core/ObjectCodec;)Lcom/auth0/jwt/interfaces/Claim;
    .locals 1
    .param p0, "node"    # Lcom/fasterxml/jackson/databind/JsonNode;
    .param p1, "objectCodec"    # Lcom/fasterxml/jackson/core/ObjectCodec;

    .line 179
    new-instance v0, Lcom/auth0/jwt/impl/JsonNodeClaim;

    invoke-direct {v0, p0, p1}, Lcom/auth0/jwt/impl/JsonNodeClaim;-><init>(Lcom/fasterxml/jackson/databind/JsonNode;Lcom/fasterxml/jackson/core/ObjectCodec;)V

    return-object v0
.end method

.method static extractClaim(Ljava/lang/String;Ljava/util/Map;Lcom/fasterxml/jackson/core/ObjectCodec;)Lcom/auth0/jwt/interfaces/Claim;
    .locals 2
    .param p0, "claimName"    # Ljava/lang/String;
    .param p2, "objectCodec"    # Lcom/fasterxml/jackson/core/ObjectCodec;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/fasterxml/jackson/databind/JsonNode;",
            ">;",
            "Lcom/fasterxml/jackson/core/ObjectCodec;",
            ")",
            "Lcom/auth0/jwt/interfaces/Claim;"
        }
    .end annotation

    .line 167
    .local p1, "tree":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;>;"
    invoke-interface {p1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/JsonNode;

    .line 168
    .local v0, "node":Lcom/fasterxml/jackson/databind/JsonNode;
    invoke-static {v0, p2}, Lcom/auth0/jwt/impl/JsonNodeClaim;->claimFromNode(Lcom/fasterxml/jackson/databind/JsonNode;Lcom/fasterxml/jackson/core/ObjectCodec;)Lcom/auth0/jwt/interfaces/Claim;

    move-result-object v1

    return-object v1
.end method


# virtual methods
.method public as(Ljava/lang/Class;)Ljava/lang/Object;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)TT;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation

    .line 129
    .local p1, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<TT;>;"
    :try_start_0
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isMissing()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isNull()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 132
    :cond_0
    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->codec:Lcom/fasterxml/jackson/core/ObjectCodec;

    iget-object v1, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0, v1, p1}, Lcom/fasterxml/jackson/core/ObjectCodec;->treeToValue(Lcom/fasterxml/jackson/core/TreeNode;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catch Lcom/fasterxml/jackson/core/JsonProcessingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 130
    :cond_1
    :goto_0
    const/4 v0, 0x0

    return-object v0

    .line 133
    :catch_0
    move-exception v0

    .line 134
    .local v0, "e":Lcom/fasterxml/jackson/core/JsonProcessingException;
    new-instance v1, Lcom/auth0/jwt/exceptions/JWTDecodeException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Couldn\'t map the Claim value to "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Lcom/auth0/jwt/exceptions/JWTDecodeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public asArray(Ljava/lang/Class;)[Ljava/lang/Object;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)[TT;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation

    .line 78
    .local p1, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<TT;>;"
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isMissing()Z

    move-result v0

    if-nez v0, :cond_2

    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isNull()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isArray()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    .line 82
    :cond_0
    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->size()I

    move-result v0

    invoke-static {p1, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/Object;

    .line 83
    .local v0, "arr":[Ljava/lang/Object;, "[TT;"
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget-object v2, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/databind/JsonNode;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    .line 85
    :try_start_0
    iget-object v2, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->codec:Lcom/fasterxml/jackson/core/ObjectCodec;

    iget-object v3, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v3, v1}, Lcom/fasterxml/jackson/databind/JsonNode;->get(I)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v3

    invoke-virtual {v2, v3, p1}, Lcom/fasterxml/jackson/core/ObjectCodec;->treeToValue(Lcom/fasterxml/jackson/core/TreeNode;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    aput-object v2, v0, v1
    :try_end_0
    .catch Lcom/fasterxml/jackson/core/JsonProcessingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 88
    nop

    .line 83
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 86
    :catch_0
    move-exception v2

    .line 87
    .local v2, "e":Lcom/fasterxml/jackson/core/JsonProcessingException;
    new-instance v3, Lcom/auth0/jwt/exceptions/JWTDecodeException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Couldn\'t map the Claim\'s array contents to "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4, v2}, Lcom/auth0/jwt/exceptions/JWTDecodeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v3

    .line 90
    .end local v1    # "i":I
    .end local v2    # "e":Lcom/fasterxml/jackson/core/JsonProcessingException;
    :cond_1
    return-object v0

    .line 79
    .end local v0    # "arr":[Ljava/lang/Object;, "[TT;"
    :cond_2
    :goto_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public asBoolean()Ljava/lang/Boolean;
    .locals 1

    .line 34
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isMissing()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isNull()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isBoolean()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->asBoolean()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x0

    :goto_1
    return-object v0
.end method

.method public asDate()Ljava/util/Date;
    .locals 5

    .line 59
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isMissing()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isNull()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->canConvertToLong()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 62
    :cond_0
    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->asLong()J

    move-result-wide v0

    .line 63
    .local v0, "seconds":J
    new-instance v2, Ljava/util/Date;

    const-wide/16 v3, 0x3e8

    mul-long/2addr v3, v0

    invoke-direct {v2, v3, v4}, Ljava/util/Date;-><init>(J)V

    return-object v2

    .line 60
    .end local v0    # "seconds":J
    :cond_1
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public asDouble()Ljava/lang/Double;
    .locals 2

    .line 49
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isMissing()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isNull()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isNumber()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->asDouble()D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x0

    :goto_1
    return-object v0
.end method

.method public asInstant()Ljava/time/Instant;
    .locals 3

    .line 68
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isMissing()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isNull()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->canConvertToLong()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 71
    :cond_0
    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->asLong()J

    move-result-wide v0

    .line 72
    .local v0, "seconds":J
    invoke-static {v0, v1}, Ljava/time/Instant;->ofEpochSecond(J)Ljava/time/Instant;

    move-result-object v2

    return-object v2

    .line 69
    .end local v0    # "seconds":J
    :cond_1
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public asInt()Ljava/lang/Integer;
    .locals 1

    .line 39
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isMissing()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isNull()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isNumber()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->asInt()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x0

    :goto_1
    return-object v0
.end method

.method public asList(Ljava/lang/Class;)Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)",
            "Ljava/util/List<",
            "TT;>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation

    .line 95
    .local p1, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<TT;>;"
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isMissing()Z

    move-result v0

    if-nez v0, :cond_2

    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isNull()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isArray()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    .line 99
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 100
    .local v0, "list":Ljava/util/List;, "Ljava/util/List<TT;>;"
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget-object v2, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/databind/JsonNode;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    .line 102
    :try_start_0
    iget-object v2, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->codec:Lcom/fasterxml/jackson/core/ObjectCodec;

    iget-object v3, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v3, v1}, Lcom/fasterxml/jackson/databind/JsonNode;->get(I)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v3

    invoke-virtual {v2, v3, p1}, Lcom/fasterxml/jackson/core/ObjectCodec;->treeToValue(Lcom/fasterxml/jackson/core/TreeNode;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Lcom/fasterxml/jackson/core/JsonProcessingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 105
    nop

    .line 100
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 103
    :catch_0
    move-exception v2

    .line 104
    .local v2, "e":Lcom/fasterxml/jackson/core/JsonProcessingException;
    new-instance v3, Lcom/auth0/jwt/exceptions/JWTDecodeException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Couldn\'t map the Claim\'s array contents to "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4, v2}, Lcom/auth0/jwt/exceptions/JWTDecodeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v3

    .line 107
    .end local v1    # "i":I
    .end local v2    # "e":Lcom/fasterxml/jackson/core/JsonProcessingException;
    :cond_1
    return-object v0

    .line 96
    .end local v0    # "list":Ljava/util/List;, "Ljava/util/List<TT;>;"
    :cond_2
    :goto_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public asLong()Ljava/lang/Long;
    .locals 2

    .line 44
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isMissing()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isNull()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isNumber()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->asLong()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x0

    :goto_1
    return-object v0
.end method

.method public asMap()Ljava/util/Map;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation

    .line 112
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isMissing()Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isNull()Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isObject()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    .line 116
    :cond_0
    new-instance v0, Lcom/auth0/jwt/impl/JsonNodeClaim$1;

    invoke-direct {v0, p0}, Lcom/auth0/jwt/impl/JsonNodeClaim$1;-><init>(Lcom/auth0/jwt/impl/JsonNodeClaim;)V

    .line 119
    .local v0, "mapType":Lcom/fasterxml/jackson/core/type/TypeReference;, "Lcom/fasterxml/jackson/core/type/TypeReference<Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;>;"
    :try_start_0
    iget-object v1, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->codec:Lcom/fasterxml/jackson/core/ObjectCodec;

    iget-object v2, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v1, v2}, Lcom/fasterxml/jackson/core/ObjectCodec;->treeAsTokens(Lcom/fasterxml/jackson/core/TreeNode;)Lcom/fasterxml/jackson/core/JsonParser;

    move-result-object v1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 120
    .local v1, "parser":Lcom/fasterxml/jackson/core/JsonParser;
    :try_start_1
    invoke-virtual {v1, v0}, Lcom/fasterxml/jackson/core/JsonParser;->readValueAs(Lcom/fasterxml/jackson/core/type/TypeReference;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 121
    if-eqz v1, :cond_1

    :try_start_2
    invoke-virtual {v1}, Lcom/fasterxml/jackson/core/JsonParser;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 120
    :cond_1
    return-object v2

    .line 119
    :catchall_0
    move-exception v2

    if-eqz v1, :cond_2

    :try_start_3
    invoke-virtual {v1}, Lcom/fasterxml/jackson/core/JsonParser;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception v3

    :try_start_4
    invoke-virtual {v2, v3}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v0    # "mapType":Lcom/fasterxml/jackson/core/type/TypeReference;, "Lcom/fasterxml/jackson/core/type/TypeReference<Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;>;"
    :cond_2
    :goto_0
    throw v2
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0

    .line 121
    .end local v1    # "parser":Lcom/fasterxml/jackson/core/JsonParser;
    .restart local v0    # "mapType":Lcom/fasterxml/jackson/core/type/TypeReference;, "Lcom/fasterxml/jackson/core/type/TypeReference<Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;>;"
    :catch_0
    move-exception v1

    .line 122
    .local v1, "e":Ljava/io/IOException;
    new-instance v2, Lcom/auth0/jwt/exceptions/JWTDecodeException;

    const-string v3, "Couldn\'t map the Claim value to Map"

    invoke-direct {v2, v3, v1}, Lcom/auth0/jwt/exceptions/JWTDecodeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    .line 113
    .end local v0    # "mapType":Lcom/fasterxml/jackson/core/type/TypeReference;, "Lcom/fasterxml/jackson/core/type/TypeReference<Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;>;"
    .end local v1    # "e":Ljava/io/IOException;
    :cond_3
    :goto_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public asString()Ljava/lang/String;
    .locals 1

    .line 54
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isMissing()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isNull()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isTextual()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->asText()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x0

    :goto_1
    return-object v0
.end method

.method public isMissing()Z
    .locals 1

    .line 145
    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isMissingNode()Z

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

.method public isNull()Z
    .locals 1

    .line 140
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isMissing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isNull()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 150
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isMissing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 151
    const-string v0, "Missing claim"

    return-object v0

    .line 152
    :cond_0
    invoke-virtual {p0}, Lcom/auth0/jwt/impl/JsonNodeClaim;->isNull()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 153
    const-string v0, "Null claim"

    return-object v0

    .line 155
    :cond_1
    iget-object v0, p0, Lcom/auth0/jwt/impl/JsonNodeClaim;->data:Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
