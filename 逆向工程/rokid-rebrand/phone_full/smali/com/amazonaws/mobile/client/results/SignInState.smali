.class public final enum Lcom/amazonaws/mobile/client/results/SignInState;
.super Ljava/lang/Enum;
.source "SignInState.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/mobile/client/results/SignInState;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/mobile/client/results/SignInState;

.field public static final enum ADMIN_NO_SRP_AUTH:Lcom/amazonaws/mobile/client/results/SignInState;

.field public static final enum CUSTOM_CHALLENGE:Lcom/amazonaws/mobile/client/results/SignInState;

.field public static final enum DEVICE_PASSWORD_VERIFIER:Lcom/amazonaws/mobile/client/results/SignInState;

.field public static final enum DEVICE_SRP_AUTH:Lcom/amazonaws/mobile/client/results/SignInState;

.field public static final enum DONE:Lcom/amazonaws/mobile/client/results/SignInState;

.field public static final enum NEW_PASSWORD_REQUIRED:Lcom/amazonaws/mobile/client/results/SignInState;

.field public static final enum PASSWORD_VERIFIER:Lcom/amazonaws/mobile/client/results/SignInState;

.field public static final enum SMS_MFA:Lcom/amazonaws/mobile/client/results/SignInState;

.field public static final enum UNKNOWN:Lcom/amazonaws/mobile/client/results/SignInState;


# instance fields
.field private final serviceText:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 12

    .line 27
    new-instance v0, Lcom/amazonaws/mobile/client/results/SignInState;

    const/4 v1, 0x0

    const-string v2, "CONFIRMATION_CODE"

    const-string v3, "SMS_MFA"

    invoke-direct {v0, v3, v1, v2}, Lcom/amazonaws/mobile/client/results/SignInState;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/mobile/client/results/SignInState;->SMS_MFA:Lcom/amazonaws/mobile/client/results/SignInState;

    .line 32
    new-instance v0, Lcom/amazonaws/mobile/client/results/SignInState;

    const-string v1, "PASSWORD_VERIFIER"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/mobile/client/results/SignInState;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/mobile/client/results/SignInState;->PASSWORD_VERIFIER:Lcom/amazonaws/mobile/client/results/SignInState;

    .line 37
    new-instance v0, Lcom/amazonaws/mobile/client/results/SignInState;

    const-string v1, "CUSTOM_CHALLENGE"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/mobile/client/results/SignInState;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/mobile/client/results/SignInState;->CUSTOM_CHALLENGE:Lcom/amazonaws/mobile/client/results/SignInState;

    .line 42
    new-instance v0, Lcom/amazonaws/mobile/client/results/SignInState;

    const-string v1, "DEVICE_SRP_AUTH"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/mobile/client/results/SignInState;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/mobile/client/results/SignInState;->DEVICE_SRP_AUTH:Lcom/amazonaws/mobile/client/results/SignInState;

    .line 47
    new-instance v0, Lcom/amazonaws/mobile/client/results/SignInState;

    const-string v1, "DEVICE_PASSWORD_VERIFIER"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/mobile/client/results/SignInState;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/mobile/client/results/SignInState;->DEVICE_PASSWORD_VERIFIER:Lcom/amazonaws/mobile/client/results/SignInState;

    .line 52
    new-instance v0, Lcom/amazonaws/mobile/client/results/SignInState;

    const-string v1, "ADMIN_NO_SRP_AUTH"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/mobile/client/results/SignInState;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/mobile/client/results/SignInState;->ADMIN_NO_SRP_AUTH:Lcom/amazonaws/mobile/client/results/SignInState;

    .line 57
    new-instance v0, Lcom/amazonaws/mobile/client/results/SignInState;

    const-string v1, "NEW_PASSWORD_REQUIRED"

    const/4 v2, 0x6

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/mobile/client/results/SignInState;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/mobile/client/results/SignInState;->NEW_PASSWORD_REQUIRED:Lcom/amazonaws/mobile/client/results/SignInState;

    .line 62
    new-instance v0, Lcom/amazonaws/mobile/client/results/SignInState;

    const/4 v1, 0x7

    const-string v2, "This means the flow is complete."

    const-string v3, "DONE"

    invoke-direct {v0, v3, v1, v2}, Lcom/amazonaws/mobile/client/results/SignInState;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/mobile/client/results/SignInState;->DONE:Lcom/amazonaws/mobile/client/results/SignInState;

    .line 67
    new-instance v0, Lcom/amazonaws/mobile/client/results/SignInState;

    const-string v1, "UNKNOWN"

    const/16 v2, 0x8

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/mobile/client/results/SignInState;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/mobile/client/results/SignInState;->UNKNOWN:Lcom/amazonaws/mobile/client/results/SignInState;

    .line 23
    sget-object v3, Lcom/amazonaws/mobile/client/results/SignInState;->SMS_MFA:Lcom/amazonaws/mobile/client/results/SignInState;

    sget-object v4, Lcom/amazonaws/mobile/client/results/SignInState;->PASSWORD_VERIFIER:Lcom/amazonaws/mobile/client/results/SignInState;

    sget-object v5, Lcom/amazonaws/mobile/client/results/SignInState;->CUSTOM_CHALLENGE:Lcom/amazonaws/mobile/client/results/SignInState;

    sget-object v6, Lcom/amazonaws/mobile/client/results/SignInState;->DEVICE_SRP_AUTH:Lcom/amazonaws/mobile/client/results/SignInState;

    sget-object v7, Lcom/amazonaws/mobile/client/results/SignInState;->DEVICE_PASSWORD_VERIFIER:Lcom/amazonaws/mobile/client/results/SignInState;

    sget-object v8, Lcom/amazonaws/mobile/client/results/SignInState;->ADMIN_NO_SRP_AUTH:Lcom/amazonaws/mobile/client/results/SignInState;

    sget-object v9, Lcom/amazonaws/mobile/client/results/SignInState;->NEW_PASSWORD_REQUIRED:Lcom/amazonaws/mobile/client/results/SignInState;

    sget-object v10, Lcom/amazonaws/mobile/client/results/SignInState;->DONE:Lcom/amazonaws/mobile/client/results/SignInState;

    sget-object v11, Lcom/amazonaws/mobile/client/results/SignInState;->UNKNOWN:Lcom/amazonaws/mobile/client/results/SignInState;

    filled-new-array/range {v3 .. v11}, [Lcom/amazonaws/mobile/client/results/SignInState;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/mobile/client/results/SignInState;->$VALUES:[Lcom/amazonaws/mobile/client/results/SignInState;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p3, "serviceText"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 71
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 72
    iput-object p3, p0, Lcom/amazonaws/mobile/client/results/SignInState;->serviceText:Ljava/lang/String;

    .line 73
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/mobile/client/results/SignInState;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 23
    const-class v0, Lcom/amazonaws/mobile/client/results/SignInState;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/mobile/client/results/SignInState;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/mobile/client/results/SignInState;
    .locals 1

    .line 23
    sget-object v0, Lcom/amazonaws/mobile/client/results/SignInState;->$VALUES:[Lcom/amazonaws/mobile/client/results/SignInState;

    invoke-virtual {v0}, [Lcom/amazonaws/mobile/client/results/SignInState;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/mobile/client/results/SignInState;

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/String;)Z
    .locals 1
    .param p1, "serviceText"    # Ljava/lang/String;

    .line 76
    iget-object v0, p0, Lcom/amazonaws/mobile/client/results/SignInState;->serviceText:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method
