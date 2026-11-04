.class public final enum Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/api/callback/result/LPRResult;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "PlateStatus"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

.field public static final enum EMPTY:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

.field public static final enum INVALID_RECT:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

.field public static final enum INVALID_RULE:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

.field public static final enum VALID:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;


# direct methods
.method private static synthetic $values()[Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;
    .locals 4

    sget-object v0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->EMPTY:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    sget-object v1, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->INVALID_RULE:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    sget-object v2, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->INVALID_RECT:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    sget-object v3, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->VALID:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    filled-new-array {v0, v1, v2, v3}, [Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    move-result-object v0

    return-object v0
.end method

.method public static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    const-string v1, "EMPTY"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->EMPTY:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    new-instance v0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    const-string v1, "INVALID_RULE"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->INVALID_RULE:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    new-instance v0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    const-string v1, "INVALID_RECT"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->INVALID_RECT:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    new-instance v0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    const-string v1, "VALID"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->VALID:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    invoke-static {}, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->$values()[Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->$VALUES:[Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;
    .locals 1

    const-class v0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    return-object p0
.end method

.method public static values()[Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;
    .locals 1

    sget-object v0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->$VALUES:[Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    invoke-virtual {v0}, [Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    return-object v0
.end method
