.class Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/api/engines/MotorLPREngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "ProcessedPlateResult"
.end annotation


# instance fields
.field public processedPlate:Ljava/lang/String;

.field public status:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lcom/rokid/aicore/api/engines/MotorLPREngine$1;)V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;-><init>()V

    return-void
.end method
