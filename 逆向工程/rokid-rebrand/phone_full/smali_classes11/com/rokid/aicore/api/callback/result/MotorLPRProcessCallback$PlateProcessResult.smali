.class public Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback$PlateProcessResult;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "PlateProcessResult"
.end annotation


# instance fields
.field private processedPlate:Ljava/lang/String;

.field private status:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;


# direct methods
.method public constructor <init>(Ljava/lang/String;Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback$PlateProcessResult;->processedPlate:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback$PlateProcessResult;->status:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    return-void
.end method


# virtual methods
.method public getProcessedPlate()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback$PlateProcessResult;->processedPlate:Ljava/lang/String;

    return-object v0
.end method

.method public getStatus()Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback$PlateProcessResult;->status:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    return-object v0
.end method

.method public setProcessedPlate(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback$PlateProcessResult;->processedPlate:Ljava/lang/String;

    return-void
.end method

.method public setStatus(Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback$PlateProcessResult;->status:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    return-void
.end method
