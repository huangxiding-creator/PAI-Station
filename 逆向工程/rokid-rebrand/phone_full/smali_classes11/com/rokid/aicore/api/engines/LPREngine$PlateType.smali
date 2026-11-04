.class public final enum Lcom/rokid/aicore/api/engines/LPREngine$PlateType;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/api/engines/LPREngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "PlateType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/aicore/api/engines/LPREngine$PlateType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

.field public static final enum BLACK:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

.field public static final enum BLUE:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

.field public static final enum GREEN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

.field public static final enum TEMP:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

.field public static final enum UNKNOWN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

.field public static final enum WHITE:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

.field public static final enum YELLOW:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

.field public static final enum YELLOW_GREEN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;


# direct methods
.method private static synthetic $values()[Lcom/rokid/aicore/api/engines/LPREngine$PlateType;
    .locals 8

    sget-object v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->BLUE:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    sget-object v1, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->GREEN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    sget-object v2, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->YELLOW:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    sget-object v3, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->WHITE:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    sget-object v4, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->BLACK:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    sget-object v5, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->TEMP:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    sget-object v6, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->YELLOW_GREEN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    sget-object v7, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->UNKNOWN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    filled-new-array/range {v0 .. v7}, [Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    move-result-object v0

    return-object v0
.end method

.method public static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    const-string v1, "BLUE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->BLUE:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    new-instance v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    const-string v1, "GREEN"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->GREEN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    new-instance v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    const-string v1, "YELLOW"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->YELLOW:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    new-instance v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    const-string v1, "WHITE"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->WHITE:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    new-instance v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    const-string v1, "BLACK"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->BLACK:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    new-instance v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    const-string v1, "TEMP"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->TEMP:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    new-instance v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    const-string v1, "YELLOW_GREEN"

    const/4 v2, 0x6

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->YELLOW_GREEN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    new-instance v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    const-string v1, "UNKNOWN"

    const/4 v2, 0x7

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->UNKNOWN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    invoke-static {}, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->$values()[Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->$VALUES:[Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

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

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/aicore/api/engines/LPREngine$PlateType;
    .locals 1

    const-class v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    return-object p0
.end method

.method public static values()[Lcom/rokid/aicore/api/engines/LPREngine$PlateType;
    .locals 1

    sget-object v0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->$VALUES:[Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    invoke-virtual {v0}, [Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    return-object v0
.end method
