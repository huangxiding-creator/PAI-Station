.class public final enum Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;
.super Ljava/lang/Enum;
.source "TimeUnitsType.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

.field public static final enum Days:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

.field public static final enum Hours:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

.field public static final enum Minutes:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

.field public static final enum Seconds:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

.field private static final enumMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private value:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .line 26
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    const-string v1, "Seconds"

    const/4 v2, 0x0

    const-string v3, "seconds"

    invoke-direct {v0, v1, v2, v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->Seconds:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    .line 27
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    const-string v1, "Minutes"

    const/4 v2, 0x1

    const-string v4, "minutes"

    invoke-direct {v0, v1, v2, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->Minutes:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    .line 28
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    const-string v1, "Hours"

    const/4 v2, 0x2

    const-string v5, "hours"

    invoke-direct {v0, v1, v2, v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->Hours:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    .line 29
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    const-string v1, "Days"

    const/4 v2, 0x3

    const-string v6, "days"

    invoke-direct {v0, v1, v2, v6}, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->Days:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    .line 24
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->Seconds:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->Minutes:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    sget-object v2, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->Hours:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    sget-object v7, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->Days:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    filled-new-array {v0, v1, v2, v7}, [Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->$VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    .line 44
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->enumMap:Ljava/util/Map;

    .line 45
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->Seconds:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    invoke-interface {v0, v3, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 46
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->Minutes:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    invoke-interface {v0, v4, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 47
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->Hours:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    invoke-interface {v0, v5, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 48
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->Days:Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    invoke-interface {v0, v6, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 49
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

    .line 33
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 34
    iput-object p3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->value:Ljava/lang/String;

    .line 35
    return-void
.end method

.method public static fromValue(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;
    .locals 3
    .param p0, "value"    # Ljava/lang/String;

    .line 58
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 60
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->enumMap:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 61
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->enumMap:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    return-object v0

    .line 63
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

    .line 59
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Value cannot be null or empty!"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 24
    const-class v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;
    .locals 1

    .line 24
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->$VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    invoke-virtual {v0}, [Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .line 39
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->value:Ljava/lang/String;

    return-object v0
.end method
