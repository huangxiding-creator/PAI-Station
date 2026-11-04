.class public Lcom/amazonaws/auth/policy/Principal;
.super Ljava/lang/Object;
.source "Principal.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/auth/policy/Principal$WebIdentityProviders;,
        Lcom/amazonaws/auth/policy/Principal$Services;
    }
.end annotation


# static fields
.field public static final All:Lcom/amazonaws/auth/policy/Principal;

.field public static final AllServices:Lcom/amazonaws/auth/policy/Principal;

.field public static final AllUsers:Lcom/amazonaws/auth/policy/Principal;

.field public static final AllWebProviders:Lcom/amazonaws/auth/policy/Principal;


# instance fields
.field private final id:Ljava/lang/String;

.field private final provider:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 43
    new-instance v0, Lcom/amazonaws/auth/policy/Principal;

    const-string v1, "AWS"

    const-string v2, "*"

    invoke-direct {v0, v1, v2}, Lcom/amazonaws/auth/policy/Principal;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    sput-object v0, Lcom/amazonaws/auth/policy/Principal;->AllUsers:Lcom/amazonaws/auth/policy/Principal;

    .line 49
    new-instance v0, Lcom/amazonaws/auth/policy/Principal;

    const-string v1, "Service"

    invoke-direct {v0, v1, v2}, Lcom/amazonaws/auth/policy/Principal;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    sput-object v0, Lcom/amazonaws/auth/policy/Principal;->AllServices:Lcom/amazonaws/auth/policy/Principal;

    .line 55
    new-instance v0, Lcom/amazonaws/auth/policy/Principal;

    const-string v1, "Federated"

    invoke-direct {v0, v1, v2}, Lcom/amazonaws/auth/policy/Principal;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    sput-object v0, Lcom/amazonaws/auth/policy/Principal;->AllWebProviders:Lcom/amazonaws/auth/policy/Principal;

    .line 62
    new-instance v0, Lcom/amazonaws/auth/policy/Principal;

    invoke-direct {v0, v2, v2}, Lcom/amazonaws/auth/policy/Principal;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    sput-object v0, Lcom/amazonaws/auth/policy/Principal;->All:Lcom/amazonaws/auth/policy/Principal;

    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/policy/Principal$Services;)V
    .locals 2
    .param p1, "service"    # Lcom/amazonaws/auth/policy/Principal$Services;

    .line 74
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 75
    if-eqz p1, :cond_0

    .line 78
    invoke-virtual {p1}, Lcom/amazonaws/auth/policy/Principal$Services;->getServiceId()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/auth/policy/Principal;->id:Ljava/lang/String;

    .line 79
    const-string v0, "Service"

    iput-object v0, p0, Lcom/amazonaws/auth/policy/Principal;->provider:Ljava/lang/String;

    .line 80
    return-void

    .line 76
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Null AWS service name specified"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public constructor <init>(Lcom/amazonaws/auth/policy/Principal$WebIdentityProviders;)V
    .locals 2
    .param p1, "webIdentityProvider"    # Lcom/amazonaws/auth/policy/Principal$WebIdentityProviders;

    .line 114
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 115
    if-eqz p1, :cond_0

    .line 118
    invoke-virtual {p1}, Lcom/amazonaws/auth/policy/Principal$WebIdentityProviders;->getWebIdentityProvider()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/auth/policy/Principal;->id:Ljava/lang/String;

    .line 119
    const-string v0, "Federated"

    iput-object v0, p0, Lcom/amazonaws/auth/policy/Principal;->provider:Ljava/lang/String;

    .line 120
    return-void

    .line 116
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Null web identity provider specified"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 2
    .param p1, "accountId"    # Ljava/lang/String;

    .line 100
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 101
    if-eqz p1, :cond_0

    .line 105
    const-string v0, "-"

    const-string v1, ""

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/auth/policy/Principal;->id:Ljava/lang/String;

    .line 106
    const-string v0, "AWS"

    iput-object v0, p0, Lcom/amazonaws/auth/policy/Principal;->provider:Ljava/lang/String;

    .line 107
    return-void

    .line 102
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Null AWS account ID specified"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "provider"    # Ljava/lang/String;
    .param p2, "id"    # Ljava/lang/String;

    .line 87
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 88
    iput-object p1, p0, Lcom/amazonaws/auth/policy/Principal;->provider:Ljava/lang/String;

    .line 89
    const-string v0, "AWS"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 90
    const-string v0, "-"

    const-string v1, ""

    invoke-virtual {p2, v0, v1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 92
    :cond_0
    iput-object p2, p0, Lcom/amazonaws/auth/policy/Principal;->id:Ljava/lang/String;

    .line 93
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "principal"    # Ljava/lang/Object;

    .line 263
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 264
    return v0

    .line 267
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 268
    return v1

    .line 271
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/auth/policy/Principal;

    if-nez v2, :cond_2

    .line 272
    return v1

    .line 275
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/auth/policy/Principal;

    .line 277
    .local v2, "other":Lcom/amazonaws/auth/policy/Principal;
    invoke-virtual {p0}, Lcom/amazonaws/auth/policy/Principal;->getProvider()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2}, Lcom/amazonaws/auth/policy/Principal;->getProvider()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 278
    invoke-virtual {p0}, Lcom/amazonaws/auth/policy/Principal;->getId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2}, Lcom/amazonaws/auth/policy/Principal;->getId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 279
    return v0

    .line 282
    :cond_3
    return v1
.end method

.method public getId()Ljava/lang/String;
    .locals 1

    .line 138
    iget-object v0, p0, Lcom/amazonaws/auth/policy/Principal;->id:Ljava/lang/String;

    return-object v0
.end method

.method public getProvider()Ljava/lang/String;
    .locals 1

    .line 129
    iget-object v0, p0, Lcom/amazonaws/auth/policy/Principal;->provider:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    .line 253
    const/16 v0, 0x1f

    .line 254
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 256
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    iget-object v3, p0, Lcom/amazonaws/auth/policy/Principal;->provider:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    add-int/2addr v2, v3

    .line 257
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    iget-object v3, p0, Lcom/amazonaws/auth/policy/Principal;->id:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    add-int/2addr v1, v3

    .line 258
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method
