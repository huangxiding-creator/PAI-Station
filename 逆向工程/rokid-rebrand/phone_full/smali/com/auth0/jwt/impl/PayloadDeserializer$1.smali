.class Lcom/auth0/jwt/impl/PayloadDeserializer$1;
.super Lcom/fasterxml/jackson/core/type/TypeReference;
.source "PayloadDeserializer.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/auth0/jwt/impl/PayloadDeserializer;->deserialize(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/auth0/jwt/interfaces/Payload;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/fasterxml/jackson/core/type/TypeReference<",
        "Ljava/util/Map<",
        "Ljava/lang/String;",
        "Lcom/fasterxml/jackson/databind/JsonNode;",
        ">;>;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/auth0/jwt/impl/PayloadDeserializer;


# direct methods
.method constructor <init>(Lcom/auth0/jwt/impl/PayloadDeserializer;)V
    .locals 0
    .param p1, "this$0"    # Lcom/auth0/jwt/impl/PayloadDeserializer;

    .line 34
    iput-object p1, p0, Lcom/auth0/jwt/impl/PayloadDeserializer$1;->this$0:Lcom/auth0/jwt/impl/PayloadDeserializer;

    invoke-direct {p0}, Lcom/fasterxml/jackson/core/type/TypeReference;-><init>()V

    return-void
.end method
