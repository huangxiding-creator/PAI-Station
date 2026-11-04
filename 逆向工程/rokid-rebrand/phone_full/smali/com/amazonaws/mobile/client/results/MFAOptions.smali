.class public final enum Lcom/amazonaws/mobile/client/results/MFAOptions;
.super Ljava/lang/Enum;
.source "MFAOptions.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/mobile/client/results/MFAOptions;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/mobile/client/results/MFAOptions;

.field public static final enum SMS_MFA:Lcom/amazonaws/mobile/client/results/MFAOptions;

.field public static final enum TOTP_MFA:Lcom/amazonaws/mobile/client/results/MFAOptions;


# instance fields
.field private final serviceText:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 23
    new-instance v0, Lcom/amazonaws/mobile/client/results/MFAOptions;

    const-string v1, "SMS_MFA"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/mobile/client/results/MFAOptions;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/mobile/client/results/MFAOptions;->SMS_MFA:Lcom/amazonaws/mobile/client/results/MFAOptions;

    .line 24
    new-instance v0, Lcom/amazonaws/mobile/client/results/MFAOptions;

    const-string v1, "TOTP_MFA"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2, v1}, Lcom/amazonaws/mobile/client/results/MFAOptions;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/amazonaws/mobile/client/results/MFAOptions;->TOTP_MFA:Lcom/amazonaws/mobile/client/results/MFAOptions;

    .line 22
    sget-object v0, Lcom/amazonaws/mobile/client/results/MFAOptions;->SMS_MFA:Lcom/amazonaws/mobile/client/results/MFAOptions;

    sget-object v1, Lcom/amazonaws/mobile/client/results/MFAOptions;->TOTP_MFA:Lcom/amazonaws/mobile/client/results/MFAOptions;

    filled-new-array {v0, v1}, [Lcom/amazonaws/mobile/client/results/MFAOptions;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/mobile/client/results/MFAOptions;->$VALUES:[Lcom/amazonaws/mobile/client/results/MFAOptions;

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

    .line 28
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 29
    iput-object p3, p0, Lcom/amazonaws/mobile/client/results/MFAOptions;->serviceText:Ljava/lang/String;

    .line 30
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/mobile/client/results/MFAOptions;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 22
    const-class v0, Lcom/amazonaws/mobile/client/results/MFAOptions;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/mobile/client/results/MFAOptions;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/mobile/client/results/MFAOptions;
    .locals 1

    .line 22
    sget-object v0, Lcom/amazonaws/mobile/client/results/MFAOptions;->$VALUES:[Lcom/amazonaws/mobile/client/results/MFAOptions;

    invoke-virtual {v0}, [Lcom/amazonaws/mobile/client/results/MFAOptions;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/mobile/client/results/MFAOptions;

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/String;)Z
    .locals 1
    .param p1, "serviceText"    # Ljava/lang/String;

    .line 33
    iget-object v0, p0, Lcom/amazonaws/mobile/client/results/MFAOptions;->serviceText:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public getServiceText()Ljava/lang/String;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/amazonaws/mobile/client/results/MFAOptions;->serviceText:Ljava/lang/String;

    return-object v0
.end method
