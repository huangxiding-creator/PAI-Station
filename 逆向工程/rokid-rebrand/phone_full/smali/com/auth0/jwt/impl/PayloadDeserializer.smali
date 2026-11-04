.class Lcom/auth0/jwt/impl/PayloadDeserializer;
.super Lcom/fasterxml/jackson/databind/deser/std/StdDeserializer;
.source "PayloadDeserializer.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/fasterxml/jackson/databind/deser/std/StdDeserializer<",
        "Lcom/auth0/jwt/interfaces/Payload;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 1

    .line 29
    const-class v0, Lcom/auth0/jwt/interfaces/Payload;

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/databind/deser/std/StdDeserializer;-><init>(Ljava/lang/Class;)V

    .line 30
    return-void
.end method


# virtual methods
.method public deserialize(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/auth0/jwt/interfaces/Payload;
    .locals 21
    .param p1, "p"    # Lcom/fasterxml/jackson/core/JsonParser;
    .param p2, "ctxt"    # Lcom/fasterxml/jackson/databind/DeserializationContext;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 34
    move-object/from16 v0, p0

    invoke-virtual/range {p1 .. p1}, Lcom/fasterxml/jackson/core/JsonParser;->getCodec()Lcom/fasterxml/jackson/core/ObjectCodec;

    move-result-object v1

    new-instance v2, Lcom/auth0/jwt/impl/PayloadDeserializer$1;

    invoke-direct {v2, v0}, Lcom/auth0/jwt/impl/PayloadDeserializer$1;-><init>(Lcom/auth0/jwt/impl/PayloadDeserializer;)V

    move-object/from16 v3, p1

    invoke-virtual {v1, v3, v2}, Lcom/fasterxml/jackson/core/ObjectCodec;->readValue(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/core/type/TypeReference;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map;

    .line 36
    .local v1, "tree":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;>;"
    if-eqz v1, :cond_0

    .line 40
    const-string v2, "iss"

    invoke-virtual {v0, v1, v2}, Lcom/auth0/jwt/impl/PayloadDeserializer;->getString(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 41
    .local v2, "issuer":Ljava/lang/String;
    const-string/jumbo v4, "sub"

    invoke-virtual {v0, v1, v4}, Lcom/auth0/jwt/impl/PayloadDeserializer;->getString(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 42
    .local v14, "subject":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/fasterxml/jackson/core/JsonParser;->getCodec()Lcom/fasterxml/jackson/core/ObjectCodec;

    move-result-object v4

    const-string v5, "aud"

    invoke-virtual {v0, v4, v1, v5}, Lcom/auth0/jwt/impl/PayloadDeserializer;->getStringOrArray(Lcom/fasterxml/jackson/core/ObjectCodec;Ljava/util/Map;Ljava/lang/String;)Ljava/util/List;

    move-result-object v15

    .line 43
    .local v15, "audience":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const-string v4, "exp"

    invoke-virtual {v0, v1, v4}, Lcom/auth0/jwt/impl/PayloadDeserializer;->getInstantFromSeconds(Ljava/util/Map;Ljava/lang/String;)Ljava/time/Instant;

    move-result-object v16

    .line 44
    .local v16, "expiresAt":Ljava/time/Instant;
    const-string v4, "nbf"

    invoke-virtual {v0, v1, v4}, Lcom/auth0/jwt/impl/PayloadDeserializer;->getInstantFromSeconds(Ljava/util/Map;Ljava/lang/String;)Ljava/time/Instant;

    move-result-object v17

    .line 45
    .local v17, "notBefore":Ljava/time/Instant;
    const-string v4, "iat"

    invoke-virtual {v0, v1, v4}, Lcom/auth0/jwt/impl/PayloadDeserializer;->getInstantFromSeconds(Ljava/util/Map;Ljava/lang/String;)Ljava/time/Instant;

    move-result-object v18

    .line 46
    .local v18, "issuedAt":Ljava/time/Instant;
    const-string v4, "jti"

    invoke-virtual {v0, v1, v4}, Lcom/auth0/jwt/impl/PayloadDeserializer;->getString(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v19

    .line 48
    .local v19, "jwtId":Ljava/lang/String;
    new-instance v20, Lcom/auth0/jwt/impl/PayloadImpl;

    invoke-virtual/range {p1 .. p1}, Lcom/fasterxml/jackson/core/JsonParser;->getCodec()Lcom/fasterxml/jackson/core/ObjectCodec;

    move-result-object v13

    move-object/from16 v4, v20

    move-object v5, v2

    move-object v6, v14

    move-object v7, v15

    move-object/from16 v8, v16

    move-object/from16 v9, v17

    move-object/from16 v10, v18

    move-object/from16 v11, v19

    move-object v12, v1

    invoke-direct/range {v4 .. v13}, Lcom/auth0/jwt/impl/PayloadImpl;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/time/Instant;Ljava/time/Instant;Ljava/time/Instant;Ljava/lang/String;Ljava/util/Map;Lcom/fasterxml/jackson/core/ObjectCodec;)V

    return-object v20

    .line 37
    .end local v2    # "issuer":Ljava/lang/String;
    .end local v14    # "subject":Ljava/lang/String;
    .end local v15    # "audience":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .end local v16    # "expiresAt":Ljava/time/Instant;
    .end local v17    # "notBefore":Ljava/time/Instant;
    .end local v18    # "issuedAt":Ljava/time/Instant;
    .end local v19    # "jwtId":Ljava/lang/String;
    :cond_0
    new-instance v2, Lcom/auth0/jwt/exceptions/JWTDecodeException;

    const-string v4, "Parsing the Payload\'s JSON resulted on a Null map"

    invoke-direct {v2, v4}, Lcom/auth0/jwt/exceptions/JWTDecodeException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public bridge synthetic deserialize(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/fasterxml/jackson/core/JacksonException;
        }
    .end annotation

    .line 26
    invoke-virtual {p0, p1, p2}, Lcom/auth0/jwt/impl/PayloadDeserializer;->deserialize(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/auth0/jwt/interfaces/Payload;

    move-result-object p1

    return-object p1
.end method

.method getInstantFromSeconds(Ljava/util/Map;Ljava/lang/String;)Ljava/time/Instant;
    .locals 4
    .param p2, "claimName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/fasterxml/jackson/databind/JsonNode;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/time/Instant;"
        }
    .end annotation

    .line 73
    .local p1, "tree":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;>;"
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/JsonNode;

    .line 74
    .local v0, "node":Lcom/fasterxml/jackson/databind/JsonNode;
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isNull()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 77
    :cond_0
    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->canConvertToLong()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 81
    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->asLong()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/time/Instant;->ofEpochSecond(J)Ljava/time/Instant;

    move-result-object v1

    return-object v1

    .line 78
    :cond_1
    new-instance v1, Lcom/auth0/jwt/exceptions/JWTDecodeException;

    filled-new-array {p2}, [Ljava/lang/Object;

    move-result-object v2

    .line 79
    const-string v3, "The claim \'%s\' contained a non-numeric date value."

    invoke-static {v3, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/auth0/jwt/exceptions/JWTDecodeException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 75
    :cond_2
    :goto_0
    const/4 v1, 0x0

    return-object v1
.end method

.method getString(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p2, "claimName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/fasterxml/jackson/databind/JsonNode;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 85
    .local p1, "tree":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;>;"
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/JsonNode;

    .line 86
    .local v0, "node":Lcom/fasterxml/jackson/databind/JsonNode;
    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isNull()Z

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_0

    .line 89
    :cond_0
    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/JsonNode;->asText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 87
    :cond_1
    :goto_0
    return-object v1
.end method

.method getStringOrArray(Lcom/fasterxml/jackson/core/ObjectCodec;Ljava/util/Map;Ljava/lang/String;)Ljava/util/List;
    .locals 6
    .param p1, "codec"    # Lcom/fasterxml/jackson/core/ObjectCodec;
    .param p3, "claimName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/fasterxml/jackson/core/ObjectCodec;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/fasterxml/jackson/databind/JsonNode;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation

    .line 53
    .local p2, "tree":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;>;"
    invoke-interface {p2, p3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/JsonNode;

    .line 54
    .local v0, "node":Lcom/fasterxml/jackson/databind/JsonNode;
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isNull()Z

    move-result v1

    if-nez v1, :cond_3

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isArray()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isTextual()Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    .line 57
    :cond_0
    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isTextual()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->asText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    .line 58
    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->asText()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    return-object v1

    .line 61
    :cond_1
    new-instance v1, Ljava/util/ArrayList;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->size()I

    move-result v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    .line 62
    .local v1, "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->size()I

    move-result v3

    if-ge v2, v3, :cond_2

    .line 64
    :try_start_0
    invoke-virtual {v0, v2}, Lcom/fasterxml/jackson/databind/JsonNode;->get(I)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v3

    const-class v4, Ljava/lang/String;

    invoke-virtual {p1, v3, v4}, Lcom/fasterxml/jackson/core/ObjectCodec;->treeToValue(Lcom/fasterxml/jackson/core/TreeNode;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Lcom/fasterxml/jackson/core/JsonProcessingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 67
    nop

    .line 62
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 65
    :catch_0
    move-exception v3

    .line 66
    .local v3, "e":Lcom/fasterxml/jackson/core/JsonProcessingException;
    new-instance v4, Lcom/auth0/jwt/exceptions/JWTDecodeException;

    const-string v5, "Couldn\'t map the Claim\'s array contents to String"

    invoke-direct {v4, v5, v3}, Lcom/auth0/jwt/exceptions/JWTDecodeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v4

    .line 69
    .end local v2    # "i":I
    .end local v3    # "e":Lcom/fasterxml/jackson/core/JsonProcessingException;
    :cond_2
    return-object v1

    .line 55
    .end local v1    # "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    :cond_3
    :goto_1
    const/4 v1, 0x0

    return-object v1
.end method
