.class Lcom/auth0/jwt/impl/HeaderDeserializer;
.super Lcom/fasterxml/jackson/databind/deser/std/StdDeserializer;
.source "HeaderDeserializer.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/fasterxml/jackson/databind/deser/std/StdDeserializer<",
        "Lcom/auth0/jwt/interfaces/Header;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 1

    .line 25
    const-class v0, Lcom/auth0/jwt/interfaces/Header;

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/databind/deser/std/StdDeserializer;-><init>(Ljava/lang/Class;)V

    .line 26
    return-void
.end method


# virtual methods
.method public deserialize(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/auth0/jwt/interfaces/Header;
    .locals 13
    .param p1, "p"    # Lcom/fasterxml/jackson/core/JsonParser;
    .param p2, "ctxt"    # Lcom/fasterxml/jackson/databind/DeserializationContext;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 30
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getCodec()Lcom/fasterxml/jackson/core/ObjectCodec;

    move-result-object v0

    new-instance v1, Lcom/auth0/jwt/impl/HeaderDeserializer$1;

    invoke-direct {v1, p0}, Lcom/auth0/jwt/impl/HeaderDeserializer$1;-><init>(Lcom/auth0/jwt/impl/HeaderDeserializer;)V

    invoke-virtual {v0, p1, v1}, Lcom/fasterxml/jackson/core/ObjectCodec;->readValue(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/core/type/TypeReference;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map;

    .line 32
    .local v0, "tree":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;>;"
    if-eqz v0, :cond_0

    .line 36
    const-string v1, "alg"

    invoke-virtual {p0, v0, v1}, Lcom/auth0/jwt/impl/HeaderDeserializer;->getString(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 37
    .local v8, "algorithm":Ljava/lang/String;
    const-string/jumbo v1, "typ"

    invoke-virtual {p0, v0, v1}, Lcom/auth0/jwt/impl/HeaderDeserializer;->getString(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 38
    .local v9, "type":Ljava/lang/String;
    const-string v1, "cty"

    invoke-virtual {p0, v0, v1}, Lcom/auth0/jwt/impl/HeaderDeserializer;->getString(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 39
    .local v10, "contentType":Ljava/lang/String;
    const-string v1, "kid"

    invoke-virtual {p0, v0, v1}, Lcom/auth0/jwt/impl/HeaderDeserializer;->getString(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 40
    .local v11, "keyId":Ljava/lang/String;
    new-instance v12, Lcom/auth0/jwt/impl/BasicHeader;

    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getCodec()Lcom/fasterxml/jackson/core/ObjectCodec;

    move-result-object v7

    move-object v1, v12

    move-object v2, v8

    move-object v3, v9

    move-object v4, v10

    move-object v5, v11

    move-object v6, v0

    invoke-direct/range {v1 .. v7}, Lcom/auth0/jwt/impl/BasicHeader;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/fasterxml/jackson/core/ObjectCodec;)V

    return-object v12

    .line 33
    .end local v8    # "algorithm":Ljava/lang/String;
    .end local v9    # "type":Ljava/lang/String;
    .end local v10    # "contentType":Ljava/lang/String;
    .end local v11    # "keyId":Ljava/lang/String;
    :cond_0
    new-instance v1, Lcom/auth0/jwt/exceptions/JWTDecodeException;

    const-string v2, "Parsing the Header\'s JSON resulted on a Null map"

    invoke-direct {v1, v2}, Lcom/auth0/jwt/exceptions/JWTDecodeException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public bridge synthetic deserialize(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lcom/fasterxml/jackson/core/JacksonException;
        }
    .end annotation

    .line 22
    invoke-virtual {p0, p1, p2}, Lcom/auth0/jwt/impl/HeaderDeserializer;->deserialize(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/auth0/jwt/interfaces/Header;

    move-result-object p1

    return-object p1
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

    .line 44
    .local p1, "tree":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;>;"
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/JsonNode;

    .line 45
    .local v0, "node":Lcom/fasterxml/jackson/databind/JsonNode;
    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/JsonNode;->isNull()Z

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_0

    .line 48
    :cond_0
    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/JsonNode;->asText(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 46
    :cond_1
    :goto_0
    return-object v1
.end method
