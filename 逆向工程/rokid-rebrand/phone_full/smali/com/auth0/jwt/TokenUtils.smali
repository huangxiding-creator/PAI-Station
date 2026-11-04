.class abstract Lcom/auth0/jwt/TokenUtils;
.super Ljava/lang/Object;
.source "TokenUtils.java"


# direct methods
.method constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static splitToken(Ljava/lang/String;)[Ljava/lang/String;
    .locals 7
    .param p0, "token"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation

    .line 15
    if-eqz p0, :cond_3

    .line 19
    const/16 v0, 0x2e

    .line 21
    .local v0, "delimiter":C
    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 22
    .local v1, "firstPeriodIndex":I
    const/4 v2, 0x0

    const/4 v3, -0x1

    if-eq v1, v3, :cond_2

    .line 26
    add-int/lit8 v4, v1, 0x1

    invoke-virtual {p0, v0, v4}, Ljava/lang/String;->indexOf(II)I

    move-result v4

    .line 27
    .local v4, "secondPeriodIndex":I
    const/4 v5, 0x2

    if-eq v4, v3, :cond_1

    .line 32
    add-int/lit8 v6, v4, 0x1

    invoke-virtual {p0, v0, v6}, Ljava/lang/String;->indexOf(II)I

    move-result v6

    if-ne v6, v3, :cond_0

    .line 36
    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/String;

    .line 37
    .local v3, "parts":[Ljava/lang/String;
    invoke-virtual {p0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v3, v2

    .line 38
    add-int/lit8 v2, v1, 0x1

    invoke-virtual {p0, v2, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    const/4 v6, 0x1

    aput-object v2, v3, v6

    .line 39
    add-int/lit8 v2, v4, 0x1

    invoke-virtual {p0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v3, v5

    .line 41
    return-object v3

    .line 33
    .end local v3    # "parts":[Ljava/lang/String;
    :cond_0
    const-string v2, "> 3"

    invoke-static {v2}, Lcom/auth0/jwt/TokenUtils;->wrongNumberOfParts(Ljava/lang/Object;)Lcom/auth0/jwt/exceptions/JWTDecodeException;

    move-result-object v2

    throw v2

    .line 28
    :cond_1
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v2}, Lcom/auth0/jwt/TokenUtils;->wrongNumberOfParts(Ljava/lang/Object;)Lcom/auth0/jwt/exceptions/JWTDecodeException;

    move-result-object v2

    throw v2

    .line 23
    .end local v4    # "secondPeriodIndex":I
    :cond_2
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v2}, Lcom/auth0/jwt/TokenUtils;->wrongNumberOfParts(Ljava/lang/Object;)Lcom/auth0/jwt/exceptions/JWTDecodeException;

    move-result-object v2

    throw v2

    .line 16
    .end local v0    # "delimiter":C
    .end local v1    # "firstPeriodIndex":I
    :cond_3
    new-instance v0, Lcom/auth0/jwt/exceptions/JWTDecodeException;

    const-string v1, "The token is null."

    invoke-direct {v0, v1}, Lcom/auth0/jwt/exceptions/JWTDecodeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static wrongNumberOfParts(Ljava/lang/Object;)Lcom/auth0/jwt/exceptions/JWTDecodeException;
    .locals 3
    .param p0, "partCount"    # Ljava/lang/Object;

    .line 45
    new-instance v0, Lcom/auth0/jwt/exceptions/JWTDecodeException;

    const-string v1, "The token was expected to have 3 parts, but got %s."

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/auth0/jwt/exceptions/JWTDecodeException;-><init>(Ljava/lang/String;)V

    return-object v0
.end method
