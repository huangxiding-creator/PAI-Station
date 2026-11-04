.class public final enum Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;
.super Ljava/lang/Enum;
.source "ChallengeNameType.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

.field public static final enum ADMIN_NO_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

.field public static final enum CUSTOM_CHALLENGE:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

.field public static final enum DEVICE_PASSWORD_VERIFIER:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

.field public static final enum DEVICE_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

.field public static final enum MFA_SETUP:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

.field public static final enum NEW_PASSWORD_REQUIRED:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

.field public static final enum PASSWORD_VERIFIER:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

.field public static final enum SELECT_MFA_TYPE:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

.field public static final enum SMS_MFA:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

.field public static final enum SOFTWARE_TOKEN_MFA:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

.field private static final enumMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private value:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 22

    .line 26
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    const/4 v1, 0x0

    const-string v2, "SMS_MFA"

    invoke-direct {v0, v2, v1, v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->SMS_MFA:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    .line 27
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    const/4 v1, 0x1

    const-string v3, "SOFTWARE_TOKEN_MFA"

    invoke-direct {v0, v3, v1, v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->SOFTWARE_TOKEN_MFA:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    .line 28
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    const/4 v1, 0x2

    const-string v4, "SELECT_MFA_TYPE"

    invoke-direct {v0, v4, v1, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->SELECT_MFA_TYPE:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    .line 29
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    const/4 v1, 0x3

    const-string v5, "MFA_SETUP"

    invoke-direct {v0, v5, v1, v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->MFA_SETUP:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    .line 30
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    const/4 v1, 0x4

    const-string v6, "PASSWORD_VERIFIER"

    invoke-direct {v0, v6, v1, v6}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->PASSWORD_VERIFIER:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    .line 31
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    const/4 v1, 0x5

    const-string v7, "CUSTOM_CHALLENGE"

    invoke-direct {v0, v7, v1, v7}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->CUSTOM_CHALLENGE:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    .line 32
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    const/4 v1, 0x6

    const-string v8, "DEVICE_SRP_AUTH"

    invoke-direct {v0, v8, v1, v8}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->DEVICE_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    .line 33
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    const/4 v1, 0x7

    const-string v9, "DEVICE_PASSWORD_VERIFIER"

    invoke-direct {v0, v9, v1, v9}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->DEVICE_PASSWORD_VERIFIER:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    .line 34
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    const/16 v1, 0x8

    const-string v10, "ADMIN_NO_SRP_AUTH"

    invoke-direct {v0, v10, v1, v10}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->ADMIN_NO_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    .line 35
    new-instance v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    const/16 v1, 0x9

    const-string v11, "NEW_PASSWORD_REQUIRED"

    invoke-direct {v0, v11, v1, v11}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->NEW_PASSWORD_REQUIRED:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    .line 24
    sget-object v12, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->SMS_MFA:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    sget-object v13, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->SOFTWARE_TOKEN_MFA:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    sget-object v14, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->SELECT_MFA_TYPE:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    sget-object v15, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->MFA_SETUP:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    sget-object v16, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->PASSWORD_VERIFIER:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    sget-object v17, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->CUSTOM_CHALLENGE:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    sget-object v18, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->DEVICE_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    sget-object v19, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->DEVICE_PASSWORD_VERIFIER:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    sget-object v20, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->ADMIN_NO_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    sget-object v21, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->NEW_PASSWORD_REQUIRED:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    filled-new-array/range {v12 .. v21}, [Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->$VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    .line 50
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->enumMap:Ljava/util/Map;

    .line 51
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->SMS_MFA:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 52
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->SOFTWARE_TOKEN_MFA:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    invoke-interface {v0, v3, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 53
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->SELECT_MFA_TYPE:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    invoke-interface {v0, v4, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 54
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->MFA_SETUP:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    invoke-interface {v0, v5, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 55
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->PASSWORD_VERIFIER:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    invoke-interface {v0, v6, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 56
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->CUSTOM_CHALLENGE:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    invoke-interface {v0, v7, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 57
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->DEVICE_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    invoke-interface {v0, v8, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 58
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->DEVICE_PASSWORD_VERIFIER:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    invoke-interface {v0, v9, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 59
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->ADMIN_NO_SRP_AUTH:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    invoke-interface {v0, v10, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 60
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->enumMap:Ljava/util/Map;

    sget-object v1, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->NEW_PASSWORD_REQUIRED:Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    invoke-interface {v0, v11, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 61
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

    .line 39
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 40
    iput-object p3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->value:Ljava/lang/String;

    .line 41
    return-void
.end method

.method public static fromValue(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;
    .locals 3
    .param p0, "value"    # Ljava/lang/String;

    .line 70
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 72
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->enumMap:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 73
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->enumMap:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    return-object v0

    .line 75
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

    .line 71
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Value cannot be null or empty!"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 24
    const-class v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;
    .locals 1

    .line 24
    sget-object v0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->$VALUES:[Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    invoke-virtual {v0}, [Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .line 45
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->value:Ljava/lang/String;

    return-object v0
.end method
