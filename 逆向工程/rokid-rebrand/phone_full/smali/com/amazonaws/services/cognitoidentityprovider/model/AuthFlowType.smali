.class public final enum Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;
.super Ljava/lang/Enum;
.source "AuthFlowType.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

.field public static final enum ADMIN_NO_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

.field public static final enum ADMIN_USER_PASSWORD_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

.field public static final enum CUSTOM_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

.field public static final enum REFRESH_TOKEN:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

.field public static final enum REFRESH_TOKEN_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

.field public static final enum USER_PASSWORD_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

.field public static final enum USER_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

.field private static final enumMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private value:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 16

    .line 26
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    const/4 v1, 0x0

    const-string v2, "USER_SRP_AUTH"

    invoke-direct {v0, v2, v1, v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->USER_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    .line 27
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    const/4 v1, 0x1

    const-string v3, "REFRESH_TOKEN_AUTH"

    invoke-direct {v0, v3, v1, v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->REFRESH_TOKEN_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    .line 28
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    const/4 v1, 0x2

    const-string v4, "REFRESH_TOKEN"

    invoke-direct {v0, v4, v1, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->REFRESH_TOKEN:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    .line 29
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    const/4 v1, 0x3

    const-string v5, "CUSTOM_AUTH"

    invoke-direct {v0, v5, v1, v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->CUSTOM_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    .line 30
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    const/4 v1, 0x4

    const-string v6, "ADMIN_NO_SRP_AUTH"

    invoke-direct {v0, v6, v1, v6}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->ADMIN_NO_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    .line 31
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    const/4 v1, 0x5

    const-string v7, "USER_PASSWORD_AUTH"

    invoke-direct {v0, v7, v1, v7}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->USER_PASSWORD_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    .line 32
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    const/4 v1, 0x6

    const-string v8, "ADMIN_USER_PASSWORD_AUTH"

    invoke-direct {v0, v8, v1, v8}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->ADMIN_USER_PASSWORD_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    .line 24
    sget-object v9, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->USER_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    sget-object v10, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->REFRESH_TOKEN_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    sget-object v11, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->REFRESH_TOKEN:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    sget-object v12, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->CUSTOM_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    sget-object v13, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->ADMIN_NO_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    sget-object v14, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->USER_PASSWORD_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    sget-object v15, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->ADMIN_USER_PASSWORD_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    filled-new-array/range {v9 .. v15}, [Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->$VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    .line 47
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->enumMap:Ljava/util/Map;

    .line 48
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->USER_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 49
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->REFRESH_TOKEN_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    invoke-interface {v0, v3, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 50
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->REFRESH_TOKEN:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    invoke-interface {v0, v4, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 51
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->CUSTOM_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    invoke-interface {v0, v5, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 52
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->ADMIN_NO_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    invoke-interface {v0, v6, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 53
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->USER_PASSWORD_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    invoke-interface {v0, v7, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 54
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->ADMIN_USER_PASSWORD_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    invoke-interface {v0, v8, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 55
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
    iput-object p3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->value:Ljava/lang/String;

    .line 38
    return-void
.end method

.method public static fromValue(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;
    .locals 3
    .param p0, "value"    # Ljava/lang/String;

    .line 64
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 66
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->enumMap:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 67
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->enumMap:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    return-object v0

    .line 69
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

    .line 65
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Value cannot be null or empty!"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 24
    const-class v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;
    .locals 1

    .line 24
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->$VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    invoke-virtual {v0}, [Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .line 42
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthFlowType;->value:Ljava/lang/String;

    return-object v0
.end method
