.class public final enum Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;
.super Ljava/lang/Enum;
.source "EventFilterType.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

.field public static final enum PASSWORD_CHANGE:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

.field public static final enum SIGN_IN:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

.field public static final enum SIGN_UP:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

.field private static final enumMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private value:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .line 26
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    const/4 v1, 0x0

    const-string v2, "SIGN_IN"

    invoke-direct {v0, v2, v1, v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->SIGN_IN:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    .line 27
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    const/4 v1, 0x1

    const-string v3, "PASSWORD_CHANGE"

    invoke-direct {v0, v3, v1, v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->PASSWORD_CHANGE:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    .line 28
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    const/4 v1, 0x2

    const-string v4, "SIGN_UP"

    invoke-direct {v0, v4, v1, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->SIGN_UP:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    .line 24
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->SIGN_IN:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->PASSWORD_CHANGE:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    sget-object v5, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->SIGN_UP:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    filled-new-array {v0, v1, v5}, [Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->$VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    .line 43
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->enumMap:Ljava/util/Map;

    .line 44
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->SIGN_IN:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 45
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->PASSWORD_CHANGE:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    invoke-interface {v0, v3, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 46
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->SIGN_UP:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    invoke-interface {v0, v4, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 47
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

    .line 32
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 33
    iput-object p3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->value:Ljava/lang/String;

    .line 34
    return-void
.end method

.method public static fromValue(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;
    .locals 3
    .param p0, "value"    # Ljava/lang/String;

    .line 56
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 58
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->enumMap:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 59
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->enumMap:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    return-object v0

    .line 61
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

    .line 57
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Value cannot be null or empty!"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 24
    const-class v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;
    .locals 1

    .line 24
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->$VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    invoke-virtual {v0}, [Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .line 38
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFilterType;->value:Ljava/lang/String;

    return-object v0
.end method
