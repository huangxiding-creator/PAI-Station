.class public Lcom/auth0/jwt/impl/ClaimsSerializer;
.super Lcom/fasterxml/jackson/databind/ser/std/StdSerializer;
.source "ClaimsSerializer.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Lcom/auth0/jwt/impl/ClaimsHolder;",
        ">",
        "Lcom/fasterxml/jackson/databind/ser/std/StdSerializer<",
        "TT;>;"
    }
.end annotation


# direct methods
.method public constructor <init>(Ljava/lang/Class;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "TT;>;)V"
        }
    .end annotation

    .line 21
    .local p0, "this":Lcom/auth0/jwt/impl/ClaimsSerializer;, "Lcom/auth0/jwt/impl/ClaimsSerializer<TT;>;"
    .local p1, "t":Ljava/lang/Class;, "Ljava/lang/Class<TT;>;"
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/databind/ser/std/StdSerializer;-><init>(Ljava/lang/Class;)V

    .line 22
    return-void
.end method

.method private static dateToSeconds(Ljava/util/Date;)J
    .locals 4
    .param p0, "date"    # Ljava/util/Date;

    .line 84
    invoke-virtual {p0}, Ljava/util/Date;->getTime()J

    move-result-wide v0

    const-wide/16 v2, 0x3e8

    div-long/2addr v0, v2

    return-wide v0
.end method

.method private static handleSerialization(Ljava/lang/Object;Lcom/fasterxml/jackson/core/JsonGenerator;)V
    .locals 2
    .param p0, "value"    # Ljava/lang/Object;
    .param p1, "gen"    # Lcom/fasterxml/jackson/core/JsonGenerator;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 48
    instance-of v0, p0, Ljava/util/Date;

    if-eqz v0, :cond_0

    .line 49
    move-object v0, p0

    check-cast v0, Ljava/util/Date;

    invoke-static {v0}, Lcom/auth0/jwt/impl/ClaimsSerializer;->dateToSeconds(Ljava/util/Date;)J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Lcom/fasterxml/jackson/core/JsonGenerator;->writeNumber(J)V

    goto :goto_0

    .line 50
    :cond_0
    instance-of v0, p0, Ljava/time/Instant;

    if-eqz v0, :cond_1

    .line 51
    move-object v0, p0

    check-cast v0, Ljava/time/Instant;

    invoke-static {v0}, Lcom/auth0/jwt/impl/ClaimsSerializer;->instantToSeconds(Ljava/time/Instant;)J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Lcom/fasterxml/jackson/core/JsonGenerator;->writeNumber(J)V

    goto :goto_0

    .line 52
    :cond_1
    instance-of v0, p0, Ljava/util/Map;

    if-eqz v0, :cond_2

    .line 53
    move-object v0, p0

    check-cast v0, Ljava/util/Map;

    invoke-static {v0, p1}, Lcom/auth0/jwt/impl/ClaimsSerializer;->serializeMap(Ljava/util/Map;Lcom/fasterxml/jackson/core/JsonGenerator;)V

    goto :goto_0

    .line 54
    :cond_2
    instance-of v0, p0, Ljava/util/List;

    if-eqz v0, :cond_3

    .line 55
    move-object v0, p0

    check-cast v0, Ljava/util/List;

    invoke-static {v0, p1}, Lcom/auth0/jwt/impl/ClaimsSerializer;->serializeList(Ljava/util/List;Lcom/fasterxml/jackson/core/JsonGenerator;)V

    goto :goto_0

    .line 57
    :cond_3
    invoke-virtual {p1, p0}, Lcom/fasterxml/jackson/core/JsonGenerator;->writeObject(Ljava/lang/Object;)V

    .line 59
    :goto_0
    return-void
.end method

.method private static instantToSeconds(Ljava/time/Instant;)J
    .locals 2
    .param p0, "instant"    # Ljava/time/Instant;

    .line 80
    invoke-virtual {p0}, Ljava/time/Instant;->getEpochSecond()J

    move-result-wide v0

    return-wide v0
.end method

.method private static serializeList(Ljava/util/List;Lcom/fasterxml/jackson/core/JsonGenerator;)V
    .locals 2
    .param p1, "gen"    # Lcom/fasterxml/jackson/core/JsonGenerator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "*>;",
            "Lcom/fasterxml/jackson/core/JsonGenerator;",
            ")V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 72
    .local p0, "list":Ljava/util/List;, "Ljava/util/List<*>;"
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonGenerator;->writeStartArray()V

    .line 73
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    .line 74
    .local v1, "entry":Ljava/lang/Object;
    invoke-static {v1, p1}, Lcom/auth0/jwt/impl/ClaimsSerializer;->handleSerialization(Ljava/lang/Object;Lcom/fasterxml/jackson/core/JsonGenerator;)V

    .line 75
    .end local v1    # "entry":Ljava/lang/Object;
    goto :goto_0

    .line 76
    :cond_0
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonGenerator;->writeEndArray()V

    .line 77
    return-void
