.class public Lcom/auth0/jwt/impl/HeaderSerializer;
.super Lcom/auth0/jwt/impl/ClaimsSerializer;
.source "HeaderSerializer.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/auth0/jwt/impl/ClaimsSerializer<",
        "Lcom/auth0/jwt/impl/HeaderClaimsHolder;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 8
    const-class v0, Lcom/auth0/jwt/impl/HeaderClaimsHolder;

    invoke-direct {p0, v0}, Lcom/auth0/jwt/impl/ClaimsSerializer;-><init>(Ljava/lang/Class;)V

    .line 9
    return-void
.end method
