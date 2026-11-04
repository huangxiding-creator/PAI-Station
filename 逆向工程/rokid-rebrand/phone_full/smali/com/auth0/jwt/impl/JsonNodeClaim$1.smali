.class Lcom/auth0/jwt/impl/JsonNodeClaim$1;
.super Lcom/fasterxml/jackson/core/type/TypeReference;
.source "JsonNodeClaim.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/auth0/jwt/impl/JsonNodeClaim;->asMap()Ljava/util/Map;
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
        "Ljava/lang/Object;",
        ">;>;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/auth0/jwt/impl/JsonNodeClaim;


# direct methods
.method constructor <init>(Lcom/auth0/jwt/impl/JsonNodeClaim;)V
    .locals 0
    .param p1, "this$0"    # Lcom/auth0/jwt/impl/JsonNodeClaim;

    .line 116
    iput-object p1, p0, Lcom/auth0/jwt/impl/JsonNodeClaim$1;->this$0:Lcom/auth0/jwt/impl/JsonNodeClaim;

    invoke-direct {p0}, Lcom/fasterxml/jackson/core/type/TypeReference;-><init>()V

    return-void
.end method