.end method

.method private static serializeMap(Ljava/util/Map;Lcom/fasterxml/jackson/core/JsonGenerator;)V
    .locals 3
    .param p1, "gen"    # Lcom/fasterxml/jackson/core/JsonGenerator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "**>;",
            "Lcom/fasterxml/jackson/core/JsonGenerator;",
            ")V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 62
    .local p0, "map":Ljava/util/Map;, "Ljava/util/Map<**>;"
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonGenerator;->writeStartObject()V

    .line 63
    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 64
    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<**>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {p1, v2}, Lcom/fasterxml/jackson/core/JsonGenerator;->writeFieldName(Ljava/lang/String;)V

    .line 65
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    .line 66
    .local v2, "value":Ljava/lang/Object;
    invoke-static {v2, p1}, Lcom/auth0/jwt/impl/ClaimsSerializer;->handleSerialization(Ljava/lang/Object;Lcom/fasterxml/jackson/core/JsonGenerator;)V

    .line 67
    .end local v1    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<**>;"
    .end local v2    # "value":Ljava/lang/Object;
    goto :goto_0

    .line 68
    :cond_0
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonGenerator;->writeEndObject()V

    .line 69
    return-void
.end method


# virtual methods
.method public serialize(Lcom/auth0/jwt/impl/ClaimsHolder;Lcom/fasterxml/jackson/core/JsonGenerator;Lcom/fasterxml/jackson/databind/SerializerProvider;)V
    .locals 2
    .param p2, "gen"    # Lcom/fasterxml/jackson/core/JsonGenerator;
    .param p3, "provider"    # Lcom/fasterxml/jackson/databind/SerializerProvider;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;",
            "Lcom/fasterxml/jackson/core/JsonGenerator;",
            "Lcom/fasterxml/jackson/databind/SerializerProvider;",
            ")V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 26
    .local p0, "this":Lcom/auth0/jwt/impl/ClaimsSerializer;, "Lcom/auth0/jwt/impl/ClaimsSerializer<TT;>;"
    .local p1, "holder":Lcom/auth0/jwt/impl/ClaimsHolder;, "TT;"
    invoke-virtual {p2}, Lcom/fasterxml/jackson/core/JsonGenerator;->writeStartObject()V

    .line 27
    invoke-virtual {p1}, Lcom/auth0/jwt/impl/ClaimsHolder;->getClaims()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 28
    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/Object;>;"
    invoke-virtual {p0, v1, p2}, Lcom/auth0/jwt/impl/ClaimsSerializer;->writeClaim(Ljava/util/Map$Entry;Lcom/fasterxml/jackson/core/JsonGenerator;)V

    .line 29
    .end local v1    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/Object;>;"
    goto :goto_0

    .line 30
    :cond_0
    invoke-virtual {p2}, Lcom/fasterxml/jackson/core/JsonGenerator;->writeEndObject()V

    .line 31
    return-void
.end method

.method public bridge synthetic serialize(Ljava/lang/Object;Lcom/fasterxml/jackson/core/JsonGenerator;Lcom/fasterxml/jackson/databind/SerializerProvider;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 18
    .local p0, "this":Lcom/auth0/jwt/impl/ClaimsSerializer;, "Lcom/auth0/jwt/impl/ClaimsSerializer<TT;>;"
    check-cast p1, Lcom/auth0/jwt/impl/ClaimsHolder;

    invoke-virtual {p0, p1, p2, p3}, Lcom/auth0/jwt/impl/ClaimsSerializer;->serialize(Lcom/auth0/jwt/impl/ClaimsHolder;Lcom/fasterxml/jackson/core/JsonGenerator;Lcom/fasterxml/jackson/databind/SerializerProvider;)V

    return-void
.end method

.method protected writeClaim(Ljava/util/Map$Entry;Lcom/fasterxml/jackson/core/JsonGenerator;)V
    .locals 1
    .param p2, "gen"    # Lcom/fasterxml/jackson/core/JsonGenerator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map$Entry<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Lcom/fasterxml/jackson/core/JsonGenerator;",
            ")V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 43
    .local p0, "this":Lcom/auth0/jwt/impl/ClaimsSerializer;, "Lcom/auth0/jwt/impl/ClaimsSerializer<TT;>;"
    .local p1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/Object;>;"
    invoke-interface {p1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p2, v0}, Lcom/fasterxml/jackson/core/JsonGenerator;->writeFieldName(Ljava/lang/String;)V

    .line 44
    invoke-interface {p1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0, p2}, Lcom/auth0/jwt/impl/ClaimsSerializer;->handleSerialization(Ljava/lang/Object;Lcom/fasterxml/jackson/core/JsonGenerator;)V

    .line 45
    return-void
.end method
