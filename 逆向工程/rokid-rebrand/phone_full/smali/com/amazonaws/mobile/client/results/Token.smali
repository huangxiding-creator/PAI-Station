.class public Lcom/amazonaws/mobile/client/results/Token;
.super Ljava/lang/Object;
.source "Token.java"


# static fields
.field public static final MILLIS_PER_SEC:I = 0x3e8


# instance fields
.field private final token:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "token"    # Ljava/lang/String;

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    iput-object p1, p0, Lcom/amazonaws/mobile/client/results/Token;->token:Ljava/lang/String;

    .line 31
    return-void
.end method


# virtual methods
.method public getClaim(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "claim"    # Ljava/lang/String;

    .line 89
    iget-object v0, p0, Lcom/amazonaws/mobile/client/results/Token;->token:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/CognitoJWTParser;->getClaim(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method getClaimDate(Ljava/lang/String;)Ljava/util/Date;
    .locals 6
    .param p1, "claimStr"    # Ljava/lang/String;

    .line 71
    :try_start_0
    iget-object v0, p0, Lcom/amazonaws/mobile/client/results/Token;->token:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/CognitoJWTParser;->getClaim(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 72
    .local v0, "claim":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 73
    const/4 v1, 0x0

    return-object v1

    .line 75
    :cond_0
    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    .line 76
    .local v1, "epocTimeSec":J
    const-wide/16 v3, 0x3e8

    mul-long/2addr v3, v1

    .line 77
    .local v3, "epocTimeMilliSec":J
    new-instance v5, Ljava/util/Date;

    invoke-direct {v5, v3, v4}, Ljava/util/Date;-><init>(J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v5

    .line 78
    .end local v0    # "claim":Ljava/lang/String;
    .end local v1    # "epocTimeSec":J
    .end local v3    # "epocTimeMilliSec":J
    :catch_0
    move-exception v0

    .line 79
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/RuntimeException;

    const-string v2, "Failed to get claim from token"

    invoke-direct {v1, v2, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getExpiration()Ljava/util/Date;
    .locals 1

    .line 48
    const-string v0, "exp"

    invoke-virtual {p0, v0}, Lcom/amazonaws/mobile/client/results/Token;->getClaimDate(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v0

    return-object v0
.end method

.method public getIssuedAt()Ljava/util/Date;
    .locals 1

    .line 66
    const-string v0, "iat"

    invoke-virtual {p0, v0}, Lcom/amazonaws/mobile/client/results/Token;->getClaimDate(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v0

    return-object v0
.end method

.method public getNotBefore()Ljava/util/Date;
    .locals 1

    .line 57
    const-string v0, "nbf"

    invoke-virtual {p0, v0}, Lcom/amazonaws/mobile/client/results/Token;->getClaimDate(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v0

    return-object v0
.end method

.method public getTokenString()Ljava/lang/String;
    .locals 1

    .line 39
    iget-object v0, p0, Lcom/amazonaws/mobile/client/results/Token;->token:Ljava/lang/String;

    return-object v0
.end method
