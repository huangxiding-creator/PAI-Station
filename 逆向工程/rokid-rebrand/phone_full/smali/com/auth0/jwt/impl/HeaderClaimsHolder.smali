.class public final Lcom/auth0/jwt/impl/HeaderClaimsHolder;
.super Lcom/auth0/jwt/impl/ClaimsHolder;
.source "HeaderClaimsHolder.java"


# direct methods
.method public constructor <init>(Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .line 10
    .local p1, "claims":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;"
    invoke-direct {p0, p1}, Lcom/auth0/jwt/impl/ClaimsHolder;-><init>(Ljava/util/Map;)V

    .line 11
    return-void
.end method
