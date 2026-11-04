.class public final enum Lio/minio/messages/Tier;
.super Ljava/lang/Enum;
.source "Tier.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/messages/Tier$TierConverter;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/minio/messages/Tier;",
        ">;"
    }
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Tier"
.end annotation

.annotation runtime Lorg/simpleframework/xml/convert/Convert;
    value = Lio/minio/messages/Tier$TierConverter;
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/minio/messages/Tier;

.field public static final enum BULK:Lio/minio/messages/Tier;

.field public static final enum EXPEDITED:Lio/minio/messages/Tier;

.field public static final enum STANDARD:Lio/minio/messages/Tier;


# instance fields
.field private final value:Ljava/lang/String;


# direct methods
.method private static synthetic $values()[Lio/minio/messages/Tier;
    .locals 3

    .line 27
    sget-object v0, Lio/minio/messages/Tier;->STANDARD:Lio/minio/messages/Tier;

    sget-object v1, Lio/minio/messages/Tier;->BULK:Lio/minio/messages/Tier;

    sget-object v2, Lio/minio/messages/Tier;->EXPEDITED:Lio/minio/messages/Tier;

    filled-new-array {v0, v1, v2}, [Lio/minio/messages/Tier;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 30
    new-instance v0, Lio/minio/messages/Tier;

    const/4 v1, 0x0

    const-string v2, "Standard"

    const-string v3, "STANDARD"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/Tier;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/Tier;->STANDARD:Lio/minio/messages/Tier;

    .line 31
    new-instance v0, Lio/minio/messages/Tier;

    const/4 v1, 0x1

    const-string v2, "Bulk"

    const-string v3, "BULK"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/Tier;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/Tier;->BULK:Lio/minio/messages/Tier;

    .line 32
    new-instance v0, Lio/minio/messages/Tier;

    const/4 v1, 0x2

    const-string v2, "Expedited"

    const-string v3, "EXPEDITED"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/Tier;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/Tier;->EXPEDITED:Lio/minio/messages/Tier;

    .line 27
    invoke-static {}, Lio/minio/messages/Tier;->$values()[Lio/minio/messages/Tier;

    move-result-object v0

    sput-object v0, Lio/minio/messages/Tier;->$VALUES:[Lio/minio/messages/Tier;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p3, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 36
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 37
    iput-object p3, p0, Lio/minio/messages/Tier;->value:Ljava/lang/String;

    .line 38
    return-void
.end method

.method public static fromString(Ljava/lang/String;)Lio/minio/messages/Tier;
    .locals 5
    .param p0, "tierString"    # Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonCreator;
    .end annotation

    .line 47
    invoke-static {}, Lio/minio/messages/Tier;->values()[Lio/minio/messages/Tier;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 48
    .local v3, "tier":Lio/minio/messages/Tier;
    iget-object v4, v3, Lio/minio/messages/Tier;->value:Ljava/lang/String;

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 49
    return-object v3

    .line 47
    .end local v3    # "tier":Lio/minio/messages/Tier;
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 53
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unknown tier \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static valueOf(Ljava/lang/String;)Lio/minio/messages/Tier;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 27
    const-class v0, Lio/minio/messages/Tier;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Tier;

    return-object v0
.end method

.method public static values()[Lio/minio/messages/Tier;
    .locals 1

    .line 27
    sget-object v0, Lio/minio/messages/Tier;->$VALUES:[Lio/minio/messages/Tier;

    invoke-virtual {v0}, [Lio/minio/messages/Tier;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/messages/Tier;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .line 41
    iget-object v0, p0, Lio/minio/messages/Tier;->value:Ljava/lang/String;

    return-object v0
.end method
