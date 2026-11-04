.class public final enum Lio/minio/messages/GranteeType;
.super Ljava/lang/Enum;
.source "GranteeType.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/messages/GranteeType$GranteeTypeConverter;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/minio/messages/GranteeType;",
        ">;"
    }
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Type"
.end annotation

.annotation runtime Lorg/simpleframework/xml/convert/Convert;
    value = Lio/minio/messages/GranteeType$GranteeTypeConverter;
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/minio/messages/GranteeType;

.field public static final enum AMAZON_CUSTOMER_BY_EMAIL:Lio/minio/messages/GranteeType;

.field public static final enum CANONICAL_USER:Lio/minio/messages/GranteeType;

.field public static final enum GROUP:Lio/minio/messages/GranteeType;


# instance fields
.field private final value:Ljava/lang/String;


# direct methods
.method private static synthetic $values()[Lio/minio/messages/GranteeType;
    .locals 3

    .line 26
    sget-object v0, Lio/minio/messages/GranteeType;->CANONICAL_USER:Lio/minio/messages/GranteeType;

    sget-object v1, Lio/minio/messages/GranteeType;->AMAZON_CUSTOMER_BY_EMAIL:Lio/minio/messages/GranteeType;

    sget-object v2, Lio/minio/messages/GranteeType;->GROUP:Lio/minio/messages/GranteeType;

    filled-new-array {v0, v1, v2}, [Lio/minio/messages/GranteeType;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 29
    new-instance v0, Lio/minio/messages/GranteeType;

    const/4 v1, 0x0

    const-string v2, "CanonicalUser"

    const-string v3, "CANONICAL_USER"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/GranteeType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/GranteeType;->CANONICAL_USER:Lio/minio/messages/GranteeType;

    .line 30
    new-instance v0, Lio/minio/messages/GranteeType;

    const/4 v1, 0x1

    const-string v2, "AmazonCustomerByEmail"

    const-string v3, "AMAZON_CUSTOMER_BY_EMAIL"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/GranteeType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/GranteeType;->AMAZON_CUSTOMER_BY_EMAIL:Lio/minio/messages/GranteeType;

    .line 31
    new-instance v0, Lio/minio/messages/GranteeType;

    const/4 v1, 0x2

    const-string v2, "Group"

    const-string v3, "GROUP"

    invoke-direct {v0, v3, v1, v2}, Lio/minio/messages/GranteeType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lio/minio/messages/GranteeType;->GROUP:Lio/minio/messages/GranteeType;

    .line 26
    invoke-static {}, Lio/minio/messages/GranteeType;->$values()[Lio/minio/messages/GranteeType;

    move-result-object v0

    sput-object v0, Lio/minio/messages/GranteeType;->$VALUES:[Lio/minio/messages/GranteeType;

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

    .line 35
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 36
    iput-object p3, p0, Lio/minio/messages/GranteeType;->value:Ljava/lang/String;

    .line 37
    return-void
.end method

.method public static fromString(Ljava/lang/String;)Lio/minio/messages/GranteeType;
    .locals 5
    .param p0, "granteeTypeString"    # Ljava/lang/String;

    .line 45
    invoke-static {}, Lio/minio/messages/GranteeType;->values()[Lio/minio/messages/GranteeType;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 46
    .local v3, "granteeType":Lio/minio/messages/GranteeType;
    iget-object v4, v3, Lio/minio/messages/GranteeType;->value:Ljava/lang/String;

    invoke-virtual {p0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 47
    return-object v3

    .line 45
    .end local v3    # "granteeType":Lio/minio/messages/GranteeType;
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 51
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unknown grantee type \'"

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

.method public static valueOf(Ljava/lang/String;)Lio/minio/messages/GranteeType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 26
    const-class v0, Lio/minio/messages/GranteeType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/minio/messages/GranteeType;

    return-object v0
.end method

.method public static values()[Lio/minio/messages/GranteeType;
    .locals 1

    .line 26
    sget-object v0, Lio/minio/messages/GranteeType;->$VALUES:[Lio/minio/messages/GranteeType;

    invoke-virtual {v0}, [Lio/minio/messages/GranteeType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/messages/GranteeType;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .line 40
    iget-object v0, p0, Lio/minio/messages/GranteeType;->value:Ljava/lang/String;

    return-object v0
.end method
