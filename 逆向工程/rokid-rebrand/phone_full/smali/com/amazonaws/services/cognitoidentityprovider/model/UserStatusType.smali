.class public final enum Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;
.super Ljava/lang/Enum;
.source "UserStatusType.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

.field public static final enum ARCHIVED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

.field public static final enum COMPROMISED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

.field public static final enum CONFIRMED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

.field public static final enum FORCE_CHANGE_PASSWORD:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

.field public static final enum RESET_REQUIRED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

.field public static final enum UNCONFIRMED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

.field private static final enumMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private value:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 14

    .line 26
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    const/4 v1, 0x0

    const-string v2, "UNCONFIRMED"

    invoke-direct {v0, v2, v1, v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->UNCONFIRMED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    .line 27
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    const/4 v1, 0x1

    const-string v3, "CONFIRMED"

    invoke-direct {v0, v3, v1, v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->CONFIRMED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    .line 28
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    const/4 v1, 0x2

    const-string v4, "ARCHIVED"

    invoke-direct {v0, v4, v1, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->ARCHIVED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    .line 29
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    const/4 v1, 0x3

    const-string v5, "COMPROMISED"

    invoke-direct {v0, v5, v1, v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->COMPROMISED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    .line 30
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    const/4 v1, 0x4

    const-string v6, "RESET_REQUIRED"

    invoke-direct {v0, v6, v1, v6}, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->RESET_REQUIRED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    .line 31
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    const/4 v1, 0x5

    const-string v7, "FORCE_CHANGE_PASSWORD"

    invoke-direct {v0, v7, v1, v7}, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->FORCE_CHANGE_PASSWORD:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    .line 24
    sget-object v8, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->UNCONFIRMED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    sget-object v9, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->CONFIRMED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    sget-object v10, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->ARCHIVED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    sget-object v11, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->COMPROMISED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    sget-object v12, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->RESET_REQUIRED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    sget-object v13, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->FORCE_CHANGE_PASSWORD:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    filled-new-array/range {v8 .. v13}, [Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->$VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    .line 46
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->enumMap:Ljava/util/Map;

    .line 47
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->UNCONFIRMED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 48
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->CONFIRMED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    invoke-interface {v0, v3, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 49
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->ARCHIVED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    invoke-interface {v0, v4, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 50
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->COMPROMISED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    invoke-interface {v0, v5, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 51
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->RESET_REQUIRED:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    invoke-interface {v0, v6, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 52
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->FORCE_CHANGE_PASSWORD:Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    invoke-interface {v0, v7, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 53
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
    iput-object p3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->value:Ljava/lang/String;

    .line 37
    return-void
.end method

.method public static fromValue(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;
    .locals 3
    .param p0, "value"    # Ljava/lang/String;

    .line 62
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 64
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->enumMap:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 65
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->enumMap:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    return-object v0

    .line 67
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Cannot create enum from "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " value!"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 63
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Value cannot be null or empty!"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 24
    const-class v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;
    .locals 1

    .line 24
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->$VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    invoke-virtual {v0}, [Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .line 41
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UserStatusType;->value:Ljava/lang/String;

    return-object v0
.end method
